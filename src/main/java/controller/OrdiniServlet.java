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

/**
 * OrdiniServlet
 * ---------------------------------------------------------
 * Gestisce la visualizzazione dello storico ordini dell’utente.
 * - Controlla che l’utente sia autenticato
 * - Recupera l’utente dalla sessione
 * - Carica gli ordini tramite OrdineDAO
 * - Passa i dati alla JSP orders.jsp
 */
@WebServlet("/ordini")
public class OrdiniServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) CONTROLLO AUTENTICAZIONE
         * -------------------------------------------------
         * Recupero la sessione esistente.
         * Se non esiste o manca il token "auth",
         * l’utente non è loggato → redirect al login.
         */
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        /**
         * ⭐ 2) RECUPERO UTENTE DALLA SESSIONE
         * -------------------------------------------------
         * L’utente deve essere presente nella sessione.
         * Se non c’è, lo rimando al login.
         */
        Utente utente = (Utente) session.getAttribute("utente");
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        /**
         * ⭐ 3) APERTURA CONNESSIONE CON TRY-WITH-RESOURCES
         * -------------------------------------------------
         * La connessione viene chiusa automaticamente.
         */
        try (Connection conn = DBConnection.getConnection()) {

            /**
             * ⭐ 4) UTILIZZO DEL DAO
             * -------------------------------------------------
             * OrdineDAO gestisce tutte le operazioni sul database
             * relative agli ordini.
             */
            OrdineDAO ordineDAO = new OrdineDAO(conn);

            /**
             * ⭐ 5) RECUPERO ORDINI DELL’UTENTE
             * -------------------------------------------------
             * Carico lo storico ordini filtrato per ID utente.
             */
            List<Ordine> ordini = ordineDAO.findByUtente(utente.getId());

            /**
             * ⭐ 6) PASSAGGIO DATI ALLA JSP
             * -------------------------------------------------
             * Imposto la lista ordini come attributo della request
             * e inoltro alla pagina orders.jsp.
             */
            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("/pagine/orders.jsp").forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            /**
             * ⭐ 7) GESTIONE ERRORI
             * -------------------------------------------------
             * In caso di eccezioni, mostro un messaggio di errore
             * nella stessa pagina orders.jsp.
             */
            request.setAttribute("error", "Errore nel recupero degli ordini.");
            request.getRequestDispatcher("/pagine/orders.jsp").forward(request, response);
        }
    }
}
