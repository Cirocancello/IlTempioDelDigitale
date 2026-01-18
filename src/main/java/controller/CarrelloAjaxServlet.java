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

@WebServlet("/carrello-ajax")
public class CarrelloAjaxServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    private List<Prodotto> getCarrello(HttpSession session) {
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }
        return carrello;
    }

    private Prodotto trovaNelCarrello(List<Prodotto> carrello, int id) {
        for (Prodotto p : carrello) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // JSON di fallback in caso di errore
        String fallback = "{ \"success\": false, \"quantita\": 0 }";

        try {
            HttpSession session = request.getSession(false);

            // Se la sessione non esiste → rispondi JSON valido
            if (session == null || session.getAttribute("auth") == null) {
                response.getWriter().write(fallback);
                return;
            }

            List<Prodotto> carrello = getCarrello(session);

            String action = request.getParameter("action");
            String idParam = request.getParameter("id");

            // Parametri mancanti → JSON valido
            if (action == null || idParam == null) {
                response.getWriter().write(fallback);
                return;
            }

            int idProdotto = Integer.parseInt(idParam);

            try (Connection conn = DBConnection.getConnection()) {

                ProdottoDAO dao = new ProdottoDAO(conn);

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
                // Errore DB → rispondi JSON valido
                response.getWriter().write(fallback);
                return;
            }

            session.setAttribute("carrello", carrello);

            int totale = carrello.stream().mapToInt(Prodotto::getQuantita).sum();

            String json = "{ \"success\": true, \"quantita\": " + totale + " }";
            response.getWriter().write(json);

        } catch (Exception e) {
            // Errore generale → JSON valido
            response.getWriter().write(fallback);
        }
    }
}
