package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import model.Utente;
import model.Prodotto;
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

        // 🔐 CONTROLLO TOKEN 
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // 🔐 CONTROLLO UTENTE ID
        if (session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        int utenteId = (int) session.getAttribute("utenteId");
        Utente utente = utenteDAO.findById(utenteId);

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        // 🧠 CARICA LISTA PREFERITI (PRODOTTI COMPLETI)
        try (Connection conn = DBConnection.getConnection()) {
            PreferitiDAO preferitiDAO = new PreferitiDAO(conn);
            List<Prodotto> listaPreferiti = preferitiDAO.findProdottiByUtente(utenteId);
            request.setAttribute("listaPreferiti", listaPreferiti);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento dei preferiti: " + e.getMessage());
        }

        // ✅ SET UTENTE E FORWARD
        request.setAttribute("utente", utente);
        request.getRequestDispatcher("/pagine/profile.jsp").forward(request, response);
    }
}
