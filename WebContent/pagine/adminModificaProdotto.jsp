<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Categoria" %>
<%@ page import="java.util.List" %>

<%
    Prodotto p = (Prodotto) request.getAttribute("prodotto");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prodotto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
     <!-- Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body class="p-4">

<div class="container">

    <h1 class="mb-4">Modifica Prodotto</h1>

    <% if (p == null) { %>
        <div class="alert alert-danger">
            Errore: prodotto non trovato.
        </div>
        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">
            Torna alla lista
        </a>
    </div>
</body>
</html>
<% return; } %>

    <form action="<%= request.getContextPath() %>/admin/prodotti" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <div class="mb-3">
            <label class="form-label">Nome</label>
            <input type="text" name="nome" class="form-control" value="<%= p.getNome() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Brand</label>
            <input type="text" name="brand" class="form-control" value="<%= p.getBrand() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Informazioni</label>
            <textarea name="informazioni" class="form-control" rows="3" required><%= p.getInformazioni() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Prezzo</label>
            <input type="number" step="0.01" name="prezzo" class="form-control" value="<%= p.getPrezzo() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Quantità</label>
            <input type="number" name="quantita" class="form-control" value="<%= p.getQuantita() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">URL Immagine</label>
            <input type="text" name="imageUrl" class="form-control" value="<%= p.getImageUrl() %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Visibile</label>
            <select name="visibile" class="form-select">
                <option value="true" <%= p.isVisibile() ? "selected" : "" %>>Sì</option>
                <option value="false" <%= !p.isVisibile() ? "selected" : "" %>>No</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Categoria</label>
            <select name="categoriaId" class="form-select" required>
                <% for (Categoria c : categorie) { %>
                    <option value="<%= c.getId() %>"
                        <%= (p.getCategoria().getId() == c.getId()) ? "selected" : "" %>>
                        <%= c.getNome() %>
                    </option>
                <% } %>
            </select>
        </div>

        <button class="btn btn-dark mt-3">Salva Modifiche</button>
        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div>

</body>
</html>
