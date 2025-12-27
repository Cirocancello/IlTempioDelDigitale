package dao;

import db.DBConnection;
import model.Utente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UtenteDAO.java
 * -----------------
 * Gestisce l'accesso al DB per l'entità Utente.
 * Basato sullo schema td.utente.
 */
public class UtenteDAO {

    // Registrazione nuovo utente
    public boolean register(Utente u) {
        String sql = "INSERT INTO utente (nome, cognome, email, _password, oauth, propic_url, provincia, cap, via, civico, note, _role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, safeString(u.getNome()));
            ps.setString(2, safeString(u.getCognome()));
            ps.setString(3, safeString(u.getEmail()));
            ps.setString(4, safeString(u.getPassword()));
            ps.setBoolean(5, u.isOauth());
            ps.setString(6, safeString(u.getPropicUrl()));
            ps.setString(7, safeString(u.getProvincia()));
            ps.setString(8, safeString(u.getCap()));
            ps.setString(9, safeString(u.getVia()));
            ps.setString(10, safeString(u.getCivico()));
            ps.setString(11, safeString(u.getNote()));
            ps.setInt(12, u.getRole());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Errore registrazione utente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Login utente (nuova miglioria)
    public Utente login(String email, String password) {
        String sql = "SELECT * FROM utente WHERE email=? AND _password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUtente(rs);
            }
        } catch (SQLException e) {
            System.err.println("Errore login utente: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Trova utente per email
    public Utente findByEmail(String email) {
        String sql = "SELECT * FROM utente WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUtente(rs);
            }
        } catch (SQLException e) {
            System.err.println("Errore ricerca utente per email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Trova utente per ID
    public Utente findById(int id) {
        String sql = "SELECT * FROM utente WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUtente(rs);
            }
        } catch (SQLException e) {
            System.err.println("Errore ricerca utente per ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Verifica se esiste un utente con una certa email
    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM utente WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Errore verifica email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Aggiorna utente
    public boolean update(Utente u) {
        String sql = "UPDATE utente SET nome=?, cognome=?, email=?, _password=?, oauth=?, propic_url=?, provincia=?, cap=?, via=?, civico=?, note=?, _role=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, safeString(u.getNome()));
            ps.setString(2, safeString(u.getCognome()));
            ps.setString(3, safeString(u.getEmail()));
            ps.setString(4, safeString(u.getPassword()));
            ps.setBoolean(5, u.isOauth());
            ps.setString(6, safeString(u.getPropicUrl()));
            ps.setString(7, safeString(u.getProvincia()));
            ps.setString(8, safeString(u.getCap()));
            ps.setString(9, safeString(u.getVia()));
            ps.setString(10, safeString(u.getCivico()));
            ps.setString(11, safeString(u.getNote()));
            ps.setInt(12, u.getRole());
            ps.setInt(13, u.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Errore aggiornamento utente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Cancella utente
    public boolean delete(int id) {
        String sql = "DELETE FROM utente WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore cancellazione utente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lista di tutti gli utenti
    public List<Utente> listAll() {
        List<Utente> utenti = new ArrayList<>();
        String sql = "SELECT * FROM utente";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                utenti.add(mapResultSetToUtente(rs));
            }
        } catch (SQLException e) {
            System.err.println("Errore lista utenti: " + e.getMessage());
            e.printStackTrace();
        }
        return utenti;
    }

    // Metodo di supporto per mappare ResultSet -> Utente
    private Utente mapResultSetToUtente(ResultSet rs) throws SQLException {
        Utente u = new Utente();
        u.setId(rs.getInt("id"));
        u.setNome(rs.getString("nome"));
        u.setCognome(rs.getString("cognome"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("_password"));
        u.setOauth(rs.getBoolean("oauth"));
        u.setPropicUrl(rs.getString("propic_url"));
        u.setProvincia(rs.getString("provincia"));
        u.setCap(rs.getString("cap"));
        u.setVia(rs.getString("via"));
        u.setCivico(rs.getString("civico"));
        u.setNote(rs.getString("note"));
        u.setRole(rs.getInt("_role"));
        return u;
    }

    // Utility per evitare NullPointerException
    private String safeString(String value) {
        return value == null ? "" : value.trim();
    }
}
