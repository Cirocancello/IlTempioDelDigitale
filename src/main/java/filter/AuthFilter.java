package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Utente;

/**
 * AuthFilter.java
 * -----------------
 * Controlla che l'utente sia autenticato prima di accedere alle pagine protette.
 */
@WebFilter({"/profile", "/orders", "/carrello"}) // meglio filtrare le Servlet
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (u == null) {
            // Utente non autenticato → redirect a pagina di accesso negato
            res.sendRedirect(req.getContextPath() + "/pagine/accessoNegato.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
