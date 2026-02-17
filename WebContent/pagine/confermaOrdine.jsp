<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Ordine, model.Prodotto, java.text.SimpleDateFormat" %>

<%
    /**
     * ⭐ PROTEZIONE JSP
     * ----------------------------------------------------
     * Impedisce l’accesso diretto alla pagina senza login.
     * Se la sessione non esiste o manca il token "auth",
     * reindirizzo alla pagina di login.
     */
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    /**
     * ⭐ RECUPERO ORDINE DALLA SERVLET
     * ----------------------------------------------------
     * La servlet che ha processato l’ordine ha impostato
     * l’oggetto "ordine" come attributo della request.
     */
    Ordine ordine = (Ordine) request.getAttribute("ordine");

    /**
     * ⭐ FORMATTAZIONE DATA
     * ----------------------------------------------------
     * Per mostrare la data dell’ordine in formato leggibile.
     */
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>

    <!-- ⭐ Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

<div class="container">
    <div class="admin-container">

        <!-- ⭐ MESSAGGIO DI CONFERMA -->
        <div class="alert-custom-success mb-4">
            <strong>Ordine confermato!</strong> Grazie per il tuo acquisto.
        </div>

        <% if (ordine != null) { ordine.calcolaTotale(); %>

            <!-- ⭐ DETTAGLI ORDINE -->
            <h2 class="mb-3">Dettagli ordine</h2>

            <div class="admin-box mb-4">
                <p><strong>Data:</strong> <%= sdf.format(ordine.getData()) %></p>
                <p><strong>Totale:</strong> € <%= String.format("%.2f", ordine.getTotale()) %></p>
                <p><strong>Stato:</strong> 
                    <span class="badge-admin"><%= ordine.getStato() %></span>
                </p>
                <p><strong>Indirizzo di spedizione:</strong>
                    <%= ordine.getIndirizzoSpedizione() != null ? ordine.getIndirizzoSpedizione() : "N/D" %>
                </p>
                <p><strong>Metodo di pagamento:</strong>
                    <%= ordine.getMetodoPagamento() != null ? ordine.getMetodoPagamento() : "N/D" %>
                </p>
            </div>

            <!-- ⭐ PRODOTTI ACQUISTATI -->
            <h3 class="mb-3">Prodotti acquistati</h3>

            <% if (ordine.getProdotti() != null && !ordine.getProdotti().isEmpty()) { %>

                <!-- ⭐ TABELLA PRODOTTI -->
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
                                     class="img-thumbnail"
                                     style="max-width:80px;">
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

                <!-- ⭐ Caso: nessun prodotto -->
                <div class="alert-custom-warning">
                    Nessun prodotto associato a questo ordine.
                </div>

            <% } %>

        <% } else { %>

            <!-- ⭐ Caso: ordine non trovato -->
            <div class="alert-custom-danger">
                Nessun ordine trovato.
            </div>

        <% } %>

        <!-- ⭐ BOTTONI FINALI -->
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

<!-- ⭐ Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
