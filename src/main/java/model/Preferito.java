package model;

import java.time.LocalDateTime;

public class Preferito {
    private int id;
    private int utenteId;
    private int prodottoId;
    private LocalDateTime data;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUtenteId() { return utenteId; }
    public void setUtenteId(int utenteId) { this.utenteId = utenteId; }

    public int getProdottoId() { return prodottoId; }
    public void setProdottoId(int prodottoId) { this.prodottoId = prodottoId; }

    public LocalDateTime getData() { return data; }
    public void setData(LocalDateTime data) { this.data = data; }
}
