package controller;

import dao.FeedbackDAO;
import db.DBConnection;
import model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/aggiungi-feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parametri dal form
        int prodottoId = Integer.parseInt(request.getParameter("prodottoId"));
        String titolo = request.getParameter("titolo");
        String descrizione = request.getParameter("descrizione");
        int score = Integer.parseInt(request.getParameter("score"));

        try (Connection conn = DBConnection.getConnection()) {

            FeedbackDAO dao = new FeedbackDAO(conn);

            Feedback f = new Feedback();
            f.setProdottoId(prodottoId);
            f.setTitolo(titolo);
            f.setDescrizione(descrizione);
            f.setScore(score);

            dao.insertFeedback(f);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Torna alla pagina prodotto
        response.sendRedirect(request.getContextPath() + "/prodotto?id=" + prodottoId);
    }
}
