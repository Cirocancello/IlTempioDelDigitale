<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Ordine, model.Prodotto, java.text.SimpleDateFormat" %>

<%
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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

  <div class="container">
    <div class="admin-container">

    <!-- Messaggio di conferma -->
    <div class="alert-custom-success mb-4">
        <strong>Ordine confermato!</strong> Grazie per il tuo acquisto.
    </div>

    <% if (ordine != null) { ordine.calcolaTotale(); %>

        <h2 class="mb-3">Dettagli ordine</h2>

        <div class="admin-box mb-4">
            <p><strong>Data:</strong> <%= sdf.format(ordine.getData()) %></p>
            <p><strong>Totale:</strong> € <%= String.format("%.2f", ordine.getTotale()) %></p>
            <p><strong>Stato:</strong> <span class="badge-admin"><%= ordine.getStato() %></span></p>
            <p><strong>Indirizzo di spedizione:</strong> 
                <%= ordine.getIndirizzoSpedizione() != null ? ordine.getIndirizzoSpedizione() : "N/D" %>
            </p>
            <p><strong>Metodo di pagamento:</strong> 
                <%= ordine.getMetodoPagamento() != null ? ordine.getMetodoPagamento() : "N/D" %>
            </p>
        </div>

        <h3 class="mb-3">Prodotti acquistati</h3>

        <% if (ordine.getProdotti() != null && !ordine.getProdotti().isEmpty()) { %>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Immagine</th>
                        <th>Prodotto</th>
                        <th>Prezzo (€)</th>
                        <th>Quantità</th>
                        <th>Subtotale (€)</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Prodotto p : ordine.getProdotti()) { 
                       double subtotale = p.getPrezzo() * p.getQuantita();
                %>
                    <tr>
                        <td>
                            <img src="<%= p.getImageUrl() %>" 
                                 alt="<%= p.getNome() %>" 
                                 class="img-thumbnail" style="max-width:80px;">
                        </td>
                        <td><%= p.getNome() %></td>
                        <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                        <td><%= p.getQuantita() %></td>
                        <td>€ <%= String.format("%.2f", subtotale) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>

        <% } else { %>

            <div class="alert-custom-warning">Nessun prodotto associato a questo ordine.</div>

        <% } %>

    <% } else { %>

        <div class="alert-custom-danger">Nessun ordine trovato.</div>

    <% } %>

    <!-- Bottoni finali coerenti -->
    <div class="d-flex justify-content-between mt-4 mb-5 gap-3">

        <a href="<%= request.getContextPath() %>/catalogo" 
           class="btn btn-primary btn-order-action">
            ← Torna al catalogo
        </a>

        <a href="<%= request.getContextPath() %>/ordini" 
           class="btn btn-primary btn-order-action">
            Vai ai tuoi ordini →
        </a>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
