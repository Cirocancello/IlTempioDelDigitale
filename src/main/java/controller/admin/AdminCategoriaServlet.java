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

@WebServlet("/admin/categorie")
public class AdminCategoriaServlet extends HttpServlet {

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

        try (Connection conn = DBConnection.getConnection()) {
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

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
            CategoriaDAO categoriaDAO = new CategoriaDAO(conn);

            switch (action) {

                case "create": {
                    String nome = request.getParameter("nome");
                    Categoria c = new Categoria(0, nome);
                    categoriaDAO.insert(c);
                    break;
                }

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String nome = request.getParameter("nome");
                    Categoria c = new Categoria(id, nome);
                    categoriaDAO.update(c);
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    categoriaDAO.delete(id);
                    break;
                }

                default:
                    // Azione non riconosciuta → ignora
            }

        } catch (Exception e) {
            // Puoi loggare l’errore se vuoi
        }

        // Redirect dopo POST
        response.sendRedirect(request.getContextPath() + "/admin/categorie");
    }
}
