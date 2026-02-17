<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Utente" %>
<%@ page import="model.Prodotto" %>

<%
    // ============================================================
    // ⭐ Controllo accesso Admin
    // ============================================================
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // ============================================================
    // ⭐ Recupero dati passati dalla servlet
    // ============================================================
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");

    Integer currentPageAttr = (Integer) request.getAttribute("page");
    Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

    int currentPage = (currentPageAttr != null) ? currentPageAttr : 1;
    int totalPagesNum = (totalPagesAttr != null) ? totalPagesAttr : 1;

    // Filtri mantenuti nella UI
    /*
    “I filtri vengono mantenuti nella UI perché recupero i parametri dalla request e li reinserisco negli input, 
    così l’amministratore vede sempre quali filtri ha applicato anche quando cambia pagina.”
    */
    String fromParam = request.getParameter("from") != null ? request.getParameter("from") : "";
    String toParam = request.getParameter("to") != null ? request.getParameter("to") : "";
    String userIdParam = request.getParameter("userId") != null ? request.getParameter("userId") : "";
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Ordini</title>

    <!-- Bootstrap + stile admin -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <!-- ⭐ Titolo pagina -->
    <h1 class="mb-4">Gestione Ordini</h1>

    <!-- 🔙 Torna alla Dashboard -->
    <a href="<%= request.getContextPath() %>/admin/dashboard"
       class="btn-admin-action mb-4">
        ← Torna alla Dashboard
    </a>

    <!-- ============================================================
         ⭐ FILTRI DI RICERCA ORDINI
         ============================================================ -->
    <h3 class="mb-3">Filtra Ordini</h3>

    <form method="get" action="<%= request.getContextPath() %>/admin/ordini" class="row g-3 mb-5">

        <!-- Filtro data inizio -->
        <div class="col-md-3">
            <label class="form-label">Data inizio</label>
            <input type="date" name="from" class="form-control" value="<%= fromParam %>">
        </div>

        <!-- Filtro data fine -->
        <div class="col-md-3">
            <label class="form-label">Data fine</label>
            <input type="date" name="to" class="form-control" value="<%= toParam %>">
        </div>

        <!-- Filtro per utente -->
        <div class="col-md-3">
            <label class="form-label">Utente</label>
            <select name="userId" class="form-select">
                <option value="">Tutti</option>

                <% if (utenti != null) {
                    for (Utente u : utenti) {
                        String selected = (!userIdParam.isEmpty()
                                           && userIdParam.equals(String.valueOf(u.getId())))
                                           ? "selected" : "";
                %>

                    <option value="<%= u.getId() %>" <%= selected %>>
                        <%= u.getNome() %> <%= u.getCognome() %> - <%= u.getEmail() %>
                    </option>

                <%  } } %>
            </select>
        </div>

        <!-- Pulsante filtra -->
        <div class="col-md-3 d-flex align-items-end">
            <button type="submit" class="btn-filtra">Filtra</button>
        </div>

    </form>

    <!-- ============================================================
         ⭐ LISTA ORDINI
         ============================================================ -->
    <h3 class="mb-3">Lista Ordini</h3>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Utente</th>
            <th>Data</th>
            <th>Totale</th>
            <th>Stato</th>
            <th>Dettagli</th>
            <th>Azioni</th>
        </tr>
        </thead>

        <tbody>
        <%
        if (ordini != null && !ordini.isEmpty()) {
            for (Ordine o : ordini) {
                List<Prodotto> prodotti = o.getProdotti();
        %>

            <tr>
                <td><%= o.getId() %></td>

                <!-- Email utente -->
                <td>
                    <%= (o.getUtente() != null)
                        ? o.getUtente().getEmail()
                        : "—" %>
                </td>

                <td><%= o.getData() %></td>
                <td>€ <%= o.getTotale() %></td>
                <td><%= o.getStato() %></td>

                <!-- Pulsante mostra dettagli -->
                <td>
                    <button class="btn btn-sm btn-info"
                            data-bs-toggle="collapse"
                            data-bs-target="#dettaglio<%= o.getId() %>">
                        Mostra
                    </button>
                </td>

                <!-- ⭐ Azioni: modifica stato + elimina -->
                <td>

                    <!-- UPDATE STATO -->
                    <form action="<%= request.getContextPath() %>/admin/ordini" method="post" class="d-inline">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= o.getId() %>">

                        <select name="stato" class="form-select form-select-sm d-inline w-auto">
                            <option value="In elaborazione" <%= o.getStato().equals("In elaborazione") ? "selected" : "" %>>In elaborazione</option>
                            <option value="Spedito" <%= o.getStato().equals("Spedito") ? "selected" : "" %>>Spedito</option>
                            <option value="Consegnato" <%= o.getStato().equals("Consegnato") ? "selected" : "" %>>Consegnato</option>
                            <option value="Annullato" <%= o.getStato().equals("Annullato") ? "selected" : "" %>>Annullato</option>
                        </select>

                        <button class="btn btn-sm btn-dark">Aggiorna</button>
                    </form>

                    <!-- DELETE -->
                    <form action="<%= request.getContextPath() %>/admin/ordini" method="post" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= o.getId() %>">

                        <button class="btn btn-sm btn-danger"
                                onclick="return confirm('Eliminare questo ordine?')">
                            Elimina
                        </button>
                    </form>
                </td>
            </tr>

            <!-- ============================================================
                 ⭐ DETTAGLIO ORDINE (collassabile)
                 ============================================================ -->
            <tr class="collapse" id="dettaglio<%= o.getId() %>">
                <td colspan="7">
                    <div class="p-3 bg-dark text-white rounded">

                        <h5>Prodotti acquistati</h5>

                        <table class="table table-dark table-striped mt-3">
                            <thead>
                                <tr>
                                    <th>Prodotto</th>
                                    <th>Quantità</th>
                                    <th>Prezzo unitario</th>
                                    <th>Subtotale</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Prodotto po : prodotti) { %>
                                <tr>
                                    <td><%= po.getNome() %></td>
                                    <td><%= po.getQuantita() %></td>
                                    <td>€ <%= po.getPrezzo() %></td>
                                    <td>€ <%= po.getQuantita() * po.getPrezzo() %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>

                    </div>
                </td>
            </tr>

        <%
            }
        } else {
        %>

            <!-- Nessun ordine -->
            <tr>
                <td colspan="7" class="text-center text-warning">Nessun ordine trovato.</td>
            </tr>

        <% } %>
        </tbody>
    </table>

    <!-- ============================================================
         ⭐ PAGINAZIONE
         ============================================================ -->
    <div class="pagination-admin">

        <% if (currentPage > 1) { %>
            <a class="page-admin"
               href="?page=<%= currentPage - 1 %>&from=<%= fromParam %>&to=<%= toParam %>&userId=<%= userIdParam %>">
                Precedente
            </a>
        <% } %>

        <% for (int i = 1; i <= totalPagesNum; i++) { %>
            <a class="page-admin <%= currentPage == i ? "active" : "" %>"
               href="?page=<%= i %>&from=<%= fromParam %>&to=<%= toParam %>&userId=<%= userIdParam %>">
                <%= i %>
            </a>
        <% } %>

        <% if (currentPage < totalPagesNum) { %>
            <a class="page-admin"
               href="?page=<%= currentPage + 1 %>&from=<%= fromParam %>&to=<%= toParam %>&userId=<%= userIdParam %>">
                Successiva
            </a>
        <% } %>
    </div>

    <!-- Logout -->
    <div class="logout mt-5">
        <a class="btn-logout" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
