package model;

/**
 * Prodotto.java
 * -------------
 * Bean che rappresenta un prodotto del catalogo.
 * Include la categoria come oggetto per facilitare la visualizzazione e la gestione.
 */
public class Prodotto {
    private int id;
    private String nome;
    private String brand;
    private String informazioni;   // 🔹 rinominato da descrizione
    private double prezzo;
    private int quantita;
    private String imageUrl;
    private boolean visibile;
    private Categoria categoria;

    public Prodotto() {}

    public Prodotto(int id, String nome, String brand, String informazioni,
                    double prezzo, int quantita, String imageUrl,
                    boolean visibile, Categoria categoria) {
        this.id = id;
        this.nome = nome;
        this.brand = brand;
        this.informazioni = informazioni;
        this.prezzo = prezzo;
        this.quantita = quantita;
        this.imageUrl = imageUrl;
        this.visibile = visibile;
        this.categoria = categoria;
    }

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getInformazioni() { return informazioni; }
    public void setInformazioni(String informazioni) { this.informazioni = informazioni; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isVisibile() { return visibile; }
    public void setVisibile(boolean visibile) { this.visibile = visibile; }

    public Categoria getCategoria() { return categoria; }
    public void setCategoria(Categoria categoria) { this.categoria = categoria; }
}
