package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * LogoutServlet
 * -------------------------
 * Gestisce il logout dell’utente.
 * - Recupera la sessione esistente
 * - La invalida per eliminare tutti i dati dell’utente
 * - Reindirizza alla pagina di conferma logout
 *
 * È una servlet molto semplice ma fondamentale per la sicurezza:
 * impedisce che i dati dell’utente rimangano in memoria dopo l’uscita.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ Recupero la sessione esistente
         * getSession(false) → NON crea una nuova sessione se non esiste.
         * Se esiste, significa che l’utente è loggato.
         */
        HttpSession session = request.getSession(false);

        /**
         * ⭐ Invalido la sessione
         * Questo:
         * - elimina tutti gli attributi (utente, ruolo, carrello, ecc.)
         * - chiude la sessione sul server
         * - impedisce accessi non autorizzati dopo il logout
         */
        if (session != null) {
            session.invalidate();
        }

        /**
         * ⭐ Redirect alla pagina di logout
         * Mostra un messaggio di conferma e un link per tornare alla home.
         */
        response.sendRedirect(request.getContextPath() + "/pagine/logout.jsp");
    }

    /**
     * ⭐ Supporto anche per richieste POST
     * Se il logout viene inviato tramite form POST,
     * lo gestisco comunque come un GET.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
