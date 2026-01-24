package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminLogoutServlet
 * ------------------
 * Invalida la sessione e reindirizza al login admin.
 */
@WebServlet("/admin/logout")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // ✅ logout completo
        }

        // ✅ redirect al login admin
        response.sendRedirect(request.getContextPath() + "/admin/login");
    }
}
