package controller;

import dao.OrdineDAO;
import db.DBConnection;
import model.Ordine;
import model.Prodotto;
import model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

/**
 * CheckoutServlet
 * -----------------------------------------
 * Gestisce la fase finale dell'acquisto:
 * - Controlla che l’utente sia autenticato
 * - Recupera il carrello dalla sessione
 * - Valida i dati del checkout
 * - Crea un oggetto Ordine completo
 * - Lo salva nel database tramite OrdineDAO
 * - Svuota il carrello
 * - Mostra la pagina di conferma ordine
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) CONTROLLO AUTENTICAZIONE
         * --------------------------------
         * Recupero la sessione esistente.
         * Se non esiste o manca il token "auth",
         * l’utente non è loggato → redirect al login.
         */
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // Utente autenticato
        Utente utente = (Utente) session.getAttribute("utente");

        /**
         * ⭐ 2) RECUPERO CARRELLO DALLA SESSIONE
         * ---------------------------------------
         * Il carrello è una lista di prodotti salvata in sessione.
         */
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        // Se il carrello è vuoto → errore
        if (carrello == null || carrello.isEmpty()) {
            request.setAttribute("error", "Il carrello è vuoto.");
            request.getRequestDispatcher("/pagine/checkout.jsp").forward(request, response);
            return;
        }

        /**
         * ⭐ 3) RECUPERO PARAMETRI DAL FORM DI CHECKOUT
         * ----------------------------------------------
         * Indirizzo di spedizione e metodo di pagamento.
         */
        String indirizzoSpedizione = request.getParameter("indirizzoSpedizione");
        String metodoPagamento = request.getParameter("metodoPagamento");

        /**
         * ⭐ 4) CREAZIONE OGGETTO ORDINE
         * --------------------------------
         * Popolo l’oggetto Ordine con:
         * - utente
         * - data
         * - stato iniziale
         * - lista prodotti
         * - totale calcolato
         * - indirizzo e pagamento
         */
        Ordine ordine = new Ordine();
        ordine.setUtente(utente);
        ordine.setData(new Date());
        ordine.setStato("In lavorazione");
        ordine.setProdotti(new ArrayList<>(carrello)); // Copia del carrello
        ordine.calcolaTotale(); // Calcolo totale ordine

        ordine.setIndirizzoSpedizione(indirizzoSpedizione);
        ordine.setMetodoPagamento(metodoPagamento);

        /**
         * ⭐ 5) SALVATAGGIO ORDINE NEL DATABASE
         * --------------------------------------
         * Uso try-with-resources per aprire e chiudere automaticamente
         * la connessione al database.
         */
        try (Connection conn = DBConnection.getConnection()) {

            OrdineDAO ordineDAO = new OrdineDAO(conn);

            // Salvataggio ordine nel DB
            ordineDAO.createOrdine(ordine);

            // ⭐ Svuoto il carrello dopo l'acquisto
            session.removeAttribute("carrello");

            // ⭐ Passo l’ordine alla pagina di conferma
            request.setAttribute("ordine", ordine);

            // Forward alla pagina confermaOrdine.jsp
            request.getRequestDispatcher("/pagine/confermaOrdine.jsp").forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            /**
             * ⭐ 6) GESTIONE ERRORI
             * ----------------------
             * Se qualcosa va storto durante il salvataggio,
             * torno alla pagina checkout con un messaggio di errore.
             */
            request.setAttribute("error", "Errore durante la creazione dell'ordine.");
            request.getRequestDispatcher("/pagine/checkout.jsp").forward(request, response);
        }
    }
}
