package dao;

import model.Ordine;
import model.Prodotto;
import model.Utente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class OrdineDAO {

    private final Connection conn;

    // Costruttore
    public OrdineDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Crea un nuovo ordine con i prodotti associati.
     */
    public boolean createOrdine(Ordine ordine) throws SQLException {

        String sqlOrdine = "INSERT INTO ordine (id, id_utente, _data, stato) VALUES (?, ?, ?, ?)";
        String sqlProdotti = "INSERT INTO prodotto_ordine (id_prodotto, id_ordine, prezzo_effettivo, iva, quantita) VALUES (?, ?, ?, ?, ?)";

        // Genera UUID per l'ordine
        String ordineId = UUID.randomUUID().toString();
        ordine.setId(ordineId);

        try {
            conn.setAutoCommit(false);

            // Inserimento ordine
            try (PreparedStatement ps = conn.prepareStatement(sqlOrdine)) {
                ps.setString(1, ordineId);
                ps.setInt(2, ordine.getUtente().getId());
                ps.setTimestamp(3, new Timestamp(ordine.getData().getTime()));
                ps.setString(4, ordine.getStato());
                ps.executeUpdate();
            }

            // Inserimento prodotti associati
            try (PreparedStatement ps = conn.prepareStatement(sqlProdotti)) {
                for (Prodotto p : ordine.getProdotti()) {
                    ps.setInt(1, p.getId());
                    ps.setString(2, ordineId);
                    ps.setDouble(3, p.getPrezzo());
                    ps.setDouble(4, 0.22); // IVA simulata
                    ps.setInt(5, p.getQuantita());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            throw e;

        } finally {
            conn.setAutoCommit(true);
        }
    }

    /**
     * Recupera tutti gli ordini (per admin).
     */
    public List<Ordine> findAll() throws SQLException {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine ORDER BY _data DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setId(rs.getString("id"));
                ordine.setData(rs.getTimestamp("_data"));
                ordine.setStato(rs.getString("stato"));

                // ⭐ Carica l'utente associato
                ordine.setUtente(getUtenteById(rs.getInt("id_utente")));

                // Carica i prodotti associati
                ordine.setProdotti(getProdottiByOrdine(ordine.getId()));

                ordini.add(ordine);
            }
        }
        return ordini;
    }

    /**
     * Recupera gli ordini di un utente.
     */
    public List<Ordine> findByUtente(int idUtente) throws SQLException {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY _data DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine ordine = new Ordine();
                    ordine.setId(rs.getString("id"));
                    ordine.setData(rs.getTimestamp("_data"));
                    ordine.setStato(rs.getString("stato"));

                    // ⭐ Carica l'utente associato
                    ordine.setUtente(getUtenteById(rs.getInt("id_utente")));

                    // Carica i prodotti associati
                    ordine.setProdotti(getProdottiByOrdine(ordine.getId()));

                    ordini.add(ordine);
                }
            }
        }
        return ordini;
    }

    /**
     * Aggiorna lo stato di un ordine.
     */
    public boolean updateStato(String idOrdine, String nuovoStato) throws SQLException {
        String sql = "UPDATE ordine SET stato = ? WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuovoStato);
            ps.setString(2, idOrdine);
            return ps.executeUpdate() == 1;
        }
    }

    /**
     * Elimina un ordine.
     */
    public boolean delete(String idOrdine) throws SQLException {
        String sql = "DELETE FROM ordine WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idOrdine);
            return ps.executeUpdate() == 1;
        }
    }

    /**
     * Recupera i prodotti associati a un ordine.
     */
    private List<Prodotto> getProdottiByOrdine(String idOrdine) throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();

        String sql = "SELECT p.id, p.nome, p.brand, p.image_url, po.quantita, po.prezzo_effettivo " +
                     "FROM prodotto_ordine po " +
                     "JOIN prodotto p ON po.id_prodotto = p.id " +
                     "WHERE po.id_ordine = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idOrdine);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setBrand(rs.getString("brand"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setQuantita(rs.getInt("quantita"));
                    p.setPrezzo(rs.getDouble("prezzo_effettivo"));

                    prodotti.add(p);
                }
            }
        }

        return prodotti;
    }

    /**
     * Recupera l'utente associato a un ordine.
     */
    
    
    private Utente getUtenteById(int idUtente) throws SQLException {
        String sql = "SELECT * FROM utente WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Utente u = new Utente();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("nome"));
                    u.setCognome(rs.getString("cognome"));
                    u.setEmail(rs.getString("email"));
                    u.setRole(rs.getInt("_role")); // ⭐ CORRETTO
                    return u;
                }
            }
        }
        return null;
    }

}
