package controller.admin;

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

/**
 * AdminProdottoServlet
 * ------------------------------------------------------------
 * Gestisce tutte le operazioni lato Admin relative ai prodotti:
 *
 *  - Visualizzazione lista prodotti
 *  - Form creazione prodotto
 *  - Form modifica prodotto
 *  - Aggiornamento dati prodotto
 *  - Eliminazione prodotto
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → DAO → Model → JSP)
 *  - PRG (Post-Redirect-Get) per evitare reinvii multipli
 */
@WebServlet("/admin/prodotti")
public class AdminProdottoServlet extends HttpServlet {

    /**
     * ⭐ Metodo di utilità per verificare se l’utente è Admin.
     */
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    // ======================================================================
    // ⭐ GET → Visualizzazione pagine (lista, form creazione, form modifica)
    // ======================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ Controllo accesso Admin
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // ⭐ Azione richiesta (create, edit, default)
        String action = request.getParameter("action");
        if (action == null) action = "";

        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            switch (action) {

                // ============================================================
                // ⭐ FORM CREAZIONE PRODOTTO
                // ============================================================
                case "create": {
                    List<Categoria> categorie = categoriaDAO.findAll();
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/admin/adminCreaProdotto.jsp")
                           .forward(request, response);
                    return;
                }

                // ============================================================
                // ⭐ FORM MODIFICA PRODOTTO
                // ============================================================
                case "edit": {

                    String idParam = request.getParameter("id");

                    int id;
                    try {
                        id = Integer.parseInt(idParam);
                    } catch (NumberFormatException e) {
                        // ID non valido → redirect con errore
                        response.sendRedirect(request.getContextPath() + "/admin/prodotti?error=invalidId");
                        return;
                    }

                    Prodotto prodotto = prodottoDAO.findById(id);
                    if (prodotto == null) {
                        // Prodotto non trovato
                        response.sendRedirect(request.getContextPath() + "/admin/prodotti?error=notfound");
                        return;
                    }

                    List<Categoria> categorie = categoriaDAO.findAll();

                    request.setAttribute("prodotto", prodotto);
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/admin/adminModificaProdotto.jsp")
                           .forward(request, response);
                    return;
                }

                // ============================================================
                // ⭐ LISTA PRODOTTI (DEFAULT)
                // ============================================================
                default: {
                    List<Prodotto> prodotti = prodottoDAO.findAll();
                    List<Categoria> categorie = categoriaDAO.findAll();

                    request.setAttribute("prodotti", prodotti);
                    request.setAttribute("categorie", categorie);

                    request.getRequestDispatcher("/pagine/admin/adminProdotti.jsp")
                           .forward(request, response);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            // ⭐ In caso di errore → mostro messaggio nella JSP
            request.setAttribute("error", "Errore nel caricamento prodotti.");
            request.getRequestDispatcher("/pagine/admin/adminProdotti.jsp")
                   .forward(request, response);
        }
    }

    // ======================================================================
    // ⭐ POST → Aggiornamento o eliminazione prodotto
    // ======================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ Controllo accesso Admin
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

                // ============================================================
                // ⭐ UPDATE: aggiorna SOLO i dati testuali del prodotto
                // ============================================================
                case "update": {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String nome = request.getParameter("nome");
                    String brand = request.getParameter("brand");
                    String informazioni = request.getParameter("informazioni");
                    double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));

                    // Mantiene l'immagine attuale
                    String imageUrl = request.getParameter("imageUrl");

                    boolean visibile = Boolean.parseBoolean(request.getParameter("visibile"));
                    int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

                    Categoria cat = categoriaDAO.findById(categoriaId);

                    // Creo oggetto Prodotto aggiornato
                    Prodotto p = new Prodotto(
                            id, nome, brand, informazioni,
                            prezzo, quantita, imageUrl,
                            visibile, cat
                    );

                    prodottoDAO.update(p);
                    break;
                }

                // ============================================================
                // ⭐ DELETE: elimina un prodotto
                // ============================================================
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    prodottoDAO.delete(id);
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ⭐ PRG: Redirect per evitare reinvio form
        response.sendRedirect(request.getContextPath() + "/admin/prodotti");
    }
}
