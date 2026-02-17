package controller;

import dao.CategoriaDAO;
import dao.ProdottoDAO;
import dao.PreferitiDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Categoria;
import model.Prodotto;
import model.Utente;
import model.Preferito;
import db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * CatalogoServlet
 * ----------------------------------------------------
 * Gestisce la visualizzazione del catalogo prodotti.
 * Funzionalità:
 *  - Carica tutte le categorie
 *  - Carica tutti i prodotti o filtra per categoria
 *  - Filtra anche per ricerca testuale (q)
 *  - Se l’utente è loggato, carica i preferiti
 *  - Invia tutto alla JSP catalogo.jsp tramite forward
 */
@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) APERTURA CONNESSIONE CON TRY-WITH-RESOURCES
         * -------------------------------------------------
         * La connessione viene chiusa automaticamente.
         */
        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                throw new ServletException("Connessione al database non disponibile.");
            }

            /**
             * ⭐ 2) INIZIALIZZAZIONE DAO
             * ---------------------------
             * DAO per prodotti e categorie.
             */
            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            /**
             * ⭐ 3) CARICAMENTO CATEGORIE
             * ----------------------------
             * Le categorie servono per il filtro nella JSP.
             */
            List<Categoria> categorie = categoriaDAO.findAll();
            request.setAttribute("categorie", categorie);

            /**
             * ⭐ 4) FILTRO PER CATEGORIA
             * --------------------------------------
             * Se l’utente seleziona una categoria, mostro solo i prodotti di quella categoria.
             */
            String categoriaParam = request.getParameter("categoria");
            List<Prodotto> prodotti;

            if (categoriaParam != null && !categoriaParam.isBlank()) {
                int categoriaId = Integer.parseInt(categoriaParam);
                prodotti = prodottoDAO.findByCategoria(categoriaId);

                // Salvo l’ID per evidenziare la categoria selezionata nella JSP
                request.setAttribute("categoriaSelezionata", categoriaId);

            } else {
                // Nessun filtro → carico tutti i prodotti
                prodotti = prodottoDAO.findAll();
            }

            /**
             * ⭐ 5) RICERCA NORMALE (NON AJAX)
             * --------------------------------
             * Se l’utente inserisce un testo nella barra di ricerca (q),
             * filtro i prodotti già caricati.
             */
            String query = request.getParameter("q");

            if (query != null && !query.trim().isEmpty()) {
                String q = query.toLowerCase();

                prodotti = prodotti.stream()
                        .filter(p -> p.getNome().toLowerCase().contains(q))
                        .toList();

                // Salvo il testo della ricerca per rimetterlo nella input box
                request.setAttribute("query", query);
            }

            // Invio la lista finale (filtrata o completa)
            request.setAttribute("prodotti", prodotti);

            /**
             * ⭐ 6) CONTROLLO UTENTE AUTENTICATO
             * ----------------------------------
             * Serve per mostrare pulsanti “Aggiungi ai preferiti”
             * o per caricare la lista dei preferiti.
             */
            HttpSession session = request.getSession(false);
            Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

            // Flag utile nella JSP
            request.setAttribute("utenteAutenticato", u != null);

            /**
             * ⭐ 7) CARICAMENTO PREFERITI (solo se loggato)
             * ---------------------------------------------
             * Se l’utente è autenticato, carico la lista dei preferiti
             * per mostrare il cuore pieno/vuoto nel catalogo.
             */
            if (u != null) {
                PreferitiDAO preferitiDAO = new PreferitiDAO(conn);
                List<Preferito> listaPreferiti = preferitiDAO.findByUtente(u.getId());
                request.setAttribute("listaPreferiti", listaPreferiti);
            }

            /**
             * ⭐ 8) FORWARD ALLA JSP
             * -----------------------
             * Invio tutti i dati alla pagina catalogo.jsp.
             */
            request.getRequestDispatcher("/pagine/catalogo.jsp").forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            /**
             * ⭐ 9) GESTIONE ERRORI
             * ----------------------
             * In caso di errore, mostro un messaggio nella stessa pagina.
             */
            request.setAttribute("error", "Errore nel caricamento del catalogo.");
            request.getRequestDispatcher("/pagine/catalogo.jsp").forward(request, response);
        }
    }
}
