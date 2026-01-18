<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Feedback" %>
<%@ page import="java.util.*" %>

<%
    Prodotto p = (Prodotto) request.getAttribute("prodotto");
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");

    Object utente = session.getAttribute("utente");

    double media = 0;
    if (feedbacks != null && !feedbacks.isEmpty()) {
        int somma = 0;
        for (Feedback f : feedbacks) somma += f.getScore();
        media = (double) somma / feedbacks.size();
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title><%= p.getNome() %> - Dettagli Prodotto</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<div class="container my-5">

    <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary mb-4">
        <i class="bi bi-arrow-left"></i> Torna al Catalogo
    </a>

    <!-- Dettagli prodotto -->
    <div class="row mb-5">
        <div class="col-md-6">
            <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>" 
                 class="img-fluid rounded shadow" alt="<%= p.getNome() %>">
        </div>

        <div class="col-md-6">
            <h2 class="mb-3"><%= p.getNome() %></h2>
            <h4 class="text-success mb-3">€ <%= String.format("%.2f", p.getPrezzo()) %></h4>

            <p class="mb-4"><%= p.getInformazioni() %></p>

            <!-- 🛒 Aggiungi al carrello -->
            <form method="post" action="<%= request.getContextPath() %>/carrello" class="d-inline">
                <input type="hidden" name="action" value="aggiungi">
                <input type="hidden" name="id" value="<%= p.getId() %>">
                <input type="hidden" name="nome" value="<%= p.getNome() %>">
                <input type="hidden" name="brand" value="<%= p.getBrand() %>">
                <input type="hidden" name="informazioni" value="<%= p.getInformazioni() %>">
                <input type="hidden" name="prezzo" value="<%= p.getPrezzo() %>">
                <input type="hidden" name="categoriaId" value="<%= p.getCategoria().getId() %>">
                <input type="hidden" name="categoriaNome" value="<%= p.getCategoria().getNome() %>">
                <input type="hidden" name="imageUrl" value="<%= p.getImageUrl() %>">
                <input type="hidden" name="quantita" value="1">

                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-cart-plus"></i> Aggiungi al Carrello
                </button>
            </form>

            <!-- ❤️ Aggiungi ai preferiti -->
            <form method="post" action="<%= request.getContextPath() %>/preferiti" class="d-inline">
                <input type="hidden" name="id_prodotto" value="<%= p.getId() %>">
                <button type="submit" class="btn btn-outline-danger btn-lg ms-2">
                    <i class="bi bi-heart"></i>
                </button>
            </form>

        </div>
    </div>

    <!-- Sezione Feedback -->
    <hr class="my-5">

    <h3>
        <i class="bi bi-chat-left-text"></i> Feedback degli utenti
        <% if (media > 0) { %>
            <span class="ms-2 text-warning"><%= String.format("%.1f", media) %> ⭐</span>
        <% } %>
    </h3>

    <% if (feedbacks != null) { %>
        <p class="text-muted"><%= feedbacks.size() %> recensioni totali</p>
    <% } %>

    <% if (feedbacks == null || feedbacks.isEmpty()) { %>

        <div class="feedback-empty">
            Non ci sono feedback per questo prodotto.
        </div>

    <% } else { %>

        <div class="mt-4">

            <% for (Feedback f : feedbacks) { 
                String titolo = f.getTitolo();
                if (titolo == null || titolo.isBlank()) titolo = "Anonimo";
                String iniziale = titolo.substring(0,1).toUpperCase();
            %>

            <div class="feedback-item">

                <div class="feedback-avatar"><%= iniziale %></div>

                <div class="feedback-content">

                    <h5 class="feedback-title"><%= titolo %></h5>

                    <div class="feedback-stars mb-1">
                        <% for (int i = 1; i <= 5; i++) { %>
                            <% if (i <= f.getScore()) { %>
                                <i class="bi bi-star-fill"></i>
                            <% } else { %>
                                <i class="bi bi-star"></i>
                            <% } %>
                        <% } %>
                    </div>

                    <p class="mb-2"><%= f.getDescrizione() %></p>

                    <small class="text-muted">Data: <%= f.getData() %></small>

                </div>

            </div>

            <% } %>

        </div>

    <% } %>

    <!-- Form Feedback (solo utenti loggati) -->
    <hr class="my-5">

    <% if (utente == null) { %>

        <div class="alert alert-warning">
            Devi essere loggato per lasciare un feedback.
            <a href="<%= request.getContextPath() %>/login" class="btn btn-sm btn-primary ms-2">Accedi</a>
        </div>

    <% } else { %>

        <h4><i class="bi bi-pencil-square"></i> Lascia un feedback</h4>

        <form action="<%= request.getContextPath() %>/aggiungi-feedback" method="post" class="mt-3">

            <input type="hidden" name="prodottoId" value="<%= p.getId() %>">

            <!-- ⭐ Menu a tendina per il Titolo -->
            <div class="mb-3">
                <label class="form-label">Titolo</label>

                <select id="titoloSelect" class="form-select mb-2">
                    <option value="">-- Scegli un titolo rapido --</option>
                    <option value="Ottimo prodotto">Ottimo prodotto</option>
                    <option value="Buona esperienza">Buona esperienza</option>
                    <option value="Non soddisfatto">Non soddisfatto</option>
                    <option value="Qualità migliorabile">Qualità migliorabile</option>
                </select>

                <input type="text" name="titolo" id="titolo" class="form-control" required>
            </div>

            <!-- ⭐ Stelle cliccabili -->
            <div class="mb-3">
                <label class="form-label">Valutazione</label>
                <div id="starRating" class="d-flex gap-1" style="cursor: pointer;">
                    <i class="bi bi-star" data-value="1"></i>
                    <i class="bi bi-star" data-value="2"></i>
                    <i class="bi bi-star" data-value="3"></i>
                    <i class="bi bi-star" data-value="4"></i>
                    <i class="bi bi-star" data-value="5"></i>
                </div>
                <input type="hidden" name="score" id="scoreInput" required>
            </div>

            <!-- ⭐ Menu a tendina per la Descrizione -->
            <div class="mb-3">
                <label class="form-label">Descrizione</label>

                <select id="descrizioneSelect" class="form-select mb-2">
                    <option value="">-- Scegli un commento rapido --</option>
                    <option value="Prodotto eccellente, molto soddisfatto!">Prodotto eccellente</option>
                    <option value="Buono, ma ci sono margini di miglioramento.">Buono ma migliorabile</option>
                    <option value="Non sono soddisfatto dell'acquisto.">Non soddisfatto</option>
                </select>

                <textarea name="descrizione" id="descrizione" class="form-control" rows="3" required></textarea>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="bi bi-send"></i> Invia Feedback
            </button>

        </form>

    <% } %>

</div>

<!-- ⭐ JS: stelle + menu a tendina -->
<script>
/* Stelle cliccabili */
const stars = document.querySelectorAll('#starRating i');
const scoreInput = document.getElementById('scoreInput');

stars.forEach(star => {
    star.addEventListener('click', () => {
        const value = star.getAttribute('data-value');
        scoreInput.value = value;

        stars.forEach(s => s.classList.remove('bi-star-fill'));
        stars.forEach(s => s.classList.add('bi-star'));

        for (let i = 0; i < value; i++) {
            stars[i].classList.remove('bi-star');
            stars[i].classList.add('bi-star-fill');
        }
    });
});

/* Menu a tendina → riempie il campo Titolo */
document.getElementById("titoloSelect").addEventListener("change", function() {
    const valore = this.value;
    if (valore) {
        document.getElementById("titolo").value = valore;
    }
});

/* Menu a tendina → riempie la Descrizione */
document.getElementById("descrizioneSelect").addEventListener("change", function() {
    const valore = this.value;
    if (valore) {
        document.getElementById("descrizione").value = valore;
    }
});
</script>

</body>
</html>
