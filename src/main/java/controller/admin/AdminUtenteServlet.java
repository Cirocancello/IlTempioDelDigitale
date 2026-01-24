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

        try {
            UtenteDAO utenteDAO = new UtenteDAO();
            List<Utente> utenti = utenteDAO.findAll();

            request.setAttribute("utenti", utenti);
            request.getRequestDispatcher("/pagine/admin/adminUtente.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Errore nel caricamento utenti.");
            request.getRequestDispatcher("/pagine/admin/adminUtente.jsp")
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

        try {
            UtenteDAO utenteDAO = new UtenteDAO();

            switch (action) {

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

                case "update": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String nome = request.getParameter("nome");
                    String cognome = request.getParameter("cognome");
                    String email = request.getParameter("email");
                    int role = Integer.parseInt(request.getParameter("role"));

                    Utente u = utenteDAO.findById(id);
                    if (u != null) {
                        u.setNome(nome);
                        u.setCognome(cognome);
                        u.setEmail(email);
                        u.setRole(role);
                        utenteDAO.update(u);
                    }
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    utenteDAO.delete(id);
                    break;
                }
            }

        } catch (Exception e) {
            // log se necessario
        }

        // ⭐ PRG
        response.sendRedirect(request.getContextPath() + "/admin/utenti");
    }
}
