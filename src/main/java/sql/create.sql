package dao;

import model.Preferito;
import model.Prodotto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreferitiDAO {
    private final Connection conn;

    public PreferitiDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public boolean addPreferito(int utenteId, int prodottoId) throws SQLException {
        String sql = "INSERT INTO preferiti (id_utente, id_prodotto, data_salvataggio) " +
                     "VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            ps.setInt(2, prodottoId);
            return ps.executeUpdate() > 0;
        }
    }

    // READ BASE — restituisce oggetti Preferito (id_utente, id_prodotto, data)
    public List<Preferito> findByUtente(int utenteId) throws SQLException {
        List<Preferito> lista = new ArrayList<>();
        String sql = "SELECT id_utente, id_prodotto, data_salvataggio " +
                     "FROM preferiti WHERE id_utente = ? " +
                     "ORDER BY data_salvataggio DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Preferito p = new Preferito();
                    p.setUtenteId(rs.getInt("id_utente"));
                    p.setProdottoId(rs.getInt("id_prodotto"));
                    p.setData(rs.getTimestamp("data_salvataggio").toLocalDateTime());
                    lista.add(p);
                }
            }
        }
        return lista;
    }

    // READ AVANZATO — restituisce direttamente i PRODOTTI preferiti
    public List<Prodotto> findProdottiByUtente(int utenteId) throws SQLException {
        List<Prodotto> lista = new ArrayList<>();

        String sql = """
            SELECT p.id,
                   p.nome,
                   p.brand,
                   p.prezzo,
                   p.quantita,
                   p.image_url,
                   p.informazioni,
                   p.visibile
            FROM preferiti f
            JOIN prodotto p ON f.id_prodotto = p.id
            WHERE f.id_utente = ?
            ORDER BY f.data_salvataggio DESC
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setBrand(rs.getString("brand"));
                    p.setPrezzo(rs.getFloat("prezzo"));
                    p.setQuantita(rs.getInt("quantita"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setInformazioni(rs.getString("informazioni"));
                    p.setVisibile(rs.getBoolean("visibile"));

                    lista.add(p);
                }
            }
        }

        return lista;
    }

    // DELETE
    public boolean removePreferito(int utenteId, int prodottoId) throws SQLException {
        String sql = "DELETE FROM preferiti WHERE id_utente = ? AND id_prodotto = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            ps.setInt(2, prodottoId);
            return ps.executeUpdate() > 0;
        }
    }
}
