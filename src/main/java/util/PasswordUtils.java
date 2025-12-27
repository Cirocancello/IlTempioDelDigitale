package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * PasswordUtils.java
 * -----------------
 * Classe di utilità per hashing e verifica password.
 */
public class PasswordUtils {

    // Hash password con SHA-256
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Converti in esadecimale
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Errore hashing password: " + e.getMessage());
        }
    }

    // Verifica se la password in chiaro corrisponde all'hash salvato
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        String hashOfInput = hashPassword(plainPassword);
        return hashOfInput.equals(hashedPassword);
    }
}
