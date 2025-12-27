package controller;

import dao.ProdottoDAO;
import model.Prodotto;
import db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/index")
public class ProdottiTopServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            ProdottoDAO dao = new ProdottoDAO(conn);

            // Recupera i top 3 prodotti più venduti
            List<Prodotto> prodottiTop = dao.getProdottiTopVenduti(3);

            // Passa la lista alla JSP
            request.setAttribute("prodottiTop", prodottiTop);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel recupero dei prodotti più venduti");
        }

        // Forward alla index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
