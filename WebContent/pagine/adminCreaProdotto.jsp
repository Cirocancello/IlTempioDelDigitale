<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Categoria" %>
<%@ page import="java.util.List" %>

<%
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Crea Nuovo Prodotto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4">

<div class="container">

    <h1 class="mb-4">Crea Nuovo Prodotto</h1>

    <% if (categorie == null || categorie.isEmpty()) { %>
        <div class="alert alert-warning">
            Nessuna categoria disponibile. Creane una prima di aggiungere prodotti.
        </div>
        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">
            Torna alla Gestione Prodotti
        </a>
    </div>
</body>
</html>
<% return; } %>

    <form action="<%= request.getContextPath() %>/admin/prodotti" method="post">

        <input type="hidden" name="action" value="create">

        <div class="mb-3">
            <label class="form-label">Nome</label>
            <input type="text" name="nome" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Brand</label>
            <input type="text" name="brand" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Informazioni</label>
            <textarea name="informazioni" class="form-control" rows="3" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Prezzo</label>
            <input type="number" step="0.01" name="prezzo" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Quantità</label>
            <input type="number" name="quantita" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">URL Immagine</label>
            <input type="text" name="imageUrl" class="form-control">
        </div>

        <div class="mb-3">
            <label class="form-label">Visibile</label>
            <select name="visibile" class="form-select">
                <option value="true">Sì</option>
                <option value="false">No</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Categoria</label>
            <select name="categoriaId" class="form-select" required>
                <% for (Categoria c : categorie) { %>
                    <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                <% } %>
            </select>
        </div>

        <button class="btn btn-dark mt-3">Crea Prodotto</button>
        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div>

</body>
</html>
