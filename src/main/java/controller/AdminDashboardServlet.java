package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;

import java.io.IOException;

/**
 * AdminDashboardServlet
 * ---------------------
 * Mostra la dashboard principale dell'area admin.
 * Accesso consentito solo ad admin (role == 1).
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Qui puoi passare eventuali statistiche alla dashboard
        // (es: numero utenti, numero ordini, ecc.)

        request.getRequestDispatcher("/pagine/adminDashboard.jsp").forward(request, response);
    }
}
