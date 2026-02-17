package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Utente;

import java.io.IOException;

/**
 * AdminDashboardServlet
 * ------------------------------------------------------------
 * Questa servlet gestisce la visualizzazione della dashboard
 * principale dell’area amministrativa.
 *
 * Funzionalità:
 *  - Controllo accesso admin (role == 1)
 *  - Forward alla pagina JSP della dashboard
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → JSP)
 *  - Session Management per controllare l’autenticazione
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    /**
     * ⭐ Metodo di utilità per verificare se l’utente è un amministratore.
     * Controlla:
     *  - che la sessione esista
     *  - che l’utente sia presente in sessione
     *  - che il ruolo sia 1 (admin)
     */
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Utente u = (Utente) session.getAttribute("utente");
        return u != null && u.getRole() == 1;
    }

    // ======================================================================
    // ⭐ GET → Mostra la dashboard admin
    // ======================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupero sessione esistente (senza crearne una nuova)
        HttpSession session = request.getSession(false);

        // ⭐ Controllo accesso admin
        if (!isAdmin(session)) {
            // Se non è admin → redirect al login admin
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // ⭐ Qui potresti aggiungere statistiche da mostrare nella dashboard:
        //    - numero utenti registrati
        //    - numero ordini
        //    - prodotti più venduti
        //    - ecc.
        // request.setAttribute("statistiche", ...);

        // ⭐ Forward alla JSP della dashboard
        request.getRequestDispatcher("/pagine/admin/adminDashboard.jsp")
               .forward(request, response);
    }
}
