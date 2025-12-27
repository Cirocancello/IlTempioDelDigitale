<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Ordine, model.Prodotto, java.text.SimpleDateFormat" %>
<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>I miei ordini</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<!-- ✅ Navbar -->
<jsp:include page="/component/navbar.jsp"/>

<div class="container mt-5">
    <h2 class="mb-4"><i class="bi bi-list-check"></i> Storico ordini</h2>

    <% if (ordini == null || ordini.isEmpty()) { %>
        <div class="alert alert-info">Non hai ancora effettuato ordini.</div>
    <% } else { %>

        <div class="accordion" id="ordiniAccordion">

            <% for (Ordine o : ordini) { %>
                <div class="accordion-item mb-3 shadow-sm">

                    <h2 class="accordion-header" id="heading<%= o.getId() %>">
                        <button class="accordion-button collapsed" type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#collapse<%= o.getId() %>"
                                aria-expanded="false"
                                aria-controls="collapse<%= o.getId() %>">

                            <i class="bi bi-box-seam me-2"></i>
                            Ordine del <%= sdf.format(o.getData()) %> - Totale:
                            € <%= String.format("%.2f", o.getTotale()) %>

                            <span class="badge bg-info text-dark ms-3">
                                <%= o.getStato() %>
                            </span>
                        </button>
                    </h2>

                    <div id="collapse<%= o.getId() %>" class="accordion-collapse collapse"
                         aria-labelledby="heading<%= o.getId() %>"
                         data-bs-parent="#ordiniAccordion">

                        <div class="accordion-body">

                            <h5 class="mb-3"><i class="bi bi-receipt"></i> Dettagli ordine</h5>

                            <ul class="list-group mb-4">
                                <li class="list-group-item">
                                    <strong>Indirizzo di spedizione:</strong>
                                    <%= o.getIndirizzoSpedizione() != null ? o.getIndirizzoSpedizione() : "N/D" %>
                                </li>
                                <li class="list-group-item">
                                    <strong>Metodo di pagamento:</strong>
                                    <%= o.getMetodoPagamento() != null ? o.getMetodoPagamento() : "N/D" %>
                                </li>
                            </ul>

                            <h5><i class="bi bi-box-seam"></i> Prodotti acquistati</h5>

                            <% if (o.getProdotti() != null && !o.getProdotti().isEmpty()) { %>

                                <table class="table table-striped align-middle">
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

                                    <% for (Prodotto p : o.getProdotti()) {
                                        double subtotale = p.getPrezzo() * p.getQuantita();
                                    %>
                                        <tr>
                                            <td>
                                                <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
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
                                <div class="alert alert-warning">Nessun prodotto associato a questo ordine.</div>
                            <% } %>

                        </div>
                    </div>

                </div>
            <% } %>

        </div>

    <% } %>

    <a href="<%= request.getContextPath() %>/index" class="btn btn-secondary mt-4">
       	<i class="bi bi-house"></i> Torna alla Home
    </a> 
</div>

<!-- ✅ Footer -->
<jsp:include page="/component/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
