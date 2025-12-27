package controller;

import dao.ProdottoDAO;
import dao.FeedbackDAO;
import model.Prodotto;
import model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection; // ✅ usa JDBC
import java.util.List;

import db.DBConnection; // ✅ Assicurati che questa classe esista

@WebServlet("/prodotto")
public class ProdottoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            int idProdotto = Integer.parseInt(idStr);

            ProdottoDAO prodottoDAO = new ProdottoDAO(conn);
            FeedbackDAO feedbackDAO = new FeedbackDAO(conn);

            Prodotto prodotto = prodottoDAO.findById(idProdotto);
            List<Feedback> feedbacks = feedbackDAO.findByProdotto(idProdotto);

            if (prodotto == null) {
                response.sendRedirect(request.getContextPath() + "/catalogo");
                return;
            }

            request.setAttribute("prodotto", prodotto);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("/pagine/prodotto.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento del prodotto.");
            request.getRequestDispatcher("/pagine/prodotto.jsp").forward(request, response);
        }
    }
}
