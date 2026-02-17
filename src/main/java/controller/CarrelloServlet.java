package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import model.Prodotto;

/**
 * CarrelloServlet
 * ------------------------------------------------------------
 * Questa servlet gestisce esclusivamente la VISUALIZZAZIONE del carrello.
 *
 * Tutte le operazioni (aggiungi, rimuovi, incrementa, decrementa)
 * sono gestite dalla CarrelloAjaxServlet tramite chiamate AJAX.
 *
 * Pattern utilizzati:
 *  - MVC (Servlet → JSP)
 *  - Sessione per mantenere il carrello dell’utente
 */

/*
 * “Il carrello è mantenuto in sessione.
 * Le operazioni (aggiungi, rimuovi, incrementa, decrementa) sono gestite tramite AJAX da una servlet dedicata che risponde in JSON.
 * La pagina non si ricarica mai: lo script aggiorna dinamicamente badge e quantità.
 * La servlet /carrello serve solo per mostrare la pagina del carrello tramite forward alla JSP.
 * Questo separa perfettamente la logica di visualizzazione dalla logica di aggiornamento.”
 */
@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {

    /**
     * ⭐ Recupera il carrello dalla sessione.
     * Se non esiste, lo crea.
     */
    @SuppressWarnings("unchecked")
    private List<Prodotto> getCarrello(HttpSession session) {
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        return carrello;
    }

    // ======================================================================
    // ⭐ GET → Mostra la pagina del carrello
    // ======================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Controllo autenticazione utente
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
            return;
        }

        // ⭐ Assicura che il carrello esista in sessione
        getCarrello(session);

        // ⭐ Mostra la pagina del carrello
        request.getRequestDispatcher("/pagine/carrello.jsp")
               .forward(request, response);
    }

    // ======================================================================
    // ⭐ POST → NON SERVE PIÙ
    // Tutte le operazioni sono gestite da CarrelloAjaxServlet
    // ======================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Per sicurezza, reindirizziamo sempre al carrello
        response.sendRedirect(request.getContextPath() + "/carrello");
    }
}
