package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * ContattiServlet
 * -------------------------
 * Gestisce l’invio del form di contatto.
 * - Recupera i dati inseriti dall’utente
 * - Esegue una validazione minima lato server
 * - In caso di errori torna alla pagina contatti.jsp
 * - In caso di successo mostra la pagina di conferma
 *
 * NOTA: qui potresti anche salvare i dati nel DB o inviare email.
 */
@WebServlet("/contatti")
public class ContattiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) RECUPERO PARAMETRI DAL FORM
         * ---------------------------------
         * I parametri arrivano dalla pagina contatti.jsp tramite POST.
         */
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String messaggio = request.getParameter("messaggio");

        /**
         * ⭐ 2) VALIDAZIONE MINIMA LATO SERVER
         * ------------------------------------
         * Controllo che i campi non siano vuoti.
         * In caso di errore, imposto attributi di errore
         * e torno alla pagina contatti.jsp.
         */
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

        // Se ci sono errori → torno alla pagina contatti
        if (hasError) {
            request.getRequestDispatcher("/pagine/contatti.jsp").forward(request, response);
            return;
        }

        /**
         * ⭐ 3) EVENTUALE LOGICA DI BUSINESS
         * ----------------------------------
         * Qui potresti:
         * - salvare il messaggio nel database
         * - inviare una email
         * - registrare un log
         *
         * Per ora stampiamo su console.
         */
        System.out.println("Nuovo messaggio da: " + nome + " (" + email + ")");
        System.out.println("Testo: " + messaggio);

        /**
         * ⭐ 4) PASSAGGIO DATI ALLA PAGINA DI CONFERMA
         * --------------------------------------------
         * Uso request.setAttribute() per mostrare i dati
         * nella JSP confermaContatto.jsp.
         */
        request.setAttribute("nome", nome);
        request.setAttribute("email", email);
        request.setAttribute("messaggio", messaggio);

        /**
         * ⭐ 5) FORWARD ALLA PAGINA DI CONFERMA
         * -------------------------------------
         * Mostro la pagina confermaContatto.jsp
         * senza cambiare URL (forward).
         */
        request.getRequestDispatcher("/pagine/confermaContatto.jsp").forward(request, response);
    }
}
