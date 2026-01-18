package controller;

import dao.PreferitiDAO;
import model.Utente;
import db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/preferiti")
public class PreferitiServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CONTROLLO TOKEN 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        Utente u = (Utente) session.getAttribute("utente");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int prodottoId = Integer.parseInt(request.getParameter("id_prodotto"));

        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO dao = new PreferitiDAO(conn);

            if ("remove".equalsIgnoreCase(action)) {
                // 🗑️ RIMOZIONE
                dao.removePreferito(u.getId(), prodottoId);
            } else {
                // ❤️ AGGIUNTA
                dao.addPreferito(u.getId(), prodottoId);
            }

            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=preferiti");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CONTROLLO TOKEN 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        Utente u = (Utente) session.getAttribute("utente");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO dao = new PreferitiDAO(conn);
            request.setAttribute("listaPreferiti", dao.findByUtente(u.getId()));
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=preferiti");
        }
    }
}
