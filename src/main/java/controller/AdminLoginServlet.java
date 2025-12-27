package controller;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;
import util.PasswordUtils;

import java.io.IOException;

/**
 * AdminLoginServlet
 * -----------------
 * Gestisce il login dell'amministratore.
 * - GET  → mostra la pagina di login admin
 * - POST → verifica credenziali e ruolo (role = 1)
 */
@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Se l'admin è già loggato → vai alla dashboard
        HttpSession session = request.getSession(false);
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (u != null && u.getRole() == 1) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        request.getRequestDispatcher("/pagine/adminLogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Servlet chiamata con email: " + email);

        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            request.setAttribute("error", "Inserisci email e password");
            request.getRequestDispatcher("/pagine/adminLogin.jsp").forward(request, response);
            return;
        }

        UtenteDAO dao = new UtenteDAO();
        Utente admin = dao.findByEmail(email);

        // Controllo credenziali + ruolo admin
        if (admin == null ||
        	    admin.getRole() != 1 ||
        	    !PasswordUtils.verifyPassword(password, admin.getPassword())) {

        	    request.setAttribute("error", "Credenziali non valide o non sei un amministratore");
        	    request.getRequestDispatcher("/pagine/adminLogin.jsp").forward(request, response);
        	    return;
        	}


        // ✅ Login riuscito → salva in sessione
        HttpSession session = request.getSession(true);
        session.setAttribute("utente", admin);

        // ✅ Redirect alla dashboard admin
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
