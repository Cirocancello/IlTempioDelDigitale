package model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int prodottoId;      // FK verso Prodotto
    private int score;           // valutazione (tinyint)
    private String titolo;       // titolo del feedback
    private String descrizione;  // testo del feedback
    private LocalDateTime data;  // timestamp inserimento

    // Costruttori
    public Feedback() {}

    public Feedback(int id, int prodottoId, int score, String titolo, String descrizione, LocalDateTime data) {
        this.id = id;
        this.prodottoId = prodottoId;
        this.score = score;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.data = data;
    }

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProdottoId() { return prodottoId; }
    public void setProdottoId(int prodottoId) { this.prodottoId = prodottoId; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public LocalDateTime getData() { return data; }
    public void setData(LocalDateTime data) { this.data = data; }

    @Override
    public String toString() {
        return "Feedback{" +
                "id=" + id +
                ", prodottoId=" + prodottoId +
                ", score=" + score +
                ", titolo='" + titolo + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", data=" + data +
                '}';
    }
}
