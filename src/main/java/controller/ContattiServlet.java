package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/contatti")
public class ContattiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupero parametri dal form
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String messaggio = request.getParameter("messaggio");

        // Validazione minima lato server
        boolean hasError = false;
        if (nome == null || nome.trim().isEmpty()) {
            request.setAttribute("errorNome", "Il nome è obbligatorio.");
            hasError = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorEmail", "L'email è obbligatoria.");
            hasError = true;
        }
        if (messaggio == null || messaggio.trim().isEmpty()) {
            request.setAttribute("errorMessaggio", "Il messaggio è obbligatorio.");
            hasError = true;
        }

        if (hasError) {
            // Torno alla pagina contatti con errori
            request.getRequestDispatcher("/pagine/contatti.jsp").forward(request, response);
            return;
        }

        // Qui potresti salvare su DB o inviare email
        System.out.println("Nuovo messaggio da: " + nome + " (" + email + ")");
        System.out.println("Testo: " + messaggio);

        // Passo i dati alla pagina di conferma
        request.setAttribute("nome", nome);
        request.setAttribute("email", email);
        request.setAttribute("messaggio", messaggio);

        // Forward alla JSP di conferma
        request.getRequestDispatcher("/pagine/confermaContatto.jsp").forward(request, response);
    }
}
