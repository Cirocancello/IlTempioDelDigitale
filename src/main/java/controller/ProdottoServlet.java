package controller;

import dao.ProdottoDAO;
import dao.FeedbackDAO;
import model.Prodotto;
import model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import db.DBConnection;

/**
 * ProdottoServlet
 * ---------------------------------------------------------
 * Gestisce la visualizzazione della pagina di dettaglio
 * di un singolo prodotto.
 *
 * Funzionalità:
 * - Controllo autenticazione utente
 * - Validazione parametro "id"
 * - Recupero prodotto tramite DAO
 * - Recupero feedback associati
 * - Forward verso prodotto.jsp
 */
@WebServlet("/prodotto")
public class ProdottoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ============================================================
        // ⭐ 1) CONTROLLO AUTENTICAZIONE
        // ============================================================
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ============================================================
        // ⭐ 2) VALIDAZIONE PARAMETRO "id"
        // ============================================================
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        }

        int idProdotto;
        try {
            idProdotto = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        }

        // ============================================================
        // ⭐ 3) APERTURA CONNESSIONE (try-with-resources)
        // ============================================================
        try (Connection conn = DBConnection.getConnection()) {

            // ============================================================
            // ⭐ 4) INIZIALIZZAZIONE DAO
            // ============================================================
            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            FeedbackDAO feedbackDAO = new FeedbackDAO(conn);

            // ============================================================
            // ⭐ 5) RECUPERO PRODOTTO
            // ============================================================
            Prodotto prodotto = prodottoDAO.findById(idProdotto);

            if (prodotto == null) {
                response.sendRedirect(request.getContextPath() + "/catalogo");
                return;
            }

            // ============================================================
            // ⭐ 6) RECUPERO FEEDBACK ASSOCIATI
            // ============================================================
            List<Feedback> feedbacks = feedbackDAO.findByProdotto(idProdotto);

            // ============================================================
            // ⭐ 7) PASSAGGIO DATI ALLA JSP
            // ============================================================
            request.setAttribute("prodotto", prodotto);
            request.setAttribute("feedbacks", feedbacks);

            // ============================================================
            // ⭐ 8) FORWARD ALLA JSP
            // ============================================================
            request.getRequestDispatcher("/pagine/prodotto.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            // ============================================================
            // ⭐ 9) GESTIONE ERRORI GENERICI
            // ============================================================
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento del prodotto.");
            request.getRequestDispatcher("/pagine/prodotto.jsp")
                   .forward(request, response);
        }
    }
}
