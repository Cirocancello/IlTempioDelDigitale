<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Prodotti</title>

    <!-- ✅ Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ✅ Stile admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <h1 class="mb-4">Gestione Prodotti</h1>

    <!-- ✅ FORM CREAZIONE PRODOTTO -->
    <div class="admin-form mb-5">
        <h3 class="mb-3">Crea Nuovo Prodotto</h3>

        <form action="<%= request.getContextPath() %>/admin/prodotti" method="post">
            <input type="hidden" name="action" value="create">

            <div class="row">
                <div class="col-md-6">
                    <label>Nome</label>
                    <input type="text" name="nome" required>
                </div>

                <div class="col-md-6">
                    <label>Prezzo</label>
                    <input type="number" step="0.01" name="prezzo" required>
                </div>
            </div>

            <label>Descrizione</label>
            <textarea name="descrizione" rows="3" required></textarea>

            <label>Categoria</label>
            <select name="categoriaId" required>
                <%-- Le categorie devono essere passate dalla servlet come attributo --%>
                <% 
                    List<model.Categoria> categorie = (List<model.Categoria>) request.getAttribute("categorie");
                    if (categorie != null) {
                        for (model.Categoria c : categorie) {
                %>
                    <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                <% 
                        }
                    }
                %>
            </select>

            <button type="submit" class="btn btn-dark mt-2">Crea Prodotto</button>
        </form>
    </div>

    <!-- ✅ TABELLA PRODOTTI -->
    <h3 class="mb-3">Lista Prodotti</h3>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Prezzo</th>
            <th>Categoria</th>
            <th>Azioni</th>
        </tr>
        </thead>

        <tbody>
        <% if (prodotti != null) {
            for (Prodotto p : prodotti) { %>

                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td>€ <%= p.getPrezzo() %></td>
                    <td><%= p.getCategoria() %></td>

                    <td>

                        <!-- ✅ FORM UPDATE -->
                        <form action="<%= request.getContextPath() %>/admin/prodotti" method="post" class="d-inline">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= p.getId() %>">

                            <button class="btn btn-sm btn-dark">Modifica</button>
                        </form>

                        <!-- ✅ FORM DELETE -->
                        <form action="<%= request.getContextPath() %>/admin/prodotti" method="post" class="d-inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= p.getId() %>">

                            <button class="btn btn-sm btn-danger"
                                    onclick="return confirm('Eliminare questo prodotto?')">
                                Elimina
                            </button>
                        </form>

                    </td>
                </tr>

        <%  }
        } %>
        </tbody>
    </table>

    <!-- ✅ Logout -->
    <div class="logout mt-5">
        <a class="text-danger fw-bold" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<!-- ✅ Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
