package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import model.Prodotto;
import dao.ProdottoDAO;
import db.DBConnection;

/**
 * CarrelloAjaxServlet
 * ------------------------------------------------------------
 * Gestisce tutte le operazioni del carrello tramite richieste AJAX.
 *
 * Funzionalità supportate:
 *  - aggiungi → aggiunge un prodotto al carrello
 *  - inc → incrementa la quantità di un prodotto
 *  - dec → decrementa la quantità di un prodotto
 *  - rimuovi → rimuove completamente un prodotto dal carrello
 *
 * Risponde sempre con JSON:
 *  { "success": true/false, "quantita": numeroTotaleProdotti }
 *
 * Questa servlet NON restituisce pagine HTML, ma solo JSON.
 */
@WebServlet("/carrello-ajax")
public class CarrelloAjaxServlet extends HttpServlet {

    /**
     * ⭐ Recupera il carrello dalla sessione.
     * Se non esiste, lo crea.
     */
    @SuppressWarnings("unchecked")
    private List<Prodotto> getCarrello(HttpSession session) {
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        return carrello;
    }

    /**
     * ⭐ Cerca un prodotto nel carrello tramite ID.
     * Restituisce il prodotto se presente, altrimenti null.
     */
    private Prodotto trovaNelCarrello(List<Prodotto> carrello, int id) {
        for (Prodotto p : carrello) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Imposto la risposta come JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // JSON di fallback in caso di errore
        String fallback = "{ \"success\": false, \"quantita\": 0 }";

        try {
            /**
             * ⭐ 1) Recupero sessione
             * -----------------------
             * Se la sessione non esiste → l’utente non è autenticato.
             */
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("auth") == null) {
                response.getWriter().write(fallback);
                return;
            }

            /**
             * ⭐ 2) Recupero carrello dalla sessione
             */
            List<Prodotto> carrello = getCarrello(session);

            /**
             * ⭐ 3) Recupero parametri AJAX 
             * che sono arrivati dalla chiamata asincrona Ajax quando clicco su aggiungi al carrello
             */
            String action = request.getParameter("action");
            String idParam = request.getParameter("id");

            if (action == null || idParam == null) {
                response.getWriter().write(fallback);
                return;
            }

            int idProdotto = Integer.parseInt(idParam);

            /**
             * ⭐ 4) Connessione DB per recuperare i prodotti
             */
            try (Connection conn = DBConnection.getConnection()) {

                ProdottoDAO dao = new ProdottoDAO(conn);

                /**
                 * ⭐ 5) Switch sulle azioni del carrello
                 */
                switch (action) {

                    case "aggiungi": {
                        Prodotto p = dao.findById(idProdotto);

                        if (p != null) {
                            Prodotto esistente = trovaNelCarrello(carrello, idProdotto);

                            if (esistente == null) {
                                p.setQuantita(1);
                                carrello.add(p);
                            } else {
                                esistente.setQuantita(esistente.getQuantita() + 1);
                            }
                        }
                        break;
                    }

                    case "rimuovi": {
                        carrello.removeIf(p -> p.getId() == idProdotto);
                        break;
                    }

                    case "inc": {
                        Prodotto p = trovaNelCarrello(carrello, idProdotto);
                        if (p != null) {
                            p.setQuantita(p.getQuantita() + 1);
                        }
                        break;
                    }

                    case "dec": {
                        Prodotto p = trovaNelCarrello(carrello, idProdotto);
                        if (p != null) {
                            int nuovaQ = p.getQuantita() - 1;

                            if (nuovaQ <= 0) {
                                carrello.remove(p);
                            } else {
                                p.setQuantita(nuovaQ);
                            }
                        }
                        break;
                    }
                }

            } catch (Exception e) {
                // Errore DB → rispondo comunque JSON valido
                response.getWriter().write(fallback);
                return;
            }

            /**
             * ⭐ 6) Salvo il carrello aggiornato in sessione
             */
            session.setAttribute("carrello", carrello);

            /**
             * ⭐ 7) Calcolo quantità totale nel carrello
             * 
             * “Uso lo Stream API per calcolare il totale degli articoli nel carrello.
			 * mapToInt(Prodotto::getQuantita) trasforma ogni prodotto nella sua quantità, e sum() somma tutte le quantità.
			 * È una forma compatta e moderna per sostituire un ciclo for.”
             */
            int totale = carrello.stream()
                    .mapToInt(Prodotto::getQuantita)
                    .sum();

            /**
             * ⭐ 8) Risposta JSON finale
             */
            String json = "{ \"success\": true, \"quantita\": " + totale + " }";
            response.getWriter().write(json);

        } catch (Exception e) {
            // Errore generale → JSON valido
            response.getWriter().write(fallback);
        }
    }
}
