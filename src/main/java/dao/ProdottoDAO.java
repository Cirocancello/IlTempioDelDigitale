package dao;

import model.Categoria;
import model.Prodotto;
import db.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    private final Connection conn;

    // Costruttore che riceve la connessione (coerente con FeedbackDAO)
    public ProdottoDAO(Connection conn) {
        if (conn == null) {
            throw new IllegalArgumentException("Connessione al database non valida (null)");
        }
        this.conn = conn;
    }

    // Recupera tutti i prodotti
    public List<Prodotto> findAll() throws SQLException {
        String sql = "SELECT p.id, p.nome, p.brand, p.informazioni, p.prezzo, p.quantita, " +
                     "p.image_url, p.visibile, c.id AS cid, c.nome AS cnome " +
                     "FROM prodotto p " +
                     "JOIN categoria_prodotto cp ON p.id = cp.id_prodotto " +
                     "JOIN categoria c ON cp.id_categoria = c.id " +
                     "ORDER BY p.nome";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Prodotto> list = new ArrayList<>();
            while (rs.next()) {
                Categoria cat = new Categoria(rs.getInt("cid"), rs.getString("cnome"));
                Prodotto p = new Prodotto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("brand"),
                        rs.getString("informazioni"),
                        rs.getDouble("prezzo"),
                        rs.getInt("quantita"),
                        rs.getString("image_url"),
                        rs.getBoolean("visibile"),
                        cat
                );
                list.add(p);
            }
            return list;
        }
    }

    // Recupera un prodotto per ID
    public Prodotto findById(int id) throws SQLException {
        String sql = "SELECT p.id, p.nome, p.brand, p.informazioni, p.prezzo, p.quantita, " +
                     "p.image_url, p.visibile, c.id AS cid, c.nome AS cnome " +
                     "FROM prodotto p " +
                     "JOIN categoria_prodotto cp ON p.id = cp.id_prodotto " +
                     "JOIN categoria c ON cp.id_categoria = c.id " +
                     "WHERE p.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Categoria cat = new Categoria(rs.getInt("cid"), rs.getString("cnome"));
                    return new Prodotto(
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getString("brand"),
                            rs.getString("informazioni"),
                            rs.getDouble("prezzo"),
                            rs.getInt("quantita"),
                            rs.getString("image_url"),
                            rs.getBoolean("visibile"),
                            cat
                    );
                }
                return null;
            }
        }
    }

    // Inserisce un nuovo prodotto
    public boolean insert(Prodotto p) throws SQLException {
        String sql = "INSERT INTO prodotto (nome, brand, informazioni, prezzo, quantita, image_url, visibile) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getNome());
            ps.setString(2, p.getBrand());
            ps.setString(3, p.getInformazioni());
            ps.setDouble(4, p.getPrezzo());
            ps.setInt(5, p.getQuantita());
            ps.setString(6, p.getImageUrl());
            ps.setBoolean(7, p.isVisibile());

            int affected = ps.executeUpdate();

            if (affected == 1) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        int newId = keys.getInt(1);
                        p.setId(newId);

                        // 🔥 INSERIMENTO NELLA TABELLA DI ASSOCIAZIONE
                        String sql2 = "INSERT INTO categoria_prodotto (id_prodotto, id_categoria) VALUES (?, ?)";
                        try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
                            ps2.setInt(1, newId);
                            ps2.setInt(2, p.getCategoria().getId());
                            ps2.executeUpdate();
                        }
                    }
                }
            }

            return affected == 1;
        }
    }


    // Aggiorna un prodotto
    public boolean update(Prodotto p) throws SQLException {
        String sql = "UPDATE prodotto SET nome = ?, brand = ?, informazioni = ?, prezzo = ?, quantita = ?, " +
                     "image_url = ?, visibile = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getBrand());
            ps.setString(3, p.getInformazioni());
            ps.setDouble(4, p.getPrezzo());
            ps.setInt(5, p.getQuantita());
            ps.setString(6, p.getImageUrl());
            ps.setBoolean(7, p.isVisibile());
            ps.setInt(8, p.getId());

            return ps.executeUpdate() == 1;
        }
    }

    // Elimina un prodotto
    public boolean delete(int id) throws SQLException {

        // 1️⃣ Prima elimini l’associazione categoria-prodotto
        String sql1 = "DELETE FROM categoria_prodotto WHERE id_prodotto = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(sql1)) {
            ps1.setInt(1, id);
            ps1.executeUpdate();
        }

        // 2️⃣ Poi elimini il prodotto
        String sql2 = "DELETE FROM prodotto WHERE id = ?";
        try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
            ps2.setInt(1, id);
            return ps2.executeUpdate() == 1;
        }
    }


    // Recupera prodotti per categoria
    public List<Prodotto> findByCategoria(int categoriaId) throws SQLException {
        String sql = "SELECT p.id, p.nome, p.brand, p.informazioni, p.prezzo, p.quantita, " +
                     "p.image_url, p.visibile, c.id AS cid, c.nome AS cnome " +
                     "FROM prodotto p " +
                     "JOIN categoria_prodotto cp ON p.id = cp.id_prodotto " +
                     "JOIN categoria c ON cp.id_categoria = c.id " +
                     "WHERE c.id = ? ORDER BY p.nome";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Prodotto> list = new ArrayList<>();
                while (rs.next()) {
                    Categoria cat = new Categoria(rs.getInt("cid"), rs.getString("cnome"));
                    Prodotto p = new Prodotto(
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getString("brand"),
                            rs.getString("informazioni"),
                            rs.getDouble("prezzo"),
                            rs.getInt("quantita"),
                            rs.getString("image_url"),
                            rs.getBoolean("visibile"),
                            cat
                    );
                    list.add(p);
                }
                return list;
            }
        }
    }

    // Prodotti più venduti
    public List<Prodotto> getProdottiTopVenduti(int limit) throws SQLException {
        String sql = "SELECT p.id, p.nome, p.brand, p.informazioni, p.prezzo, p.quantita, " +
                     "p.image_url, p.visibile, c.id AS cid, c.nome AS cnome, SUM(po.quantita) AS vendite " +
                     "FROM prodotto p " +
                     "JOIN categoria_prodotto cp ON p.id = cp.id_prodotto " +
                     "JOIN categoria c ON cp.id_categoria = c.id " +
                     "JOIN prodotto_ordine po ON p.id = po.id_prodotto " +
                     "GROUP BY p.id, p.nome, p.brand, p.informazioni, p.prezzo, p.quantita, " +
                     "p.image_url, p.visibile, c.id, c.nome " +
                     "ORDER BY vendite DESC LIMIT ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                List<Prodotto> list = new ArrayList<>();
                while (rs.next()) {
                    Categoria cat = new Categoria(rs.getInt("cid"), rs.getString("cnome"));
                    Prodotto p = new Prodotto(
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getString("brand"),
                            rs.getString("informazioni"),
                            rs.getDouble("prezzo"),
                            rs.getInt("quantita"),
                            rs.getString("image_url"),
                            rs.getBoolean("visibile"),
                            cat
                    );
                    list.add(p);
                }
                return list;
            }
        }
    }
}
