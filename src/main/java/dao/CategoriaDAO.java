package dao;

import model.Categoria;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CategoriaDAO.java
 * -----------------
 * CRUD categorie. Usa la Connection passata dal chiamante.
 * Tabella attesa: categoria(id, nome)
 */
public class CategoriaDAO {

    private final Connection conn;

    // Costruttore che riceve la connessione
    public CategoriaDAO(Connection conn) {
        if (conn == null) {
            throw new IllegalArgumentException("Connessione al database non valida (null)");
        }
        this.conn = conn;
    }

    // READ: tutte le categorie
    public List<Categoria> findAll() throws SQLException {
        String sql = "SELECT id, nome FROM categoria ORDER BY nome";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Categoria> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Categoria(
                        rs.getInt("id"),
                        rs.getString("nome")
                ));
            }
            return list;
        }
    }

    // READ: categoria per ID
    public Categoria findById(int id) throws SQLException {
        String sql = "SELECT id, nome FROM categoria WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Categoria(
                            rs.getInt("id"),
                            rs.getString("nome")
                    );
                }
                return null;
            }
        }
    }

    // CREATE: inserisce una nuova categoria
    public boolean insert(Categoria c) throws SQLException {
        String sql = "INSERT INTO categoria (nome) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getNome());
            int affected = ps.executeUpdate();
            if (affected == 1) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) c.setId(keys.getInt(1));
                }
            }
            return affected == 1;
        }
    }

    // UPDATE: aggiorna una categoria
    public boolean update(Categoria c) throws SQLException {
        String sql = "UPDATE categoria SET nome = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getNome());
            ps.setInt(2, c.getId());
            return ps.executeUpdate() == 1;
        }
    }

    // DELETE: elimina una categoria
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM categoria WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }
}
