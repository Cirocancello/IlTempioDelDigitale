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

    public OrdineDAO(Connection conn) {
        this.conn = conn;
    }

    // ============================================================
    // 1️⃣ CREAZIONE ORDINE
    // ============================================================
    public boolean createOrdine(Ordine ordine) throws SQLException {

        String sqlOrdine = "INSERT INTO ordine (id, id_utente, _data, stato) VALUES (?, ?, ?, ?)";
        String sqlProdotti = "INSERT INTO prodotto_ordine (id_prodotto, id_ordine, prezzo_effettivo, iva, quantita) VALUES (?, ?, ?, ?, ?)";

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

            // Inserimento prodotti
            try (PreparedStatement ps = conn.prepareStatement(sqlProdotti)) {
                for (Prodotto p : ordine.getProdotti()) {
                    ps.setInt(1, p.getId());
                    ps.setString(2, ordineId);
                    ps.setDouble(3, p.getPrezzo());
                    ps.setDouble(4, 0.22);
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

    // ============================================================
    // 2️⃣ FILTRO + PAGINAZIONE (ADMIN) — VERSIONE CORRETTA
    // ============================================================
    public List<Ordine> filtraOrdini(String from, String to, Integer userId, int limit, int offset) throws SQLException {

        StringBuilder sql = new StringBuilder("SELECT * FROM ordine WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        // ⭐ Filtro data inizio (00:00:00)
        if (from != null && !from.isEmpty()) {
            sql.append(" AND _data >= ?");
            params.add(Timestamp.valueOf(from + " 00:00:00"));
        }

        // ⭐ Filtro data fine (23:59:59)
        if (to != null && !to.isEmpty()) {
            sql.append(" AND _data <= ?");
            params.add(Timestamp.valueOf(to + " 23:59:59"));
        }

        // ⭐ Filtro utente
        if (userId != null) {
            sql.append(" AND id_utente = ?");
            params.add(userId);
        }

        sql.append(" ORDER BY _data DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        PreparedStatement ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        List<Ordine> ordini = new ArrayList<>();

        while (rs.next()) {
            Ordine ordine = new Ordine();
            ordine.setId(rs.getString("id"));
            ordine.setData(rs.getTimestamp("_data"));
            ordine.setStato(rs.getString("stato"));

            ordine.setUtente(getUtenteById(rs.getInt("id_utente")));
            ordine.setProdotti(getProdottiByOrdine(ordine.getId()));

            ordini.add(ordine);
        }

        return ordini;
    }

    // ============================================================
    // 3️⃣ CONTEGGIO ORDINI PER PAGINAZIONE — VERSIONE CORRETTA
    // ============================================================
    public int countOrdini(String from, String to, Integer userId) throws SQLException {

        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ordine WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (from != null && !from.isEmpty()) {
            sql.append(" AND _data >= ?");
            params.add(Timestamp.valueOf(from + " 00:00:00"));
        }

        if (to != null && !to.isEmpty()) {
            sql.append(" AND _data <= ?");
            params.add(Timestamp.valueOf(to + " 23:59:59"));
        }

        if (userId != null) {
            sql.append(" AND id_utente = ?");
            params.add(userId);
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);

        return 0;
    }

    // ============================================================
    // 4️⃣ ORDINI PER UTENTE
    // ============================================================
    public List<Ordine> findByUtente(int idUtente) throws SQLException {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY _data DESC";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idUtente);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Ordine ordine = new Ordine();
            ordine.setId(rs.getString("id"));
            ordine.setData(rs.getTimestamp("_data"));
            ordine.setStato(rs.getString("stato"));

            ordine.setUtente(getUtenteById(idUtente));
            ordine.setProdotti(getProdottiByOrdine(ordine.getId()));

            ordini.add(ordine);
        }

        return ordini;
    }

    // ============================================================
    // 5️⃣ UPDATE STATO
    // ============================================================
    public boolean updateStato(String idOrdine, String nuovoStato) throws SQLException {
        String sql = "UPDATE ordine SET stato = ? WHERE id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, nuovoStato);
        ps.setString(2, idOrdine);

        return ps.executeUpdate() == 1;
    }

    // ============================================================
    // 6️⃣ DELETE ORDINE
    // ============================================================
    public boolean delete(String idOrdine) throws SQLException {
        String sql = "DELETE FROM ordine WHERE id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, idOrdine);

        return ps.executeUpdate() == 1;
    }

    // ============================================================
    // 7️⃣ PRODOTTI DI UN ORDINE
    // ============================================================
    private List<Prodotto> getProdottiByOrdine(String idOrdine) throws SQLException {

        String sql = "SELECT p.id, p.nome, p.brand, p.image_url, po.quantita, po.prezzo_effettivo " +
                     "FROM prodotto_ordine po " +
                     "JOIN prodotto p ON po.id_prodotto = p.id " +
                     "WHERE po.id_ordine = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, idOrdine);

        ResultSet rs = ps.executeQuery();
        List<Prodotto> prodotti = new ArrayList<>();

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

        return prodotti;
    }

    // ============================================================
    // 8️⃣ UTENTE DI UN ORDINE
    // ============================================================
    private Utente getUtenteById(int idUtente) throws SQLException {

        String sql = "SELECT * FROM utente WHERE id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idUtente);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Utente u = new Utente();
            u.setId(rs.getInt("id"));
            u.setNome(rs.getString("nome"));
            u.setCognome(rs.getString("cognome"));
            u.setEmail(rs.getString("email"));
            u.setRole(rs.getInt("_role"));
            return u;
        }

        return null;
    }
}
