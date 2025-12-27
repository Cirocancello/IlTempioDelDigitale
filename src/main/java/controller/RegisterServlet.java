package controller;

import java.io.IOException;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;
import util.PasswordUtils;
import util.Validator;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recupero parametri dal form
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email") != null ? request.getParameter("email").trim().toLowerCase() : "";
        String password = request.getParameter("password");
        String provincia = request.getParameter("provincia");
        String cap = request.getParameter("cap");
        String via = request.getParameter("via");
        String civico = request.getParameter("civico");
        String note = request.getParameter("note");

        // 🔹 Validazione input
        if (Validator.isEmpty(nome) || Validator.isEmpty(cognome) || 
            !Validator.isValidEmail(email) || Validator.isEmpty(password) ||
            Validator.isEmpty(provincia) || Validator.isEmpty(cap) ||
            Validator.isEmpty(via) || Validator.isEmpty(civico)) {
            
            request.setAttribute("error", "Compila correttamente tutti i campi obbligatori");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
            return;
        }

        // 🔹 Hashing password
        String hashedPassword = PasswordUtils.hashPassword(password);

        // 🔹 Creazione utente (role=0 → utente normale)
        Utente u = new Utente(
            0,
            nome,
            cognome,
            email,
            hashedPassword,
            false,
            "https://via.placeholder.com/300x225",
            provincia,
            cap,
            via,
            civico,
            note,
            0
        );

        UtenteDAO dao = new UtenteDAO();

        // 🔹 Controllo email già registrata
        if (dao.existsByEmail(email)) {
            request.setAttribute("error", "Registrazione fallita: email già registrata");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
            return;
        }

        // 🔹 Registrazione
        if (dao.register(u)) {
            // Dopo registrazione → redirect diretto alla registrazioneSuccesso.jsp
        	response.sendRedirect(request.getContextPath() + "/pagine/registrazioneSuccesso.jsp");

        } else {
            request.setAttribute("error", "Errore durante la registrazione, riprova");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
        }
    }
}
