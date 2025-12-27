package dao;

import model.Feedback;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    private final Connection conn;

    public FeedbackDAO(Connection conn) {
        if (conn == null) {
            throw new IllegalArgumentException("Connessione al database non valida (null)");
        }
        this.conn = conn;
    }

    // INSERT: aggiunge un nuovo feedback
    public void insertFeedback(Feedback f) throws SQLException {
        String sql = "INSERT INTO feedback (id_prodotto, score, titolo, descrizione, _data) VALUES (?, ?, ?, ?, NOW())";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, f.getProdottoId());
            ps.setInt(2, f.getScore());
            ps.setString(3, f.getTitolo());
            ps.setString(4, f.getDescrizione());
            ps.executeUpdate();
        }
    }

    // SELECT: recupera tutti i feedback di un prodotto
    public List<Feedback> findByProdotto(int prodottoId) throws SQLException {
        List<Feedback> lista = new ArrayList<>();

        String sql = "SELECT * FROM feedback WHERE id_prodotto = ? ORDER BY _data DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, prodottoId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback f = new Feedback();
                    f.setId(rs.getInt("id"));
                    f.setProdottoId(rs.getInt("id_prodotto"));
                    f.setScore(rs.getInt("score"));
                    f.setTitolo(rs.getString("titolo"));
                    f.setDescrizione(rs.getString("descrizione"));

                    Timestamp ts = rs.getTimestamp("_data");
                    if (ts != null) {
                        f.setData(ts.toLocalDateTime());
                    }

                    lista.add(f);
                }
            }
        }

        return lista;
    }

    // SELECT: recupera un singolo feedback
    public Feedback findById(int id) throws SQLException {
        String sql = "SELECT * FROM feedback WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Feedback f = new Feedback();
                    f.setId(rs.getInt("id"));
                    f.setProdottoId(rs.getInt("id_prodotto"));
                    f.setScore(rs.getInt("score"));
                    f.setTitolo(rs.getString("titolo"));
                    f.setDescrizione(rs.getString("descrizione"));

                    Timestamp ts = rs.getTimestamp("_data");
                    if (ts != null) {
                        f.setData(ts.toLocalDateTime());
                    }

                    return f;
                }
            }
        }

        return null;
    }

    // DELETE: elimina un feedback
    public boolean deleteFeedback(int id) throws SQLException {
        String sql = "DELETE FROM feedback WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
