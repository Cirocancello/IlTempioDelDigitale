package controller.admin;

import dao.OrdineDAO;
import dao.UtenteDAO;
import db.DBConnection;
import model.Ordine;
import model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * AdminOrdiniServlet
 * ------------------------------------------------------------
 * Gestisce la visualizzazione e la gestione degli ordini lato Admin.
 *
 * Funzionalità:
 *  - Visualizzazione ordini con filtri (data, utente)
 *  - Paginazione (10 ordini per pagina)
 *  - Modifica stato ordine
 *  - Eliminazione ordine
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → DAO → Model → JSP)
 *  - PRG (Post-Redirect-Get) per evitare reinvii multipli
 */
@WebServlet("/admin/ordini")
public class AdminOrdiniServlet extends HttpServlet {

    private static final int LIMIT = 10; // ⭐ Numero ordini per pagina

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ============================================================
        // ⭐ 1) Controllo autenticazione Admin
        // ============================================================
        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || admin.getRole() != 1) {
            // Utente non autorizzato → redirect al login admin
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // ============================================================
        // ⭐ 2) Lettura filtri dalla query string
        // ============================================================
        String from = request.getParameter("from");   // data inizio
        String to = request.getParameter("to");       // data fine
        String userIdStr = request.getParameter("userId");

        Integer userId = null;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            userId = Integer.parseInt(userIdStr);
        }

        // ============================================================
        // ⭐ 3) Paginazione
        // ============================================================
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * LIMIT;

        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);
            UtenteDAO utenteDAO = new UtenteDAO();

            // ============================================================
            // ⭐ 4) Recupero ordini filtrati + paginati
            // ============================================================
            List<Ordine> ordini = ordineDAO.filtraOrdini(from, to, userId, LIMIT, offset);

            // ============================================================
            // ⭐ 5) Conteggio totale per calcolare il numero di pagine
            // ============================================================
            int totalOrdini = ordineDAO.countOrdini(from, to, userId);
            int totalPages = (int) Math.ceil((double) totalOrdini / LIMIT);

            // ============================================================
            // ⭐ 6) Lista utenti per filtro "per utente"
            // ============================================================
            List<Utente> utenti = utenteDAO.findAll();

            // ============================================================
            // ⭐ 7) Passaggio dati alla JSP
            // ============================================================
            request.setAttribute("ordini", ordini);
            request.setAttribute("utenti", utenti);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/pagine/admin/adminOrdini.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            // ⭐ In caso di errore → mostro messaggio nella JSP
            request.setAttribute("error", "Errore nel recupero degli ordini.");
            request.getRequestDispatcher("/pagine/admin/adminOrdini.jsp")
                   .forward(request, response);
        }
    }

    // ======================================================================
    // ⭐ POST: Aggiornamento stato ordine o eliminazione ordine
    // ======================================================================
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
                    // ⭐ Aggiornamento stato ordine
                    String id = request.getParameter("id");
                    String stato = request.getParameter("stato");
                    ordineDAO.updateStato(id, stato);
                    break;
                }

                case "delete": {
                    // ⭐ Eliminazione ordine
                    String id = request.getParameter("id");
                    ordineDAO.delete(id);
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ⭐ PRG: Redirect per evitare reinvio del form
        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
