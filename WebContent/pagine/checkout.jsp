<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Prodotto" %>

<%
    // Protezione JSP 
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    if (carrello == null) carrello = new ArrayList<>();
    double totale = 0;
    for (Prodotto p : carrello) {
        totale += p.getPrezzo() * p.getQuantita();
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">
    <h2 class="mb-4"><i class="bi bi-credit-card"></i> Checkout</h2>

    <% if (carrello.isEmpty()) { %>
        <div class="alert alert-info">Il carrello è vuoto.</div>
    <% } else { %>

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
            <% for (Prodotto p : carrello) {
                double subtotale = p.getPrezzo() * p.getQuantita();
            %>
                <tr>
                    <td>
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
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

        <div class="alert alert-total">
            Totale ordine: <strong><%= String.format("%.2f", totale) %> €</strong>
        </div>

        <h4 class="mt-5"><i class="bi bi-truck"></i> Dati di spedizione e pagamento</h4>

        <form method="post" action="<%= request.getContextPath() %>/checkout" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="indirizzoSpedizione" class="form-label">Indirizzo di spedizione</label>
                <input type="text" class="form-control" id="indirizzoSpedizione" name="indirizzoSpedizione"
                       placeholder="Via Roma 10, Napoli" required minlength="5">
                <div class="invalid-feedback">Inserisci un indirizzo valido (minimo 5 caratteri).</div>
            </div>

            <div class="mb-3">
                <label for="metodoPagamento" class="form-label">Metodo di pagamento</label>
                <select class="form-select" id="metodoPagamento" name="metodoPagamento" required>
                    <option value="">-- Seleziona --</option>
                    <option value="Carta di credito">Carta di credito</option>
                    <option value="PayPal">PayPal</option>
                    <option value="Contrassegno">Contrassegno</option>
                </select>
                <div class="invalid-feedback">Seleziona un metodo di pagamento.</div>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="bi bi-lock-fill"></i> Conferma ordine
            </button>

            <div class="mt-4">
                <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Torna al catalogo
                </a>
            </div>
        </form>

    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

<jsp:include page="../component/footer.jsp"/>

</body>
</html>
