package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * PasswordUtils
 * -------------------------
 * Classe di utilità che gestisce:
 *  - hashing delle password (SHA-256)
 *  - verifica tra password in chiaro e hash salvato nel DB
 *
 * L’obiettivo è NON salvare mai password in chiaro nel database.
 */
public class PasswordUtils {

    /**
     * ⭐ hashPassword()
     * -------------------------
     * Riceve una password in chiaro e restituisce il suo hash SHA-256.
     * L’hash è una stringa esadecimale impossibile da invertire.
     */
    public static String hashPassword(String password) {
        try {
            // Ottengo un'istanza dell’algoritmo SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Applico l’hash alla password (convertita in byte)
            byte[] hashedBytes = md.digest(password.getBytes());

            // Converto i byte in una stringa esadecimale leggibile
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b)); // converte ogni byte in due cifre esadecimali
            }

            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            // SHA-256 è sempre disponibile, quindi questo errore è molto raro
            throw new RuntimeException("Errore hashing password: " + e.getMessage());
        }
    }

    /**
     * ⭐ verifyPassword()
     * -------------------------
     * Confronta:
     *  - la password inserita dall’utente (in chiaro)
     *  - l’hash salvato nel database
     *
     * Funziona così:
     *  1) hash della password inserita
     *  2) confronto tra i due hash
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {

        // Calcolo l’hash della password inserita dall’utente
        String hashOfInput = hashPassword(plainPassword);

        // Se l’hash coincide con quello salvato → password corretta
        return hashOfInput.equals(hashedPassword);
    }
}
