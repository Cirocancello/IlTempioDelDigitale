package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Utente;

/**
 * ⭐ AdminFilter
 * Questo filtro protegge tutte le pagine sotto /admin/*
 * Permette l’accesso solo agli utenti con ruolo = 1 (amministratore)
 */
@WebFilter({"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Cast a HttpServletRequest/Response per usare sessione e redirect
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Percorso richiesto (es: /IlTempioDelDigitale/admin/prodotti)
        String path = req.getRequestURI();

        // ⭐ 1) NON filtrare la pagina di login admin
        // Se filtrassi anche /admin/login, non potresti mai accedere alla login
        if (path.endsWith("/admin/login")) {
            chain.doFilter(request, response); // lascia passare
            return;
        }

        // ⭐ 2) Recupero sessione (false = non crearla se non esiste)
        HttpSession session = req.getSession(false);

        // Recupero utente loggato (se esiste)
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        // ⭐ 3) Controllo accesso:
        // - utente NON loggato → accesso negato
        // - utente loggato ma ruolo != 1 → accesso negato
        if (u == null || u.getRole() != 1) {
            // Redirect a pagina di accesso negato
            res.sendRedirect(req.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        // ⭐ 4) Utente valido → continua verso la risorsa richiesta
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Non serve configurazione iniziale
    }

    @Override
    public void destroy() {
        // Nessuna risorsa da liberare
    }
}
