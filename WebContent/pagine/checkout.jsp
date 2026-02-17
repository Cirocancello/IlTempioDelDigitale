<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Prodotto" %>

<%
    /**
     * ⭐ PROTEZIONE JSP
     * ------------------
     * Se la sessione non esiste o l’utente non è autenticato,
     * reindirizzo alla pagina di login.
     * Questo evita accessi diretti alla JSP senza passare dalla servlet.
     */
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    /**
     * ⭐ RECUPERO CARRELLO DALLA SESSIONE
     * ------------------------------------
     * Il carrello è una lista di prodotti salvata in sessione.
     * Se non esiste, lo inizializzo come lista vuota.
     */
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    if (carrello == null) carrello = new ArrayList<>();

    /**
     * ⭐ CALCOLO TOTALE ORDINE
     * -------------------------
     * Sommo prezzo * quantità per ogni prodotto.
     */
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

    <!-- ⭐ Bootstrap + Icone -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

<!-- ⭐ Navbar riutilizzabile -->
<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">

    <!-- Titolo pagina -->
    <h2 class="mb-4"><i class="bi bi-credit-card"></i> Checkout</h2>

    <% if (carrello.isEmpty()) { %>

        <!-- ⭐ Caso carrello vuoto -->
        <div class="alert alert-info">Il carrello è vuoto.</div>

    <% } else { %>

        <!-- ⭐ TABELLA RIEPILOGO PRODOTTI -->
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
            <% 
                for (Prodotto p : carrello) {
                    double subtotale = p.getPrezzo() * p.getQuantita();
            %>
                <tr>
                    <!-- Immagine prodotto -->
                    <td>
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                             alt="<%= p.getNome() %>"
                             class="img-thumbnail"
                             style="max-width:80px;">
                    </td>

                    <!-- Nome -->
                    <td><%= p.getNome() %></td>

                    <!-- Prezzo -->
                    <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>

                    <!-- Quantità -->
                    <td><%= p.getQuantita() %></td>

                    <!-- Subtotale -->
                    <td>€ <%= String.format("%.2f", subtotale) %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <!-- ⭐ Totale ordine -->
        <div class="alert alert-total">
            Totale ordine: <strong><%= String.format("%.2f", totale) %> €</strong>
        </div>

        <!-- ⭐ FORM DATI SPEDIZIONE E PAGAMENTO -->
        <h4 class="mt-5"><i class="bi bi-truck"></i> Dati di spedizione e pagamento</h4>

        <form id="formCheckout"
              method="post"
              action="<%= request.getContextPath() %>/checkout"
              class="needs-validation"
              novalidate>

            <!-- Indirizzo spedizione -->
            <div class="mb-3">
                <label for="indirizzoSpedizione" class="form-label">Indirizzo di spedizione</label>
                <input type="text"
                       class="form-control"
                       id="indirizzoSpedizione"
                       name="indirizzoSpedizione"
                       placeholder="Via Roma 10, Napoli"
                       required minlength="5">
                <div class="invalid-feedback">Inserisci un indirizzo valido (minimo 5 caratteri).</div>
            </div>

            <!-- Metodo pagamento -->
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

            <!-- Pulsante conferma -->
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-lock-fill"></i> Conferma ordine
            </button>

            <!-- Torna al catalogo -->
            <div class="mt-4">
                <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Torna al catalogo
                </a>
            </div>
        </form>

    <% } %>
</div>

<!-- ⭐ Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ⭐ Validazione personalizzata -->
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

<!-- ⭐ Footer riutilizzabile -->
<jsp:include page="../component/footer.jsp"/>

</body>
</html>
