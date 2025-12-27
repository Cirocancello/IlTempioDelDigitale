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
 * LoginServlet.java
 * -----------------
 * Gestisce il login utente basato sullo schema td.utente.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 🔹 Validazione input
        if (!Validator.isValidEmail(email) || Validator.isEmpty(password)) {
            request.setAttribute("error", "Email o password non valide");
            request.getRequestDispatcher("/pagine/login.jsp").forward(request, response);
            return;
        }

        UtenteDAO dao = new UtenteDAO();
        Utente u = dao.findByEmail(email); // recupera utente dal DB

        // 🔹 Verifica credenziali con hash
        if (u != null && PasswordUtils.verifyPassword(password, u.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("utente", u);
            session.setAttribute("utenteId", u.getId());

            // Gestione ruoli (0 = user, 1 = admin)
            if (u.getRole() == 1) {
                response.sendRedirect(request.getContextPath() + "/admin/prodotti");
            } else {
                response.sendRedirect(request.getContextPath() + "/profile");
            }
        } else {
            request.setAttribute("error", "Credenziali non corrette");
            request.getRequestDispatcher("/pagine/login.jsp").forward(request, response);
        }
    }
}
