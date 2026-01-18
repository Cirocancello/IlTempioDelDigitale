package controller;

import dao.OrdineDAO;
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

import db.DBConnection;

@WebServlet("/ordini")
public class OrdiniServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CONTROLLO TOKEN 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // Controllo presenza utente in sessione
        Utente utente = (Utente) session.getAttribute("utente");
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);

            // Recupera lo storico ordini dell'utente corrente
            List<Ordine> ordini = ordineDAO.findByUtente(utente.getId());

            // Passa i dati alla JSP
            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("/pagine/orders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel recupero degli ordini.");
            request.getRequestDispatcher("/pagine/orders.jsp").forward(request, response);
        }
    }
}
