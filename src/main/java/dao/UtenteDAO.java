package dao;

import db.DBConnection;
import model.Utente;
import util.PasswordUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtenteDAO {

    // ============================================================
    // 1️⃣ REGISTRAZIONE
    // ============================================================
    public boolean register(Utente u) {
        String sql = "INSERT INTO utente (nome, cognome, email, _password, oauth, propic_url, provincia, cap, via, civico, note, _role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, safe(u.getNome()));
            ps.setString(2, safe(u.getCognome()));
            ps.setString(3, safe(u.getEmail()));
            ps.setString(4, safe(u.getPassword()));
            ps.setBoolean(5, u.isOauth());
            ps.setString(6, safe(u.getPropicUrl()));
            ps.setString(7, safe(u.getProvincia()));
            ps.setString(8, safe(u.getCap()));
            ps.setString(9, safe(u.getVia()));
            ps.setString(10, safe(u.getCivico()));
            ps.setString(11, safe(u.getNote()));
            ps.setInt(12, u.getRole());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Errore registrazione utente: " + e.getMessage());
            return false;
        }
    }

    // ============================================================
    // LOGIN
    // ============================================================
    public Utente login(String email, String plainPassword) {
        String sql = "SELECT * FROM utente WHERE email=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("_password");

                if (PasswordUtils.verifyPassword(plainPassword, hashedPassword)) {
                    return map(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore login utente: " + e.getMessage());
        }

        return null;
    }

    // ============================================================
    // FIND BY EMAIL
    // ============================================================
    public Utente findByEmail(String email) {
        String sql = "SELECT * FROM utente WHERE email=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) {
            System.err.println("Errore ricerca utente per email: " + e.getMessage());
        }

        return null;
    }

    // ============================================================
    // FIND BY ID
    // ============================================================
    public Utente findById(int id) {
        String sql = "SELECT * FROM utente WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) {
            System.err.println("Errore ricerca utente per ID: " + e.getMessage());
        }

        return null;
    }

    // ============================================================
    // EXISTS BY EMAIL
    // ============================================================
    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM utente WHERE email=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            System.err.println("Errore verifica email: " + e.getMessage());
            return false;
        }
    }

    // ============================================================
    // UPDATE
    // ============================================================
    public boolean update(Utente u) {
        String sql = "UPDATE utente SET nome=?, cognome=?, email=?, _password=?, oauth=?, propic_url=?, provincia=?, cap=?, via=?, civico=?, note=?, _role=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, safe(u.getNome()));
            ps.setString(2, safe(u.getCognome()));
            ps.setString(3, safe(u.getEmail()));
            ps.setString(4, safe(u.getPassword()));
            ps.setBoolean(5, u.isOauth());
            ps.setString(6, safe(u.getPropicUrl()));
            ps.setString(7, safe(u.getProvincia()));
            ps.setString(8, safe(u.getCap()));
            ps.setString(9, safe(u.getVia()));
            ps.setString(10, safe(u.getCivico()));
            ps.setString(11, safe(u.getNote()));
            ps.setInt(12, u.getRole());
            ps.setInt(13, u.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Errore aggiornamento utente: " + e.getMessage());
            return false;
        }
    }

    // ============================================================
    //  DELETE — VERSIONE CORRETTA (con eliminazione ordini)
    // ============================================================
    public boolean delete(int idUtente) {

        String sqlDeleteProdotti = 
            "DELETE po FROM prodotto_ordine po " +
            "JOIN ordine o ON po.id_ordine = o.id " +
            "WHERE o.id_utente = ?";

        String sqlDeleteOrdini = "DELETE FROM ordine WHERE id_utente = ?";
        String sqlDeleteUtente = "DELETE FROM utente WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {

            conn.setAutoCommit(false);

            // 1️⃣ Elimina prodotti degli ordini dell’utente
            try (PreparedStatement ps = conn.prepareStatement(sqlDeleteProdotti)) {
                ps.setInt(1, idUtente);
                ps.executeUpdate();
            }

            // 2️⃣ Elimina ordini dell’utente
            try (PreparedStatement ps = conn.prepareStatement(sqlDeleteOrdini)) {
                ps.setInt(1, idUtente);
                ps.executeUpdate();
            }

            // 3️⃣ Elimina l’utente
            int rows;
            try (PreparedStatement ps = conn.prepareStatement(sqlDeleteUtente)) {
                ps.setInt(1, idUtente);
                rows = ps.executeUpdate();
            }

            conn.commit();
            return rows == 1;

        } catch (SQLException e) {
            System.err.println("Errore cancellazione utente: " + e.getMessage());
            return false;
        }
    }

    // ============================================================
    // FIND ALL (per admin)
    // ============================================================
    public List<Utente> findAll() {
        List<Utente> utenti = new ArrayList<>();
        String sql = "SELECT * FROM utente ORDER BY nome ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) utenti.add(map(rs));

        } catch (SQLException e) {
            System.err.println("Errore lista utenti: " + e.getMessage());
        }

        return utenti;
    }

    // ============================================================
    // MAPPATORE
    // ============================================================
    private Utente map(ResultSet rs) throws SQLException {
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

    // ============================================================
    // SAFE STRING
    // ============================================================
    private String safe(String value) {
        return value == null ? "" : value.trim();
    }
}
