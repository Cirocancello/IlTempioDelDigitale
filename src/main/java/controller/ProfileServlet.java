package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import model.Utente;
import model.Prodotto;
import dao.UtenteDAO;
import dao.PreferitiDAO;
import db.DBConnection;

/**
 * ProfileServlet
 * -------------------------
 * Gestisce la visualizzazione del profilo utente.
 * - Controlla che l’utente sia autenticato
 * - Recupera i dati dell’utente dal database
 * - Carica la lista dei prodotti preferiti
 * - Invia tutto alla JSP profile.jsp
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // DAO per recuperare i dati dell’utente
    private UtenteDAO utenteDAO = new UtenteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) CONTROLLO AUTENTICAZIONE
         * ------------------------------
         * Recupero la sessione esistente.
         * Se non esiste o manca il token "auth", l’utente non è loggato.
         */
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        /**
         * ⭐ 2) CONTROLLO ID UTENTE
         * -------------------------
         * La LoginServlet salva "utenteId" in sessione.
         * Se manca, significa che la sessione non è valida.
         */
        if (session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        int utenteId = (int) session.getAttribute("utenteId");

        /**
         * ⭐ 3) RECUPERO DATI UTENTE DAL DATABASE
         * ---------------------------------------
         * Uso il DAO per ottenere l’oggetto Utente completo.
         */
        Utente utente = utenteDAO.findById(utenteId);

        if (utente == null) {
            // Utente non trovato → accesso negato
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        /**
         * ⭐ 4) CARICAMENTO LISTA PREFERITI
         * ---------------------------------
         * Recupero dal database tutti i prodotti preferiti dell’utente.
         * PreferitiDAO richiede una Connection, quindi uso try-with-resources.
         */
        try (Connection conn = DBConnection.getConnection()) {

            PreferitiDAO preferitiDAO = new PreferitiDAO(conn);

            // Lista completa dei prodotti preferiti
            List<Prodotto> listaPreferiti = preferitiDAO.findProdottiByUtente(utenteId);

            // La passo alla JSP
            request.setAttribute("listaPreferiti", listaPreferiti);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento dei preferiti: " + e.getMessage());
        }

        /**
         * ⭐ 5) INVIO DATI ALLA JSP
         * -------------------------
         * Passo l’oggetto utente e la lista preferiti alla pagina profile.jsp.
         */
        request.setAttribute("utente", utente);

        // Forward alla pagina profilo
        request.getRequestDispatcher("/pagine/profile.jsp").forward(request, response);
    }
}
