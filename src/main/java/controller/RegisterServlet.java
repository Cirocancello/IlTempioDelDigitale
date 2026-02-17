package controller;

import java.io.IOException;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;
import util.PasswordUtils;
import util.Validator;

/**
 * RegisterServlet
 * ---------------------------------------------------------
 * Gestisce la registrazione di un nuovo utente.
 *
 * Funzionalità principali:
 * - Recupero e validazione dei dati del form
 * - Hashing sicuro della password
 * - Controllo email duplicata
 * - Creazione utente tramite DAO
 * - Redirect alla pagina di successo
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /**
         * ⭐ 1) RECUPERO PARAMETRI DAL FORM
         * -------------------------------------------------
         * Normalizzo l’email (trim + lowercase) per evitare
         * duplicati dovuti a maiuscole/minuscole.
         */
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email") != null
                ? request.getParameter("email").trim().toLowerCase()
                : "";
        String password = request.getParameter("password");
        String provincia = request.getParameter("provincia");
        String cap = request.getParameter("cap");
        String via = request.getParameter("via");
        String civico = request.getParameter("civico");
        String note = request.getParameter("note");

        /**
         * ⭐ 2) VALIDAZIONE INPUT
         * -------------------------------------------------
         * Uso la classe Validator per controllare:
         * - campi obbligatori non vuoti
         * - email valida
         */
        if (Validator.isEmpty(nome) || Validator.isEmpty(cognome) ||
            !Validator.isValidEmail(email) || Validator.isEmpty(password) ||
            Validator.isEmpty(provincia) || Validator.isEmpty(cap) ||
            Validator.isEmpty(via) || Validator.isEmpty(civico)) {

            request.setAttribute("error", "Compila correttamente tutti i campi obbligatori");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
            return;
        }

        /**
         * ⭐ 3) HASHING PASSWORD
         * -------------------------------------------------
         * La password non viene mai salvata in chiaro.
         * PasswordUtils usa un algoritmo sicuro (es. BCrypt).
         */
        String hashedPassword = PasswordUtils.hashPassword(password);

        /**
         * ⭐ 4) CREAZIONE OGGETTO UTENTE
         * -------------------------------------------------
         * role = 0 → utente normale
         * immagine profilo → placeholder di default
         */
        Utente u = new Utente(
            0,
            nome,
            cognome,
            email,
            hashedPassword,
            false, // admin?
            "https://via.placeholder.com/300x225",
            provincia,
            cap,
            via,
            civico,
            note,
            0 // ruolo
        );

        UtenteDAO dao = new UtenteDAO();

        /**
         * ⭐ 5) CONTROLLO EMAIL DUPLICATA
         * -------------------------------------------------
         * existsByEmail() verifica se l’email è già registrata.
         */
        if (dao.existsByEmail(email)) {
            request.setAttribute("error", "Registrazione fallita: email già registrata");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
            return;
        }

        /**
         * ⭐ 6) REGISTRAZIONE UTENTE
         * -------------------------------------------------
         * Se la registrazione va a buon fine → redirect alla
         * pagina di successo (pattern Post/Redirect/Get).
         */
        if (dao.register(u)) {

            response.sendRedirect(request.getContextPath() + "/pagine/registrazioneSuccesso.jsp");

        } else {

            /**
             * ⭐ 7) GESTIONE ERRORE GENERICO
             * -------------------------------------------------
             * In caso di problemi lato DB, mostro un messaggio
             * nella stessa pagina di registrazione.
             */
            request.setAttribute("error", "Errore durante la registrazione, riprova");
            request.getRequestDispatcher("/pagine/register.jsp").forward(request, response);
        }
    }
}
