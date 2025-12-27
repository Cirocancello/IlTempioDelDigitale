package controller;

import dao.CategoriaDAO;
import dao.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Categoria;
import model.Prodotto;
import model.Utente;
import db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/prodotti")
public class AdminProdottoServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            switch (action) {

                // -------------------------
                // APRI FORM CREAZIONE
                // -------------------------
                case "create": {
                    List<Categoria> categorie = categoriaDAO.findAll();
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/adminCreaProdotto.jsp")
                           .forward(request, response);
                    return;
                }

                // -------------------------
                // APRI FORM MODIFICA
                // -------------------------
                case "edit": {
                    String idParam = request.getParameter("id");
                    int id;

                    try {
                        id = Integer.parseInt(idParam);
                    } catch (NumberFormatException e) {
                        response.sendRedirect(request.getContextPath() + "/admin/prodotti?error=invalidId");
                        return;
                    }

                    Prodotto prodotto = prodottoDAO.findById(id);
                    if (prodotto == null) {
                        response.sendRedirect(request.getContextPath() + "/admin/prodotti?error=notfound");
                        return;
                    }

                    List<Categoria> categorie = categoriaDAO.findAll();
                    request.setAttribute("prodotto", prodotto);
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/adminModificaProdotto.jsp")
                           .forward(request, response);
                    return;
                }

                // -------------------------
                // LISTA PRODOTTI (DEFAULT)
                // -------------------------
                default: {
                    List<Prodotto> prodotti = prodottoDAO.findAll();
                    List<Categoria> categorie = categoriaDAO.findAll();

                    request.setAttribute("prodotti", prodotti);
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/adminProdotti.jsp")
                           .forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento prodotti.");
            request.getRequestDispatcher("/pagine/adminProdotti.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            switch (action) {

                // -------------------------
                // CREA PRODOTTO
                // -------------------------
                case "create": {
                    String nome = request.getParameter("nome");
                    String brand = request.getParameter("brand");
                    String informazioni = request.getParameter("informazioni");
                    double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));
                    String imageUrl = request.getParameter("imageUrl");
                    boolean visibile = Boolean.parseBoolean(request.getParameter("visibile"));
                    int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

                    Categoria cat = categoriaDAO.findById(categoriaId);
                    Prodotto p = new Prodotto(0, nome, brand, informazioni, prezzo,
                            quantita, imageUrl, visibile, cat);

                    prodottoDAO.insert(p);
                    break;
                }

                // -------------------------
                // AGGIORNA PRODOTTO
                // -------------------------
                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String nome = request.getParameter("nome");
                    String brand = request.getParameter("brand");
                    String informazioni = request.getParameter("informazioni");
                    double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));
                    String imageUrl = request.getParameter("imageUrl");
                    boolean visibile = Boolean.parseBoolean(request.getParameter("visibile"));
                    int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

                    Categoria cat = categoriaDAO.findById(categoriaId);
                    Prodotto p = new Prodotto(id, nome, brand, informazioni, prezzo,
                            quantita, imageUrl, visibile, cat);

                    prodottoDAO.update(p);
                    break;
                }

                // -------------------------
                // ELIMINA PRODOTTO
                // -------------------------
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    prodottoDAO.delete(id);
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/prodotti");
    }
}
