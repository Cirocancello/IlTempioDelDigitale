package controller.admin;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/utenti")
public class AdminUtenteServlet extends HttpServlet {

    // ============================================================
    // ⭐ Controllo ruolo admin
    // ============================================================
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    // ============================================================
    // ⭐ GET → Lista utenti + Modifica utente
    // ============================================================
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

        UtenteDAO utenteDAO = new UtenteDAO();

        try {
            switch (action) {

                // ============================================================
                // ⭐ EDIT → Mostra form di modifica utente
                // ============================================================
                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Utente u = utenteDAO.findById(id);

                    if (u == null) {
                        request.setAttribute("error", "Utente non trovato.");
                        break;
                    }

                    request.setAttribute("utente", u);

                    // ⭐ VERSIONE CORRETTA → usa adminModificaUtente.jsp
                    request.getRequestDispatcher("/pagine/admin/adminModificaUtente.jsp")
                           .forward(request, response);
                    return;
                }

                // ============================================================
                // ⭐ DEFAULT → Mostra lista utenti
                // ============================================================
                default: {
                    List<Utente> utenti = utenteDAO.findAll();
                    request.setAttribute("utenti", utenti);
                    request.getRequestDispatcher("/pagine/admin/adminUtente.jsp")
                           .forward(request, response);
                    return;
                }
            }

        } catch (Exception e) {
            request.setAttribute("error", "Errore nel caricamento utenti.");
            request.getRequestDispatcher("/pagine/admin/adminUtente.jsp")
                   .forward(request, response);
        }
    }

    // ============================================================
    // ⭐ POST → Create / Update / Delete
    // ============================================================
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

        UtenteDAO utenteDAO = new UtenteDAO();

        try {
            switch (action) {

                // ============================================================
                // ⭐ CREATE
                // ============================================================
                case "create": {
                    String nome = request.getParameter("nome");
                    String cognome = request.getParameter("cognome");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    int role = Integer.parseInt(request.getParameter("role"));

                    Utente u = new Utente(nome, cognome, email, password, role);
                    utenteDAO.register(u);
                    break;
                }

                // ============================================================
                // ⭐ UPDATE
                // ============================================================
                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Utente u = utenteDAO.findById(id);

                    if (u != null) {
                        u.setNome(request.getParameter("nome"));
                        u.setCognome(request.getParameter("cognome"));
                        u.setEmail(request.getParameter("email"));
                        u.setRole(Integer.parseInt(request.getParameter("role")));

                        utenteDAO.update(u);
                    }
                    break;
                }

                // ============================================================
                // ⭐ DELETE
                // ============================================================
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    utenteDAO.delete(id);
                    break;
                }

                default:
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ⭐ PRG
        response.sendRedirect(request.getContextPath() + "/admin/utenti");
    }
}
