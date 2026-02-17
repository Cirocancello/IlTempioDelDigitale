package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Utente;

/**
 * AuthFilter
 * -------------------------
 * Questo filtro protegge le pagine riservate agli utenti loggati.
 * Se un utente non è autenticato, viene reindirizzato alla pagina
 * di accesso negato.
 */
@WebFilter({"/profile", "/orders", "/carrello"}) 
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Cast necessari per usare sessione e redirect
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Recupero sessione esistente (false = non crearla se non esiste)
        HttpSession session = req.getSession(false);

        // Recupero utente loggato dalla sessione
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        // ⭐ Se l'utente NON è loggato → accesso negato
        if (u == null) {
            res.sendRedirect(req.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        // ⭐ Utente loggato → continua verso la risorsa richiesta
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nessuna configurazione iniziale necessaria
    }

    @Override
    public void destroy() {
        // Nessuna risorsa da liberare
    }
}
