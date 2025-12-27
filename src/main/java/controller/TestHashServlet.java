package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.PasswordUtils;

import java.io.IOException;

@WebServlet("/test/hash")
public class TestHashServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Password da hashare
        String plain = "admin123";

        // ✅ Genera hash
        String hash = PasswordUtils.hashPassword(plain);

        // ✅ Stampa in console
        System.out.println("HASH GENERATO PER \"" + plain + "\": " + hash);

        // ✅ Mostra anche nel browser (comodo)
        response.setContentType("text/plain");
        response.getWriter().println("Password: " + plain);
        response.getWriter().println("Hash SHA-256:");
        response.getWriter().println(hash);
    }
}
