<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Categoria" %>
<%@ page import="model.Utente" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Categorie</title>

    <!-- ✅ Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ✅ Stile admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <h1 class="mb-4">Gestione Categorie</h1>

    <!-- ✅ FORM CREAZIONE CATEGORIA -->
    <div class="admin-form mb-5">
        <h3 class="mb-3">Crea Nuova Categoria</h3>

        <form action="<%= request.getContextPath() %>/admin/categorie" method="post">
            <input type="hidden" name="action" value="create">

            <label>Nome Categoria</label>
            <input type="text" name="nome" required>

            <button type="submit" class="btn btn-dark mt-2">Crea Categoria</button>
        </form>
    </div>

    <!-- ✅ TABELLA CATEGORIE -->
    <h3 class="mb-3">Lista Categorie</h3>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Azioni</th>
        </tr>
        </thead>

        <tbody>
        <% if (categorie != null) {
            for (Categoria c : categorie) { %>

                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getNome() %></td>

                    <td>

                        <!-- ✅ FORM UPDATE -->
                        <form action="<%= request.getContextPath() %>/admin/categorie" method="post" class="d-inline">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= c.getId() %>">

                            <button class="btn btn-sm btn-dark">Modifica</button>
                        </form>

                        <!-- ✅ FORM DELETE -->
                        <form action="<%= request.getContextPath() %>/admin/categorie" method="post" class="d-inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= c.getId() %>">

                            <button class="btn btn-sm btn-danger"
                                    onclick="return confirm('Eliminare questa categoria?')">
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
