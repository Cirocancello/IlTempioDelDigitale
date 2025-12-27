package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Utente;

@WebFilter({"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        // ✅ NON filtrare la login admin
        if (path.endsWith("/admin/login")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (u == null || u.getRole() != 1) {
            res.sendRedirect(req.getContextPath() + "/pagine/accessoNegato.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
