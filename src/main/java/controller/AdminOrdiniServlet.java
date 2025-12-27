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
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        // Controllo admin (coerente con tutto il progetto)
        if (utente == null || utente.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO();
            List<Ordine> ordini = ordineDAO.findAll();

            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("/pagine/adminOrdini.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Errore nel recupero degli ordini.");
            request.getRequestDispatcher("/pagine/adminOrdini.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (utente == null || utente.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String idOrdineStr = request.getParameter("idOrdine");
        String nuovoStato = request.getParameter("nuovoStato");

        if (idOrdineStr == null || nuovoStato == null ||
            idOrdineStr.isBlank() || nuovoStato.isBlank()) {

            response.sendRedirect(request.getContextPath() + "/admin/ordini");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO();
            ordineDAO.updateStato(idOrdineStr, nuovoStato);

        } catch (Exception e) {
            // Puoi loggare l’errore se vuoi
        }

        // ✅ PRG: redirect dopo POST
        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
