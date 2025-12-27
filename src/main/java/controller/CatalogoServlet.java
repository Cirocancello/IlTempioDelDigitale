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

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {

            if (conn == null) {
                throw new ServletException("Connessione al database non disponibile.");
            }

            // DAO
            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            // Carica tutte le categorie
            List<Categoria> categorie = categoriaDAO.findAll();
            request.setAttribute("categorie", categorie);

            // Filtro categoria
            String categoriaParam = request.getParameter("categoria");
            List<Prodotto> prodotti;

            if (categoriaParam != null && !categoriaParam.isBlank()) {
                int categoriaId = Integer.parseInt(categoriaParam);
                prodotti = prodottoDAO.findByCategoria(categoriaId);
                request.setAttribute("categoriaSelezionata", categoriaId);
            } else {
                prodotti = prodottoDAO.findAll();
            }

            request.setAttribute("prodotti", prodotti);

            // Utente autenticato
            HttpSession session = request.getSession(false);
            Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;
            request.setAttribute("utenteAutenticato", u != null);

            // Preferiti se loggato
            if (u != null) {
                PreferitiDAO preferitiDAO = new PreferitiDAO(conn);
                List<Preferito> listaPreferiti = preferitiDAO.findByUtente(u.getId());
                request.setAttribute("listaPreferiti", listaPreferiti);
            }

            // Forward
            request.getRequestDispatcher("/pagine/catalogo.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento del catalogo.");
            request.getRequestDispatcher("/pagine/catalogo.jsp").forward(request, response);
        }
    }
}
