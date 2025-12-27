package model;

/**
 * Utente.java
 * -----------------
 * Bean che rappresenta un utente del sistema.
 * Coerente con la tabella td.utente.
 */
public class Utente {
    private int id;
    private String nome;
    private String cognome;
    private String email;
    private String password;   // corrisponde a _password nel DB
    private boolean oauth;
    private String propicUrl;
    private String provincia;
    private String cap;
    private String via;
    private String civico;
    private String note;
    private int role;          // corrisponde a _role nel DB (0=user, 1=admin, ecc.)

    // Costruttori
    public Utente() {}

    // Costruttore completo
    public Utente(int id, String nome, String cognome, String email, String password,
                  boolean oauth, String propicUrl, String provincia, String cap,
                  String via, String civico, String note, int role) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.oauth = oauth;
        this.propicUrl = propicUrl;
        this.provincia = provincia;
        this.cap = cap;
        this.via = via;
        this.civico = civico;
        this.note = note;
        this.role = role;
    }

    // Costruttore ridotto (utile per registrazione)
    public Utente(String nome, String cognome, String email, String password, int role) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public boolean isOauth() { return oauth; }
    public void setOauth(boolean oauth) { this.oauth = oauth; }

    public String getPropicUrl() { return propicUrl; }
    public void setPropicUrl(String propicUrl) { this.propicUrl = propicUrl; }

    public String getProvincia() { return provincia; }
    public void setProvincia(String provincia) { this.provincia = provincia; }

    public String getCap() { return cap; }
    public void setCap(String cap) { this.cap = cap; }

    public String getVia() { return via; }
    public void setVia(String via) { this.via = via; }

    public String getCivico() { return civico; }
    public void setCivico(String civico) { this.civico = civico; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    // toString per debug
    @Override
    public String toString() {
        return "Utente{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", email='" + email + '\'' +
                ", provincia='" + provincia + '\'' +
                ", cap='" + cap + '\'' +
                ", via='" + via + '\'' +
                ", civico='" + civico + '\'' +
                ", note='" + note + '\'' +
                ", role=" + role +
                '}';
    }
}
