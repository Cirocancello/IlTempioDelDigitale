package controller;

import dao.ProdottoDAO;
import model.Prodotto;
import db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * ProdottiTopServlet
 * ---------------------------------------------------------
 * Questa servlet gestisce la homepage del sito.
 * Ogni volta che l’utente accede alla root "/", la servlet:
 *  - si connette al database
 *  - recupera i 3 prodotti più venduti
 *  - li passa alla JSP come attributo della request
 *  - inoltra la richiesta alla pagina /pagine/index.jsp
 *
 * Questo garantisce che la homepage passi SEMPRE dalla servlet,
 * rispettando il pattern MVC.
 */
@WebServlet("")   // ⭐ La servlet risponde alla root "/" → homepage del sito
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) CONNESSIONE AL DATABASE
         * ---------------------------------------------------------
         * Uso try-with-resources per chiudere automaticamente la connessione.
         */
        try (Connection conn = DBConnection.getConnection()) {

            /**
             * ⭐ 2) INIZIALIZZAZIONE DEL DAO
             * ---------------------------------------------------------
             * ProdottoDAO contiene le query per recuperare i prodotti.
             */
            ProdottoDAO dao = new ProdottoDAO(conn);

            /**
             * ⭐ 3) RECUPERO DEI TOP 3 PRODOTTI PIÙ VENDUTI
             * ---------------------------------------------------------
             * Metodo personalizzato del DAO che restituisce una lista
             * ordinata per numero di vendite.
             */
            List<Prodotto> prodottiTop = dao.getProdottiTopVenduti(3);

            /**
             * ⭐ 4) PASSAGGIO DATI ALLA JSP
             * ---------------------------------------------------------
             * La JSP leggerà "prodottiTop" per mostrare i prodotti in homepage.
             */
            request.setAttribute("prodottiTop", prodottiTop);

        } catch (Exception e) {

            /**
             * ⭐ 5) GESTIONE ERRORI
             * ---------------------------------------------------------
             * In caso di problemi, imposto un messaggio di errore
             * che la JSP potrà mostrare.
             */
            e.printStackTrace();
            request.setAttribute("error", "Errore nel recupero dei prodotti più venduti");
        }

        /**
         * ⭐ 6) FORWARD ALLA JSP
         * ---------------------------------------------------------
         * Uso forward (non redirect) perché voglio mantenere
         * gli attributi della request.
         *
         * La JSP si trova ora nella cartella /pagine.
         */
        request.getRequestDispatcher("/pagine/index.jsp").forward(request, response);
    }
}
