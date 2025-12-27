package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import model.Utente;
import model.Preferito;
import dao.UtenteDAO;
import dao.PreferitiDAO;
import db.DBConnection;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtenteDAO utenteDAO = new UtenteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        int utenteId = (int) session.getAttribute("utenteId");
        Utente utente = utenteDAO.findById(utenteId);

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        // ✅ Carica anche i preferiti dell’utente
        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO preferitiDAO = new PreferitiDAO(conn);
            List<Preferito> listaPreferiti = preferitiDAO.findByUtente(utenteId);
            request.setAttribute("listaPreferiti", listaPreferiti);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento dei preferiti: " + e.getMessage());
        }

        request.setAttribute("utente", utente);
        request.getRequestDispatcher("/pagine/profile.jsp").forward(request, response);
    }
}
