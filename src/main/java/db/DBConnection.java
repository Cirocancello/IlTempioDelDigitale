package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection.java
 * -----------------
 * Classe di utilità per gestire la connessione al database MySQL.
 */
public class DBConnection {

    // Parametri di connessione (adatta secondo la tua configurazione locale)
    private static final String URL =
            "jdbc:mysql://localhost:3306/td?useSSL=false&serverTimezone=Europe/Rome";

    private static final String USER = "root";       // <-- metti il tuo utente MySQL
    private static final String PASSWORD = "root";   // <-- metti la tua password MySQL

    // Metodo statico per ottenere la connessione
    public static Connection getConnection() throws SQLException {
        try {
            // Carica il driver MySQL (necessario solo per vecchie versioni di JDBC)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Driver MySQL non trovato: " + e.getMessage());
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
