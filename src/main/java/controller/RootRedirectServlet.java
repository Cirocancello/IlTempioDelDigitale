package controller;

import java.io.IOException;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(value = "", loadOnStartup = 1)   // 🔥 loadOnStartup = 1 = eseguita all'avvio
public class RootRedirectServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        // ⭐ Imposta la timezone italiana per tutta l'app
        TimeZone.setDefault(TimeZone.getTimeZone("Europe/Rome"));
        System.out.println("Timezone impostata a Europe/Rome");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Reindirizza alla servlet /index
        response.sendRedirect("index");
    }
}
