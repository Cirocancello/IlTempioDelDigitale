package controller.admin;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;
import util.PasswordUtils;

import java.io.IOException;

/**
 * AdminLoginServlet
 * ------------------------------------------------------------
 * Gestisce l’autenticazione dell’amministratore.
 *
 * Funzionalità:
 *  - Mostra il form di login (GET)
 *  - Verifica credenziali admin (POST)
 *  - Salva l’utente in sessione
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → DAO → Model → JSP)
 *  - Sessione per mantenere l’utente autenticato
 */
@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    // ======================================================================
    // ⭐ GET → Mostra il form di login admin
    // ======================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupero sessione esistente (se c’è)
        HttpSession session = request.getSession(false);
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        // Se l’utente è già loggato come admin → vai alla dashboard
        if (u != null && u.getRole() == 1) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Mostra la pagina di login
        request.getRequestDispatcher("/pagine/admin/adminLogin.jsp")
               .forward(request, response);
    }

    // ======================================================================
    // ⭐ POST → Verifica credenziali admin
    // ======================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lettura parametri dal form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ⭐ Validazione campi obbligatori
        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            request.setAttribute("error", "Inserisci email e password");
            request.getRequestDispatcher("/pagine/admin/adminLogin.jsp")
                   .forward(request, response);
            return;
        }

        // ⭐ Recupero utente dal database
        UtenteDAO dao = new UtenteDAO();
        Utente admin = dao.findByEmail(email.trim());

        // ⭐ Controlli fondamentali:
        // 1) L’utente esiste
        // 2) Ha ruolo admin (role = 1)
        // 3) La password è corretta (hash + salt)
        if (admin == null ||
            admin.getRole() != 1 ||
            !PasswordUtils.verifyPassword(password.trim(), admin.getPassword())) {

            request.setAttribute("error", "Credenziali non valide o non sei un amministratore");
            request.getRequestDispatcher("/pagine/admin/adminLogin.jsp")
                   .forward(request, response);
            return;
        }

        // ⭐ Login riuscito → salvo i dati in sessione
        HttpSession session = request.getSession(true);
        session.setAttribute("utente", admin);   // oggetto utente completo
        session.setAttribute("auth", true);      // flag autenticazione
        session.setAttribute("role", admin.getRole()); // ruolo (1 = admin)

        // ⭐ Redirect alla dashboard admin
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
