package controller;

import dao.OrdineDAO;
import db.DBConnection;
import model.Ordine;
import model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/ordini")
public class AdminOrdiniServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || admin.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);
            List<Ordine> ordini = ordineDAO.findAll();

            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("/pagine/adminOrdini.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel recupero degli ordini.");
            request.getRequestDispatcher("/pagine/adminOrdini.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || admin.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);

            switch (action) {
                case "update": {
                    String id = request.getParameter("id");
                    String stato = request.getParameter("stato");
                    ordineDAO.updateStato(id, stato);
                    break;
                }
                case "delete": {
                    String id = request.getParameter("id");
                    ordineDAO.delete(id);
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
