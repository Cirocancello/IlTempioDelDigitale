package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProdottoDAO;
import model.Prodotto;
import db.DBConnection;

@WebServlet("/RicercaProdottiServlet")
public class RicercaProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String keyword = request.getParameter("q");

        // Se la ricerca è vuota, non mostrare nulla
        if (keyword == null || keyword.trim().isEmpty()) {
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO dao = new ProdottoDAO(conn);
            List<Prodotto> risultati = dao.search(keyword);

            for (Prodotto p : risultati) {
                out.println("<div class='prodotto-risultato'>");
                out.println("<h3>" + p.getNome() + "</h3>");
                out.println("<p>" + p.getInformazioni() + "</p>");
                out.println("<p>Prezzo: € " + p.getPrezzo() + "</p>");
                out.println("</div>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
