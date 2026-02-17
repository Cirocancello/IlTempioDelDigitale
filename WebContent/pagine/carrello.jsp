<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Prodotto" %>

<%
    // ============================================================
    // ⭐ PROTEZIONE PAGINA
    // La pagina è accessibile solo se:
    //   - esiste una sessione
    //   - esiste un attributo "auth" (utente loggato)
    // Se non autenticato → redirect al login utente.
    // ============================================================
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }

    // ============================================================
    // ⭐ RECUPERO CARRELLO DALLA SESSIONE
    // Il carrello è una lista di oggetti Prodotto salvata in sessione.
    // Se non esiste ancora → creo una lista vuota.
    // ============================================================
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

    <!-- Bootstrap + Icone -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<!-- ⭐ data-base serve agli script AJAX per costruire URL dinamici -->
<body data-base="<%= request.getContextPath() %>">

<!-- ⭐ Navbar comune -->
<jsp:include page="/component/navbar.jsp"/>

<section class="py-5">
<div class="container">

    <h2 class="mb-4"><i class="bi bi-cart"></i> Il tuo carrello</h2>

    <% if (carrello.isEmpty()) { %>

        <!-- ============================================================
             ⭐ CARRELLO VUOTO
             Mostra un messaggio informativo e un pulsante per tornare al catalogo.
             ============================================================ -->
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="bi bi-info-circle me-2"></i>
            <div>Il carrello è vuoto.</div>
        </div>

        <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-primary">
            <i class="bi bi-arrow-left"></i> Torna al catalogo
        </a>

    <% } else { %>

        <!-- ============================================================
             ⭐ TABELLA CARRELLO
             Mostra tutti i prodotti presenti nel carrello.
             Include:
               - immagine
               - nome, brand, descrizione
               - prezzo
               - quantità modificabile via AJAX
               - pulsante rimozione
             ============================================================ -->
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
                // ⭐ Calcolo totale ordine
                double totale = 0;
                for (Prodotto p : carrello) {
                    totale += p.getPrezzo() * p.getQuantita();
            %>

                <tr id="row-<%= p.getId() %>">

                    <!-- Immagine prodotto -->
                    <td>
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                             alt="<%= p.getNome() %>"
                             class="img-thumbnail" style="max-width:100px;">
                    </td>

                    <!-- Dati prodotto -->
                    <td><%= p.getNome() %></td>
                    <td><%= p.getBrand() %></td>
                    <td><%= p.getInformazioni() %></td>
                    <td><%= String.format("%.2f", p.getPrezzo()) %></td>

                    <!-- ⭐ QUANTITÀ MODIFICABILE (AJAX) -->
                    <td>
                        <div class="d-flex align-items-center">

                            <!-- Bottone decremento -->
                            <button class="btn btn-outline-secondary btn-sm btn-dec me-2"
                                    data-id="<%= p.getId() %>">
                                <i class="bi bi-dash"></i>
                            </button>

                            <!-- Quantità attuale -->
                            <span id="qty-<%= p.getId() %>" class="mx-2 fw-bold">
                                <%= p.getQuantita() %>
                            </span>

                            <!-- Bottone incremento -->
                            <button class="btn btn-outline-secondary btn-sm btn-inc ms-2"
                                    data-id="<%= p.getId() %>">
                                <i class="bi bi-plus"></i>
                            </button>

                        </div>
                    </td>

                    <!-- Categoria -->
                    <td><%= p.getCategoria() != null ? p.getCategoria().getNome() : "-" %></td>

                    <!-- ⭐ RIMOZIONE PRODOTTO (AJAX) -->
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

        <!-- ⭐ TOTALE ORDINE (aggiornato via AJAX) -->
        <div class="alert alert-total">
            Totale ordine: <strong id="totale-ordine"><%= String.format("%.2f", totale) %></strong> €
        </div>

        <!-- ⭐ Pulsanti finali -->
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

<!-- ⭐ Footer comune -->
<jsp:include page="/component/footer.jsp"/>

<!-- Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ⭐ Script AJAX carrello -->
<script src="<%= request.getContextPath() %>/assets/carrello.js"></script>
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
