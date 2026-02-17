package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ProdottoDAO;
import model.Prodotto;
import db.DBConnection;

/**
 * RicercaProdottiServlet (versione JSON)
 * ---------------------------------------------------------
 * Questa servlet gestisce la ricerca AJAX dei prodotti.
 *
 * Differenze rispetto alla versione precedente:
 *  - restituisce JSON invece di HTML
 *  - è più moderna e adatta a fetch() e applicazioni SPA
 *  - separa completamente la logica dalla presentazione
 *
 * Flusso:
 *  1. JavaScript invia una richiesta GET con parametro "q"
 *  2. La servlet interroga il database tramite il DAO
 *  3. Converte la lista di prodotti in JSON (Gson)
 *  4. Restituisce il JSON al browser
 */
@WebServlet("/RicercaProdottiServlet")
public class RicercaProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ Imposto il tipo di contenuto della risposta (JSON)
        response.setContentType("application/json;charset=UTF-8");

        // ⭐ Recupero la keyword digitata dall’utente
        String keyword = request.getParameter("q");

        // ⭐ Se la keyword è vuota, restituisco un array JSON vuoto
        if (keyword == null || keyword.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // ⭐ DAO per la ricerca prodotti
            ProdottoDAO dao = new ProdottoDAO(conn);

            // ⭐ Recupero dei risultati della ricerca
            List<Prodotto> risultati = dao.search(keyword);

            // ⭐ Conversione della lista in JSON tramite Gson
            Gson gson = new Gson();
            String json = gson.toJson(risultati);

            // ⭐ Invio del JSON al client
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();

            // ⭐ In caso di errore restituisco un JSON di errore
            response.getWriter().write("{\"error\":\"Errore durante la ricerca\"}");
        }
    }
}
