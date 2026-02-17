package controller;

import dao.PreferitiDAO;
import model.Utente;
import db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

/**
 * PreferitiServlet
 * ---------------------------------------------------------
 * Gestisce l'aggiunta, la rimozione e la visualizzazione
 * dei prodotti preferiti dell’utente.
 *
 * Funzionalità:
 * - Controllo autenticazione
 * - Aggiunta preferito (POST)
 * - Rimozione preferito (POST con action=remove)
 * - Recupero lista preferiti (GET)
 * - Redirect al profilo (pattern Post/Redirect/Get)
 */
@WebServlet("/preferiti")
public class PreferitiServlet extends HttpServlet {

    /**
     * ⭐ doPost → Aggiunta o rimozione preferiti
     * ---------------------------------------------------------
     * Chiamato quando l’utente clicca:
     * - ❤️ Aggiungi ai preferiti
     * - 🗑️ Rimuovi dai preferiti
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ 1) CONTROLLO AUTENTICAZIONE
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ⭐ 2) RECUPERO UTENTE DALLA SESSIONE
        Utente u = (Utente) session.getAttribute("utente");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ⭐ 3) RECUPERO PARAMETRI DEL FORM
        String action = request.getParameter("action"); // può essere "remove" oppure null
        int prodottoId = Integer.parseInt(request.getParameter("id_prodotto"));

        // ⭐ 4) CONNESSIONE + DAO (try-with-resources)
        try (Connection conn = DBConnection.getConnection()) {

            PreferitiDAO dao = new PreferitiDAO(conn);

            // ⭐ 5) LOGICA AGGIUNTA / RIMOZIONE
            if ("remove".equalsIgnoreCase(action)) {
                // 🗑️ RIMOZIONE DAI PREFERITI
                dao.removePreferito(u.getId(), prodottoId);
            } else {
                // ❤️ AGGIUNTA AI PREFERITI
                dao.addPreferito(u.getId(), prodottoId);
            }

            // ⭐ 6) REDIRECT AL PROFILO (PRG)
            // Evita il reinvio del form se l’utente aggiorna la pagina
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {

            // ⭐ 7) GESTIONE ERRORI
            e.printStackTrace();

            // ⭐ Redirect al profilo con parametro GET per mostrare un messaggio di errore
            response.sendRedirect(request.getContextPath() + "/profile?error=preferiti");
        }
    }

    /**
     * ⭐ doGet → Recupero lista preferiti
     * ---------------------------------------------------------
     * Chiamato quando l’utente visita la pagina dei preferiti.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ⭐ 1) CONTROLLO AUTENTICAZIONE
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ⭐ 2) RECUPERO UTENTE
        Utente u = (Utente) session.getAttribute("utente");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ⭐ 3) RECUPERO LISTA PREFERITI DAL DB
        try (Connection conn = DBConnection.getConnection()) {

            PreferitiDAO dao = new PreferitiDAO(conn);

            // Imposto la lista come attributo della request
            request.setAttribute("listaPreferiti", dao.findByUtente(u.getId()));

            // ⭐ 4) REDIRECT AL PROFILO
            // Il profilo leggerà l’attributo "listaPreferiti"
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {

            // ⭐ 5) GESTIONE ERRORI
        	/**
        	 * “La riga sendRedirect(.../profile?error=preferiti) applica il pattern Post/Redirect/Get.
        	 * Dopo un errore nella gestione dei preferiti, la servlet reindirizza il browser alla pagina del profilo, passando un parametro GET che la JSP userà per mostrare un messaggio di errore.
			 * Questo evita il reinvio del form e mantiene l’URL pulito.”
        	 */
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=preferiti");
        }
    }
}
