package controller;

import dao.UtenteDAO;
import model.Utente;
import util.Validator;
import util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * LoginServlet
 * -------------------------
 * Gestisce il login degli utenti.
 * - Valida l'input
 * - Recupera l'utente dal DB
 * - Verifica la password tramite hashing
 * - Crea la sessione
 * - Reindirizza in base al ruolo (user/admin)
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ 1) Recupero parametri dal form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ⭐ 2) Validazione lato server
        // Evita email vuote, formati errati o password mancanti
        if (!Validator.isValidEmail(email) || Validator.isEmpty(password)) {
            request.setAttribute("error", "Email o password non valide");
            request.getRequestDispatcher("/pagine/login.jsp").forward(request, response);
            return;
        }

        // ⭐ 3) Recupero utente dal database tramite email
        UtenteDAO dao = new UtenteDAO();
        Utente u = dao.findByEmail(email);

        // ⭐ 4) Verifica credenziali
        // - L'utente deve esistere
        // - La password inserita deve corrispondere all'hash salvato
        if (u != null && PasswordUtils.verifyPassword(password, u.getPassword())) {

            // ⭐ 5) Creazione sessione
            HttpSession session = request.getSession();

            // Salvo l'intero oggetto utente
            session.setAttribute("utente", u);

            // Salvo ID e ruolo per comodità
            session.setAttribute("utenteId", u.getId());
            session.setAttribute("role", u.getRole());

            // Token di autenticazione richiesto dal prof
            session.setAttribute("auth", true);

            // ⭐ 6) Redirect in base al ruolo
            if (u.getRole() == 1) {
                response.sendRedirect(request.getContextPath() + "/admin/adminDashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/profile");
            }

        } else {
            // ⭐ Credenziali errate → ritorno al login con messaggio
            request.setAttribute("error", "Credenziali non corrette");
            request.getRequestDispatcher("/pagine/login.jsp").forward(request, response);
        }
    }
}
