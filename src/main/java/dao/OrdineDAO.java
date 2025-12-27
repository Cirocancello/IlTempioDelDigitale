package dao;

import model.Ordine;
import model.Prodotto;
import db.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class OrdineDAO {

    /**
     * Inserisce un nuovo ordine e i prodotti associati.
     */
    public boolean createOrdine(Ordine ordine) throws SQLException {
        String sqlOrdine = "INSERT INTO ordine (id, id_utente, _data, stato, metodo_pagamento, indirizzo_spedizione) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlProdotti = "INSERT INTO prodotto_ordine (id_ordine, id_prodotto, quantita, prezzo_effettivo, iva) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            String ordineId = UUID.randomUUID().toString();
            ordine.setId(ordineId);

            try (PreparedStatement psOrdine = con.prepareStatement(sqlOrdine)) {
                psOrdine.setString(1, ordineId);
                psOrdine.setInt(2, ordine.getUtente().getId());
                psOrdine.setTimestamp(3, new Timestamp(ordine.getData().getTime()));
                psOrdine.setString(4, ordine.getStato());
                psOrdine.setString(5, ordine.getMetodoPagamento());     // ✅ nuovo campo
                psOrdine.setString(6, ordine.getIndirizzoSpedizione()); // ✅ nuovo campo

                int rows = psOrdine.executeUpdate();
                if (rows == 0) {
                    con.rollback();
                    return false;
                }

                try (PreparedStatement psProdotti = con.prepareStatement(sqlProdotti)) {
                    for (Prodotto p : ordine.getProdotti()) {
                        psProdotti.setString(1, ordineId);
                        psProdotti.setInt(2, p.getId());
                        psProdotti.setInt(3, p.getQuantita());
                        psProdotti.setDouble(4, p.getPrezzo());
                        psProdotti.setDouble(5, 0.22); // IVA simulata
                        psProdotti.addBatch();
                    }
                    psProdotti.executeBatch();
                }
            }

            con.commit();
            return true;

        } catch (SQLException e) {
            throw e;
        }
    }

    /**
     * Recupera lo storico ordini di un utente.
     */
    public List<Ordine> findByUtente(int idUtente) throws SQLException {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY _data DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine ordine = new Ordine();
                    ordine.setId(rs.getString("id"));
                    ordine.setData(rs.getTimestamp("_data"));
                    ordine.setStato(rs.getString("stato"));
                    ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));       // ✅ nuovo
                    ordine.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione")); // ✅ nuovo

                    // carica i prodotti associati
                    ordine.setProdotti(getProdottiByOrdine(ordine.getId(), con));

                    ordini.add(ordine);
                }
            }
        }
        return ordini;
    }

    /**
     * Recupera tutti gli ordini (per admin).
     */
    public List<Ordine> findAll() throws SQLException {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine ORDER BY _data DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setId(rs.getString("id"));
                ordine.setData(rs.getTimestamp("_data"));
                ordine.setStato(rs.getString("stato"));
                ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));       // ✅ nuovo
                ordine.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione")); // ✅ nuovo

                // carica i prodotti associati
                ordine.setProdotti(getProdottiByOrdine(ordine.getId(), con));

                ordini.add(ordine);
            }
        }
        return ordini;
    }

    /**
     * Aggiorna lo stato di un ordine.
     */
    public boolean updateStato(String idOrdine, String nuovoStato) throws SQLException {
        String sql = "UPDATE ordine SET stato = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuovoStato);
            ps.setString(2, idOrdine);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Recupera i prodotti associati a un ordine.
     */
    private List<Prodotto> getProdottiByOrdine(String idOrdine, Connection con) throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        String sql = "SELECT p.id, p.nome, p.brand, p.image_url, po.quantita, po.prezzo_effettivo " +
                     "FROM prodotto_ordine po " +
                     "JOIN prodotto p ON po.id_prodotto = p.id " +
                     "WHERE po.id_ordine = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setBrand(rs.getString("brand"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setQuantita(rs.getInt("quantita")); // quantità acquistata
                    p.setPrezzo(rs.getDouble("prezzo_effettivo")); // prezzo effettivo
                    prodotti.add(p);
                }
            }
        }
        return prodotti;
    }
}
