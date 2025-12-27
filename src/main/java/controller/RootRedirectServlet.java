package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("")   // ✅ intercetta la root del progetto
public class RootRedirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        // ✅ Reindirizza alla servlet /index
        response.sendRedirect("index");
    }
}


/*
Quindi il flusso è:
L’utente apre /

RootRedirectServlet → sendRedirect("index")

Il browser apre /index
/index = ProdottiTopServlet
La servlet carica i prodotti
La servlet fa forward a index.jsp
La JSP viene mostrata

✅ È la servlet che decide quale JSP mostrare ✅ Non il redirect ✅ Non il browser
*/