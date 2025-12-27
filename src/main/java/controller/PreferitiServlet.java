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

        HttpSession session = request.getSession(false);
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        int prodottoId = Integer.parseInt(request.getParameter("id_prodotto"));

        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO dao = new PreferitiDAO(conn);
            dao.addPreferito(u.getId(), prodottoId);
            response.sendRedirect(request.getContextPath() + "/catalogo?success=preferito");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/catalogo?error=preferito");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO dao = new PreferitiDAO(conn);
            request.setAttribute("listaPreferiti", dao.findByUtente(u.getId()));
            request.getRequestDispatcher("/pagine/preferiti.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/catalogo?error=preferiti");
        }
    }
}
