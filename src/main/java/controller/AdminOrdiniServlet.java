package controller;

import dao.OrdineDAO;
import dao.UtenteDAO;
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

    private static final int LIMIT = 10; // ⭐ 10 ordini per pagina

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ Controllo admin
        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || admin.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // ⭐ Lettura filtri
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String userIdStr = request.getParameter("userId");

        Integer userId = null;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            userId = Integer.parseInt(userIdStr);
        }

        // ⭐ Paginazione
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int offset = (page - 1) * LIMIT;

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);
            UtenteDAO utenteDAO = new UtenteDAO();

            // ⭐ Recupero ordini filtrati + paginati
            List<Ordine> ordini = ordineDAO.filtraOrdini(from, to, userId, LIMIT, offset);

            // ⭐ Conteggio totale per paginazione
            int totalOrdini = ordineDAO.countOrdini(from, to, userId);
            int totalPages = (int) Math.ceil((double) totalOrdini / LIMIT);

            // ⭐ Lista utenti per il filtro
            List<Utente> utenti = utenteDAO.findAll();

            // ⭐ Passaggio dati alla JSP
            request.setAttribute("ordini", ordini);
            request.setAttribute("utenti", utenti);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

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

        // ⭐ Controllo admin
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

        // ⭐ Torna alla lista ordini
        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
