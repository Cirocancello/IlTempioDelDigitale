<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Prodotto, model.Categoria" %>

<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
    String categoriaSelezionata = request.getParameter("categoria");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Catalogo Prodotti</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<!-- ⭐ NECESSARIO PER L'AJAX -->
<body data-base="<%= request.getContextPath() %>">

<!-- ⭐ NAVBAR -->
<jsp:include page="/component/navbar.jsp"/>

<div class="container mt-5">

    <h2 class="mb-4"><i class="bi bi-shop"></i> Catalogo</h2>

    <a href="<%= request.getContextPath() %>/index" class="btn btn-secondary mb-4">
        <i class="bi bi-house"></i> Torna alla Home
    </a>

    <!-- FILTRO PER CATEGORIA -->
    <form method="get" action="<%= request.getContextPath() %>/catalogo" class="mb-4">

        <label class="form-label fw-bold">Filtra per categoria</label>

        <select name="categoria" class="form-select w-auto d-inline-block" onchange="this.form.submit()">
            <option value="">Tutte le categorie</option>

            <% if (categorie != null) {
                for (Categoria c : categorie) { %>

                    <option value="<%= c.getId() %>"
                        <%= (categoriaSelezionata != null && categoriaSelezionata.equals(String.valueOf(c.getId()))) ? "selected" : "" %>>
                        <%= c.getNome() %>
                    </option>

            <%  }
            } %>
        </select>

    </form>

    <!-- LISTA PRODOTTI -->
    <% if (prodotti == null || prodotti.isEmpty()) { %>

        <div class="alert alert-info">Nessun prodotto disponibile.</div>

    <% } else { %>

        <div class="row">

            <% for (Prodotto p : prodotti) { %>

                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">

                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                             class="card-img-top" alt="<%= p.getNome() %>">

                        <div class="card-body d-flex flex-column justify-content-between" style="min-height: 220px;">

                            <div>
                                <h5 class="card-title"><%= p.getNome() %></h5>
                                <p class="card-text text-success">€ <%= String.format("%.2f", p.getPrezzo()) %></p>
                            </div>

                            <div>
                                <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getId() %>"
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-eye"></i> Vedi dettagli
                                </a>

                                <!-- 🛒 BOTTONE AGGIUNGI AL CARRELLO (AJAX) -->
                                <button class="btn btn-primary ms-2 add-cart" data-id="<%= p.getId() %>">
                                    <i class="bi bi-cart-plus"></i> Aggiungi
                                </button>

                                <!-- ❤️ BOTTONE AGGIUNGI AI PREFERITI -->
                                <form method="post" action="<%= request.getContextPath() %>/preferiti" class="d-inline">
                                    <input type="hidden" name="id_prodotto" value="<%= p.getId() %>">
                                    <button type="submit" class="btn btn-outline-danger ms-2">
                                        <i class="bi bi-heart"></i>
                                    </button>
                                </form>

                            </div>

                        </div>
                    </div>
                </div>

            <% } %>

        </div>

    <% } %>

</div>

<!-- JS Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ⭐ Script AJAX carrello (PERCORSO CORRETTO) -->
<script src="<%= request.getContextPath() %>/assets/carrello.js"></script>

</body>
</html>
