package controller;

import dao.OrdineDAO;
import db.DBConnection;
import model.Ordine;
import model.Prodotto;
import model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        if (carrello == null || carrello.isEmpty()) {
            request.setAttribute("error", "Il carrello è vuoto.");
            request.getRequestDispatcher("/pagine/checkout.jsp").forward(request, response);
            return;
        }

        // Parametri dal form
        String indirizzoSpedizione = request.getParameter("indirizzoSpedizione");
        String metodoPagamento = request.getParameter("metodoPagamento");

        // Creazione ordine
        Ordine ordine = new Ordine();
        ordine.setUtente(utente);
        ordine.setData(new Date());
        ordine.setStato("In lavorazione");
        ordine.setProdotti(new ArrayList<>(carrello));
        ordine.calcolaTotale();

        ordine.setIndirizzoSpedizione(indirizzoSpedizione);
        ordine.setMetodoPagamento(metodoPagamento);

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);

            // Salvataggio ordine
            ordineDAO.createOrdine(ordine);

            // Svuota carrello
            session.removeAttribute("carrello");

            // Passa ordine alla conferma
            request.setAttribute("ordine", ordine);
            request.getRequestDispatcher("/pagine/confermaOrdine.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore durante la creazione dell'ordine.");
            request.getRequestDispatcher("/pagine/checkout.jsp").forward(request, response);
        }
    }
}
