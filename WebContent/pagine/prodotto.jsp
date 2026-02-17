<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Feedback" %>
<%@ page import="java.util.*" %>

<%
    /**
     * ⭐ RECUPERO DATI PASSATI DALLA SERVLET
     * ----------------------------------------------------
     * La ProdottoServlet ha impostato:
     * - "prodotto" → oggetto Prodotto
     * - "feedbacks" → lista dei feedback associati
     */
    Prodotto p = (Prodotto) request.getAttribute("prodotto");
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");

    /**
     * ⭐ CONTROLLO UTENTE LOGGATO
     * ----------------------------------------------------
     * Serve per mostrare o nascondere il form di feedback.
     */
    Object utente = session.getAttribute("utente");

    /**
     * ⭐ CALCOLO MEDIA FEEDBACK
     * ----------------------------------------------------
     * Se ci sono feedback, calcolo la media dei punteggi.
     */
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

    <!-- ⭐ Bootstrap + Icone -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<!-- ⭐ DATA-BASE: necessario per gli script AJAX -->
<body data-base="<%= request.getContextPath() %>">

<!-- ⭐ NAVBAR RIUTILIZZABILE -->
<jsp:include page="/component/navbar.jsp"/>

<div class="container my-5">

    <!-- ⭐ Pulsante ritorno al catalogo -->
    <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary mb-4">
        <i class="bi bi-arrow-left"></i> Torna al Catalogo
    </a>

    <!-- ⭐ SEZIONE DETTAGLI PRODOTTO -->
    <div class="row mb-5">

        <!-- Immagine prodotto -->
        <div class="col-md-6">
            <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                 class="img-fluid rounded shadow"
                 alt="<%= p.getNome() %>">
        </div>

        <!-- Informazioni prodotto -->
        <div class="col-md-6">
            <h2 class="mb-3"><%= p.getNome() %></h2>
            <h4 class="text-success mb-3">€ <%= String.format("%.2f", p.getPrezzo()) %></h4>

            <p class="mb-4"><%= p.getInformazioni() %></p>

            <!-- ⭐ Aggiungi al carrello (AJAX) -->
            <button class="btn btn-primary btn-lg add-cart" data-id="<%= p.getId() %>">
                <i class="bi bi-cart-plus"></i> Aggiungi al Carrello
            </button>

            <!-- ⭐ Aggiungi ai preferiti -->
            <form method="post" action="<%= request.getContextPath() %>/preferiti" class="d-inline">
                <input type="hidden" name="id_prodotto" value="<%= p.getId() %>">
                <button type="submit" class="btn btn-outline-danger btn-lg ms-2">
                    <i class="bi bi-heart"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- ⭐ SEZIONE FEEDBACK -->
    <hr class="my-5">

    <h3>
        <i class="bi bi-chat-left-text"></i> Feedback degli utenti
        <% if (media > 0) { %>
            <!-- ⭐ Media feedback -->
            <span class="ms-2 text-warning"><%= String.format("%.1f", media) %> ⭐</span>
        <% } %>
    </h3>

    <% if (feedbacks != null) { %>
        <p class="text-muted"><%= feedbacks.size() %> recensioni totali</p>
    <% } %>

    <% if (feedbacks == null || feedbacks.isEmpty()) { %>

        <!-- ⭐ Caso: nessun feedback -->
        <div class="feedback-empty">
            Non ci sono feedback per questo prodotto.
        </div>

    <% } else { %>

        <!-- ⭐ Lista feedback -->
        <div class="mt-4">

            <% for (Feedback f : feedbacks) { 
                String titolo = f.getTitolo();
                if (titolo == null || titolo.isBlank()) titolo = "Anonimo";
                String iniziale = titolo.substring(0,1).toUpperCase();
            %>

            <div class="feedback-item">

                <!-- Avatar con iniziale -->
                <div class="feedback-avatar"><%= iniziale %></div>

                <div class="feedback-content">

                    <!-- Titolo -->
                    <h5 class="feedback-title"><%= titolo %></h5>

                    <!-- ⭐ Stelle -->
                    <div class="feedback-stars mb-1">
                        <% for (int i = 1; i <= 5; i++) { %>
                            <% if (i <= f.getScore()) { %>
                                <i class="bi bi-star-fill"></i>
                            <% } else { %>
                                <i class="bi bi-star"></i>
                            <% } %>
                        <% } %>
                    </div>

                    <!-- Descrizione -->
                    <p class="mb-2"><%= f.getDescrizione() %></p>

                    <!-- Data -->
                    <small class="text-muted">Data: <%= f.getData() %></small>

                </div>

            </div>

            <% } %>

        </div>

    <% } %>

    <!-- ⭐ FORM FEEDBACK (solo utenti loggati) -->
    <hr class="my-5">

    <% if (utente == null) { %>

        <!-- Caso: utente non loggato -->
        <div class="alert alert-warning">
            Devi essere loggato per lasciare un feedback.
            <a href="<%= request.getContextPath() %>/login" class="btn btn-sm btn-primary ms-2">Accedi</a>
        </div>

    <% } else { %>

        <!-- ⭐ Form invio feedback -->
        <h4><i class="bi bi-pencil-square"></i> Lascia un feedback</h4>

        <form action="<%= request.getContextPath() %>/aggiungi-feedback" method="post" class="mt-3">

            <input type="hidden" name="prodottoId" value="<%= p.getId() %>">

            <!-- ⭐ Titolo feedback -->
            <div class="mb-3">
                <label class="form-label">Titolo</label>

                <!-- Scelta rapida -->
                <select id="titoloSelect" class="form-select mb-2">
                    <option value="">-- Scegli un titolo rapido --</option>
                    <option value="Ottimo prodotto">Ottimo prodotto</option>
                    <option value="Buona esperienza">Buona esperienza</option>
                    <option value="Non soddisfatto">Non soddisfatto</option>
                    <option value="Qualità migliorabile">Qualità migliorabile</option>
                </select>

                <!-- Campo testo -->
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

            <!-- ⭐ Descrizione feedback -->
            <div class="mb-3">
                <label class="form-label">Descrizione</label>

                <!-- Scelta rapida -->
                <select id="descrizioneSelect" class="form-select mb-2">
                    <option value="">-- Scegli un commento rapido --</option>
                    <option value="Prodotto eccellente, molto soddisfatto!">Prodotto eccellente</option>
                    <option value="Buono, ma ci sono margini di miglioramento.">Buono ma migliorabile</option>
                    <option value="Non sono soddisfatto dell'acquisto.">Non soddisfatto</option>
                </select>

                <!-- Campo testo -->
                <textarea name="descrizione" id="descrizione" class="form-control" rows="3" required></textarea>
            </div>

            <!-- ⭐ Pulsante invio -->
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-send"></i> Invia Feedback
            </button>

        </form>

    <% } %>

</div>

<script src="<%= request.getContextPath() %>/assets/feedback.js"></script>


<!-- ⭐ Script AJAX carrello -->
<script src="<%= request.getContextPath() %>/assets/carrello.js"></script>

</body>
</html>
