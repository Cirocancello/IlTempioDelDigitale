package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminLogoutServlet
 * ------------------------------------------------------------
 * Questa servlet gestisce il logout dell’amministratore.
 *
 * Funzionalità:
 *  - Invalida la sessione corrente
 *  - Rimuove tutti i dati dell’utente autenticato
 *  - Reindirizza alla pagina di login admin
 *
 * Pattern utilizzati:
 *  - Session Management (invalidazione sessione)
 *  - Redirect dopo operazione sensibile
 */
@WebServlet("/admin/logout")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ============================================================
        // ⭐ Recupero la sessione esistente (senza crearne una nuova)
        // ============================================================
        HttpSession session = request.getSession(false);

        // ============================================================
        // ⭐ Se la sessione esiste → invalida tutto
        // Questo rimuove:
        //   - utente
        //   - auth
        //   - role
        //   - eventuali altri attributi
        // ============================================================
        if (session != null) {
            session.invalidate(); // Logout completo
        }

        // ============================================================
        // ⭐ Redirect alla pagina di login admin
        // (non forward, perché dopo il logout è corretto creare
        //   una nuova richiesta completamente pulita)
        // ============================================================
        response.sendRedirect(request.getContextPath() + "/admin/login");
    }
}
