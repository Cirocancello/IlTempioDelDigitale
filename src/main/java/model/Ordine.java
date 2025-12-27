package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Ordine.java
 * -----------
 * Bean che rappresenta un ordine effettuato da un utente.
 * Contiene informazioni generali sull'ordine, la lista dei prodotti,
 * e i dati di spedizione/metodo di pagamento.
 */
public class Ordine {
    private String id;                   // Identificativo ordine (UUID)
    private Utente utente;               // Utente che ha effettuato l'ordine
    private Date data;                   // Data e ora dell'ordine
    private String stato;                // Stato ordine (es. "In lavorazione", "Spedito", "Consegnato")
    private List<Prodotto> prodotti = new ArrayList<>(); // ✅ inizializzata per evitare null

    private double totale;               // Totale ordine calcolato lato Java

    private String indirizzoSpedizione;  // Indirizzo di spedizione
    private String metodoPagamento;      // Metodo di pagamento

    public Ordine() {
        // costruttore vuoto
    }

    public Ordine(String id, Utente utente, Date data, String stato, List<Prodotto> prodotti,
                  String indirizzoSpedizione, String metodoPagamento) {
        this.id = id;
        this.utente = utente;
        this.data = data;
        this.stato = stato;
        this.prodotti = (prodotti != null) ? prodotti : new ArrayList<>();
        this.indirizzoSpedizione = indirizzoSpedizione;
        this.metodoPagamento = metodoPagamento;
        this.totale = calcolaTotale();
    }

    // Getter e Setter
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Utente getUtente() { return utente; }
    public void setUtente(Utente utente) { this.utente = utente; }

    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }

    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }

    public List<Prodotto> getProdotti() { return prodotti; }
    public void setProdotti(List<Prodotto> prodotti) {
        this.prodotti = (prodotti != null) ? prodotti : new ArrayList<>();
        this.totale = calcolaTotale();
    }

    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }

    public String getIndirizzoSpedizione() { return indirizzoSpedizione; }
    public void setIndirizzoSpedizione(String indirizzoSpedizione) { this.indirizzoSpedizione = indirizzoSpedizione; }

    public String getMetodoPagamento() { return metodoPagamento; }
    public void setMetodoPagamento(String metodoPagamento) { this.metodoPagamento = metodoPagamento; }

    /**
     * Calcola il totale dell'ordine sommando prezzo * quantità di ogni prodotto.
     */
    public double calcolaTotale() {
        double somma = 0;
        if (prodotti != null) {
            for (Prodotto p : prodotti) {
                somma += p.getPrezzo() * p.getQuantita();
            }
        }
        this.totale = somma;
        return somma;
    }
}
