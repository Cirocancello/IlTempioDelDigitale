package controller;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;
import util.PasswordUtils;
import util.TokenUtils;

import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            request.setAttribute("error", "Inserisci email e password");
            request.getRequestDispatcher("/pagine/adminLogin.jsp").forward(request, response);
            return;
        }

        UtenteDAO dao = new UtenteDAO();
        Utente admin = dao.findByEmail(email.trim());

        if (admin == null ||
            admin.getRole() != 1 ||
            !PasswordUtils.verifyPassword(password.trim(), admin.getPassword())) {

            request.setAttribute("error", "Credenziali non valide o non sei un amministratore");
            request.getRequestDispatcher("/pagine/adminLogin.jsp").forward(request, response);
            return;
        }

        // GENERA TOKEN SICURO
        String token = TokenUtils.generateToken();

        // SALVA TOKEN NEL DB
        dao.updateToken(admin.getId(), token);

        // SALVA IN SESSIONE
        HttpSession session = request.getSession(true);
        session.setAttribute("utente", admin);
        session.setAttribute("auth", true);
        session.setAttribute("role", admin.getRole());
        session.setAttribute("token", token);

        // REDIRECT ALLA DASHBOARD
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
