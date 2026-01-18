<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Prodotto" %>

<%
    // Protezione JSP 
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    if (carrello == null) {
        carrello = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<!-- ⭐ NECESSARIO PER L'AJAX -->
<body data-base="<%= request.getContextPath() %>">

<jsp:include page="/component/navbar.jsp"/>

<section class="py-5">
<div class="container">
    <h2 class="mb-4"><i class="bi bi-cart"></i> Il tuo carrello</h2>

    <% if (carrello.isEmpty()) { %>

        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="bi bi-info-circle me-2"></i>
            <div>Il carrello è vuoto.</div>
        </div>

        <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-primary">
            <i class="bi bi-arrow-left"></i> Torna al catalogo
        </a>

    <% } else { %>

        <table class="table table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Immagine</th>
                    <th>Prodotto</th>
                    <th>Brand</th>
                    <th>Descrizione</th>
                    <th>Prezzo(€)</th>
                    <th>Quantità</th>
                    <th>Categoria</th>
                    <th>Azioni</th>
                </tr>
            </thead>

            <tbody>
            <%
                double totale = 0;
                for (Prodotto p : carrello) {
                    totale += p.getPrezzo() * p.getQuantita();
            %>

                <tr id="row-<%= p.getId() %>">

                    <td>
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                             alt="<%= p.getNome() %>"
                             class="img-thumbnail" style="max-width:100px;">
                    </td>

                    <td><%= p.getNome() %></td>
                    <td><%= p.getBrand() %></td>
                    <td><%= p.getInformazioni() %></td>
                    <td><%= String.format("%.2f", p.getPrezzo()) %></td>

                    <!-- QUANTITÀ -->
                    <td>
                        <div class="d-flex align-items-center">

                            <!-- Bottone - AJAX -->
                            <button class="btn btn-outline-secondary btn-sm btn-dec me-2"
                                    data-id="<%= p.getId() %>">
                                <i class="bi bi-dash"></i>
                            </button>

                            <span id="qty-<%= p.getId() %>" class="mx-2 fw-bold">
                                <%= p.getQuantita() %>
                            </span>

                            <!-- Bottone + AJAX -->
                            <button class="btn btn-outline-secondary btn-sm btn-inc ms-2"
                                    data-id="<%= p.getId() %>">
                                <i class="bi bi-plus"></i>
                            </button>

                        </div>
                    </td>

                    <td><%= p.getCategoria() != null ? p.getCategoria().getNome() : "-" %></td>

                    <!-- RIMUOVI AJAX -->
                    <td>
                        <button class="btn btn-outline-danger btn-sm btn-remove"
                                data-id="<%= p.getId() %>">
                            <i class="bi bi-trash"></i> Rimuovi
                        </button>
                    </td>

                </tr>

            <% } %>
            </tbody>
        </table>

        <!-- ⭐ TOTALE CON ID PER AGGIORNAMENTO AJAX -->
        <div class="alert alert-total">
            Totale ordine: <strong id="totale-ordine"><%= String.format("%.2f", totale) %></strong> €
        </div>

        <div class="d-flex justify-content-between">
            <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Continua lo shopping
            </a>

            <form action="<%= request.getContextPath() %>/pagine/checkout.jsp" method="get">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-credit-card"></i> Procedi all'ordine
                </button>
            </form>
        </div>

    <% } %>

</div>
</section>

<jsp:include page="/component/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ⭐ Script AJAX carrello (PERCORSO CORRETTO) -->
<script src="<%= request.getContextPath() %>/assets/carrello.js"></script>

</body>
</html>
