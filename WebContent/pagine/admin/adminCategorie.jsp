<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Categoria" %>
<%@ page import="model.Utente" %>

<%
    // ============================================================
    // ⭐ CONTROLLO ACCESSO ADMIN
    // ============================================================
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // ============================================================
    // ⭐ Recupero lista categorie passata dalla servlet
    // ============================================================
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Categorie</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile personalizzato admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <!-- ⭐ Titolo pagina -->
    <h1 class="mb-4">Gestione Categorie</h1>

    <!-- ⭐ Pulsante ritorno alla Dashboard -->
    <a href="<%= request.getContextPath() %>/admin/dashboard"
       class="btn-back-dashboard mb-4">
        ← Torna alla Dashboard
    </a>

    <!-- ============================================================
         ⭐ FORM CREAZIONE NUOVA CATEGORIA
         ============================================================ -->
    <div class="admin-form mb-5">
        <h3 class="mb-3">Crea Nuova Categoria</h3>

        <form id="formAdminCategoria"
              action="<%= request.getContextPath() %>/admin/categorie"
              method="post"
              novalidate>

            <input type="hidden" name="action" value="create">

            <label>Nome Categoria</label>
            <input type="text" name="nome" class="form-control" required>

            <button type="submit" class="btn btn-dark mt-2">Crea Categoria</button>
        </form>
    </div>

    <!-- ============================================================
         ⭐ TABELLA CATEGORIE
         ============================================================ -->
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
        <% 
            if (categorie != null) {
                for (Categoria c : categorie) { 
        %>

            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNome() %></td>

                <td>

                    <!-- ⭐ MODIFICA CATEGORIA (CORRETTO) -->
                    <a href="<%= request.getContextPath() %>/admin/categorie?action=edit&id=<%= c.getId() %>"
                       class="btn btn-sm btn-dark">
                        Modifica
                    </a>

                    <!-- ⭐ ELIMINA CATEGORIA -->
                    <form action="<%= request.getContextPath() %>/admin/categorie"
                          method="post"
                          class="d-inline">

                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= c.getId() %>">

                        <button class="btn btn-sm btn-danger"
                                onclick="return confirm('Eliminare questa categoria?')">
                            Elimina
                        </button>
                    </form>

                </td>
            </tr>

        <% 
                }
            } 
        %>
        </tbody>
    </table>

    <!-- ⭐ Logout -->
    <div class="logout mt-5">
        <a class="btn-logout" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
