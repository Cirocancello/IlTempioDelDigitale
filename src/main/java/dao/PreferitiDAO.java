package dao;

import model.Preferito;
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
        String sql = "INSERT INTO preferiti (id_utente, id_prodotto, data_salvataggio) VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            ps.setInt(2, prodottoId);
            return ps.executeUpdate() > 0;
        }
    }

    // READ
    public List<Preferito> findByUtente(int utenteId) throws SQLException {
        List<Preferito> lista = new ArrayList<>();
        String sql = "SELECT * FROM preferiti WHERE id_utente = ? ORDER BY data_salvataggio DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, utenteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Preferito p = new Preferito();
                    // ⚠️ La tabella non ha colonna "id", quindi non usare rs.getInt("id")
                    p.setUtenteId(rs.getInt("id_utente"));
                    p.setProdottoId(rs.getInt("id_prodotto"));
                    p.setData(rs.getTimestamp("data_salvataggio").toLocalDateTime());
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
