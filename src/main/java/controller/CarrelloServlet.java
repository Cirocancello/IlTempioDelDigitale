package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

import model.Prodotto;
import dao.ProdottoDAO;
import db.DBConnection;
import java.sql.Connection;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        getCarrello(session);

        request.getRequestDispatcher("/pagine/carrello.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Prodotto> carrello = getCarrello(session);

        String action = request.getParameter("action");
        int idProdotto = Integer.parseInt(request.getParameter("id"));

        switch (action) {

            case "aggiungi": {
                try (Connection conn = DBConnection.getConnection()) {
                    ProdottoDAO dao = new ProdottoDAO(conn);
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
                } catch (Exception e) {
                    e.printStackTrace();
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

        session.setAttribute("carrello", carrello);
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}
