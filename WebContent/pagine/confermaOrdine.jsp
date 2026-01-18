<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Ordine, model.Prodotto, java.text.SimpleDateFormat" %>

<%
    // Protezione JSP
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    Ordine ordine = (Ordine) request.getAttribute("ordine");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="alert alert-success d-flex align-items-center shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2 fs-4"></i>
        <div>
            <strong>Ordine confermato!</strong> Grazie per il tuo acquisto.
        </div>
    </div>

    <% if (ordine != null) { 
           ordine.calcolaTotale(); // ricalcolo totale per sicurezza
    %>
        <h3 class="mb-4"><i class="bi bi-receipt"></i> Dettagli ordine</h3>
        <ul class="list-group mb-4 shadow-sm">
            <li class="list-group-item"><strong>Data:</strong> <%= sdf.format(ordine.getData()) %></li>
            <li class="list-group-item"><strong>Totale:</strong> € <%= String.format("%.2f", ordine.getTotale()) %></li>
            <li class="list-group-item"><strong>Stato:</strong> <span class="badge bg-info text-dark"><%= ordine.getStato() %></span></li>
            <li class="list-group-item"><strong>Indirizzo di spedizione:</strong> 
                <%= (ordine.getIndirizzoSpedizione() != null ? ordine.getIndirizzoSpedizione() : "N/D") %>
            </li>
            <li class="list-group-item"><strong>Metodo di pagamento:</strong> 
                <%= (ordine.getMetodoPagamento() != null ? ordine.getMetodoPagamento() : "N/D") %>
            </li>
        </ul>

        <h4 class="mb-3"><i class="bi bi-box-seam"></i> Prodotti acquistati</h4>
        <% if (ordine.getProdotti() != null && !ordine.getProdotti().isEmpty()) { %>
            <table class="table table-striped align-middle shadow-sm">
                <thead class="table-dark">
                    <tr>
                        <th>Immagine</th>
                        <th>Prodotto</th>
                        <th>Prezzo (€)</th>
                        <th>Quantità</th>
                        <th>Subtotale (€)</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Prodotto p : ordine.getProdotti()) {
                        double subtotale = p.getPrezzo() * p.getQuantita();
                %>
                    <tr>
                        <td><img src="<%= p.getImageUrl() %>" alt="<%= p.getNome() %>" class="img-thumbnail" style="max-width:80px;"></td>
                        <td><%= p.getNome() %></td>
                        <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                        <td><%= p.getQuantita() %></td>
                        <td>€ <%= String.format("%.2f", subtotale) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="alert alert-warning">Nessun prodotto associato a questo ordine.</div>
        <% } %>
    <% } else { %>
        <div class="alert alert-danger">Nessun ordine trovato.</div>
    <% } %>

    <div class="d-flex justify-content-between mt-4">
        <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Torna al catalogo
        </a>
        <a href="<%= request.getContextPath() %>/ordini" class="btn btn-primary">
            <i class="bi bi-list-check"></i> Vai ai tuoi ordini
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
