package controller.admin;

import dao.CategoriaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Categoria;
import model.Utente;
import db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * AdminCategoriaServlet
 * ------------------------------------------------------------
 * Gestisce tutte le operazioni CRUD sulle categorie:
 *
 *  - Visualizzazione lista categorie (GET)
 *  - Apertura pagina modifica categoria (GET → action=edit)
 *  - Creazione categoria (POST)
 *  - Modifica categoria (POST)
 *  - Eliminazione categoria (POST)
 *
 * Accesso consentito solo agli amministratori (role == 1).
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → DAO → Model → JSP)
 *  - Session Management
 *  - PRG (Post-Redirect-Get)
 */
@WebServlet("/admin/categorie")
public class AdminCategoriaServlet extends HttpServlet {

    /**
     * ⭐ Metodo di utilità per verificare se l’utente è admin.
     */
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    // ======================================================================
    // ⭐ GET → Mostra lista categorie OPPURE apre la pagina di modifica
    // ======================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo accesso admin
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Controllo se è stata richiesta l’azione "edit"
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {

            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            // ============================================================
            // ⭐ EDIT → apre la pagina di modifica categoria
            // ============================================================
            if ("edit".equals(action)) {

                // Recupero ID categoria
                int id = Integer.parseInt(request.getParameter("id"));

                // Recupero categoria dal DB
                Categoria c = categoriaDAO.findById(id);

                // Se non esiste → torna alla lista
                if (c == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/categorie");
                    return;
                }

                // Passo la categoria alla JSP
                request.setAttribute("categoria", c);

                // Forward alla pagina di modifica
                request.getRequestDispatcher("/pagine/admin/adminModificaCategoria.jsp")
                       .forward(request, response);
                return;
            }

            // ============================================================
            // ⭐ LISTA CATEGORIE (default)
            // ============================================================
            List<Categoria> categorie = categoriaDAO.findAll();
            request.setAttribute("categorie", categorie);

            request.getRequestDispatcher("/pagine/admin/adminCategorie.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Errore nel caricamento categorie.");
            request.getRequestDispatcher("/pagine/admin/adminCategorie.jsp")
                   .forward(request, response);
        }
    }

    // ======================================================================
    // ⭐ POST → Gestisce create, update, delete
    // ======================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo accesso admin
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Azione richiesta
        String action = request.getParameter("action");
        if (action == null) action = "";

        try (Connection conn = DBConnection.getConnection()) {

            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            switch (action) {

                // ============================================================
                // ⭐ CREATE → aggiunge una nuova categoria
                // ============================================================
                case "create": {
                    String nome = request.getParameter("nome");
                    Categoria c = new Categoria(0, nome);
                    categoriaDAO.insert(c);
                    break;
                }

                // ============================================================
                // ⭐ UPDATE → modifica una categoria esistente
                // ============================================================
                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String nome = request.getParameter("nome");
                    Categoria c = new Categoria(id, nome);
                    categoriaDAO.update(c);
                    break;
                }

                // ============================================================
                // ⭐ DELETE → elimina una categoria
                // ============================================================
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    categoriaDAO.delete(id);
                    break;
                }

                default:
                    break;
            }

        } catch (Exception e) {
            // Log se necessario
        }

        // ⭐ PRG (Post-Redirect-Get)
        response.sendRedirect(request.getContextPath() + "/admin/categorie");
    }
}
