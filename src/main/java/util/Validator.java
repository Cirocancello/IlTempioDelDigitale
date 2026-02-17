package util;

/**
 * Validator
 * -------------------------
 * Classe di utilità per validare input lato server.
 * Serve come seconda protezione dopo la validazione JavaScript.
 * Garantisce che i dati siano corretti e sicuri prima di arrivare al DB.
 */
public class Validator {

    /**
     * ⭐ Controlla se una stringa è nulla o vuota
     */
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * ⭐ Normalizza una stringa:
     * - rimuove spazi iniziali/finali
     * - converte in minuscolo
     */
    public static String normalize(String value) {
        if (value == null) return null;
        return value.trim().toLowerCase();
    }

    /**
     * ⭐ Controlla se l'email ha un formato valido
     * Usa una regex semplice per verificare la struttura base.
     */
    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) return false;

        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.matches(regex);
    }

    /**
     * ⭐ Controlla se un CAP è valido
     * Deve essere composto da esattamente 5 cifre.
     */
    public static boolean isValidCap(String cap) {
        if (isEmpty(cap)) return false;
        return cap.matches("\\d{5}");
    }

    /**
     * ⭐ Controlla se un civico è valido
     * Può essere numerico o alfanumerico breve (max 6 caratteri).
     */
    public static boolean isValidCivico(String civico) {
        if (isEmpty(civico)) return false;
        return civico.matches("^[0-9A-Za-z]{1,6}$");
    }

    /**
     * ⭐ Controlla se la password rispetta requisiti minimi:
     * - almeno 8 caratteri
     * - almeno una lettera
     * - almeno un numero
     */
    public static boolean isValidPassword(String password) {
        if (isEmpty(password)) return false;

        String regex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$";
        return password.matches(regex);
    }
}
