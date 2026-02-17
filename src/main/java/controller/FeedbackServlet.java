package controller;

import dao.FeedbackDAO;
import db.DBConnection;
import model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

/**
 * FeedbackServlet
 * ------------------------------------------------------------
 * Gestisce l’inserimento di un nuovo feedback da parte dell’utente.
 * - Controlla che l’utente sia autenticato
 * - Valida i parametri ricevuti
 * - Crea un oggetto Feedback
 * - Lo salva nel database tramite FeedbackDAO
 * - Reindirizza alla pagina del prodotto
 */
@WebServlet("/aggiungi-feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
        // ⭐ 2) RECUPERO E VALIDAZIONE PARAMETRI
        // ============================================================

        // --- prodottoId ---
        String prodottoIdParam = request.getParameter("prodottoId");
        if (prodottoIdParam == null || prodottoIdParam.isBlank()) {
            // Parametro mancante → redirect con errore
            response.sendRedirect(request.getContextPath() + "/catalogo?error=invalidProductId");
            return;
        }

        int prodottoId;
        try {
            prodottoId = Integer.parseInt(prodottoIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo?error=invalidProductId");
            return;
        }

        // --- titolo ---
        String titolo = request.getParameter("titolo");
        if (titolo == null || titolo.isBlank()) {
            titolo = "Senza titolo"; // fallback opzionale
        }

        // --- descrizione ---
        String descrizione = request.getParameter("descrizione");
        if (descrizione == null || descrizione.isBlank()) {
            descrizione = "Nessuna descrizione fornita.";
        }

        // --- score ---
        String scoreParam = request.getParameter("score");
        if (scoreParam == null || scoreParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/prodotto?id=" + prodottoId + "&error=invalidScore");
            return;
        }

        int score;
        try {
            score = Integer.parseInt(scoreParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/prodotto?id=" + prodottoId + "&error=invalidScore");
            return;
        }

        // ============================================================
        // ⭐ 3) INSERIMENTO FEEDBACK NEL DATABASE
        // ============================================================
        try (Connection conn = DBConnection.getConnection()) {

            FeedbackDAO dao = new FeedbackDAO(conn);

            Feedback f = new Feedback();
            f.setProdottoId(prodottoId);
            f.setTitolo(titolo);
            f.setDescrizione(descrizione);
            f.setScore(score);

            dao.insertFeedback(f);

        } catch (Exception e) {
            e.printStackTrace();
            // Possibile gestione errore più elegante:
            response.sendRedirect(request.getContextPath() + "/prodotto?id=" + prodottoId + "&error=dbError");
            return;
        }

        // ============================================================
        // ⭐ 4) REDIRECT ALLA PAGINA PRODOTTO (PRG)
        // ============================================================
        response.sendRedirect(request.getContextPath() + "/prodotto?id=" + prodottoId + "&success=1");
    }
}
