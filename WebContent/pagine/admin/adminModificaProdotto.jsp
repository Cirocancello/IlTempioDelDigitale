<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Categoria" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>

<%
    // Controllo admin
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    Prodotto p = (Prodotto) request.getAttribute("prodotto");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prodotto</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body class="p-4">

<div class="container">

    <h1 class="mb-4">Modifica Prodotto</h1>

    <!-- 🔙 Torna alla Dashboard -->
    <a href="<%= request.getContextPath() %>/admin/dashboard"
       class="btn btn-outline-secondary mb-4">
        ← Torna alla Dashboard
    </a>

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

    <!-- ⭐ FORM 1 — MODIFICA DATI TESTUALI -->
    <form id="formAdminModificaProdotto"
          action="<%= request.getContextPath() %>/admin/prodotti"
          method="post"
          novalidate>

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <!-- ⭐ MANTIENI L’IMMAGINE ATTUALE -->
        <input type="hidden" name="imageUrl" value="<%= p.getImageUrl() %>">

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

    <hr class="my-5">

    <!-- ⭐ FORM 2 — MODIFICA IMMAGINE -->
    <h3 class="mb-3">Modifica Immagine</h3>

    <div class="mb-3">
        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/" + p.getImageUrl() %>"
                 alt="Immagine prodotto"
                 style="max-width: 200px; border: 1px solid #ccc; padding: 5px;">
        <% } else { %>
            <p class="text-muted">Nessuna immagine disponibile.</p>
        <% } %>
    </div>

    <form action="<%= request.getContextPath() %>/admin/uploadProdotto"
          method="post"
          enctype="multipart/form-data">

        <input type="hidden" name="action" value="updateImage">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <div class="mb-3">
            <label class="form-label">Carica Nuova Immagine</label>
            <input type="file" id="immagine" name="immagine" class="form-control" accept="image/*">
            <img id="preview" src="" style="max-width: 200px; margin-top: 10px; display: none;">
        </div>

        <button class="btn btn-primary mt-2">Aggiorna Immagine</button>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

</body>
</html>
