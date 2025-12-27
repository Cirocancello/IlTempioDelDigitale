package util;

/**
 * Validator.java
 * -----------------
 * Classe di utilità per validare input utente.
 */
public class Validator {

    // Controlla se una stringa è vuota o nulla
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // Normalizza una stringa (trim + lowercase)
    public static String normalize(String value) {
        if (value == null) return null;
        return value.trim().toLowerCase();
    }

    // Controlla se l'email ha un formato valido
    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) return false;
        // Regex semplice per email
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.matches(regex);
    }

    // Controlla se un CAP è valido (solo numeri, 5 cifre)
    public static boolean isValidCap(String cap) {
        if (isEmpty(cap)) return false;
        return cap.matches("\\d{5}");
    }

    // Controlla se un civico è valido (numerico o alfanumerico breve)
    public static boolean isValidCivico(String civico) {
        if (isEmpty(civico)) return false;
        return civico.matches("^[0-9A-Za-z]{1,6}$");
    }

    // Controlla se la password rispetta requisiti minimi
    public static boolean isValidPassword(String password) {
        if (isEmpty(password)) return false;
        // almeno 8 caratteri, una lettera e un numero
        String regex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$";
        return password.matches(regex);
    }
}
