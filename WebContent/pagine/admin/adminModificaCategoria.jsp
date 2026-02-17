<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    // ⭐ RECUPERO CATEGORIA PASSATA DALLA SERVLET
    // ============================================================
    Categoria c = (Categoria) request.getAttribute("categoria");

    if (c == null) {
        response.sendRedirect(request.getContextPath() + "/admin/categorie");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Categoria</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile personalizzato admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <!-- ⭐ Titolo pagina -->
    <h1 class="mb-4">Modifica Categoria</h1>

    <!-- ⭐ Pulsante ritorno alla Dashboard -->
    <a href="<%= request.getContextPath() %>/admin/dashboard"
       class="btn-back-dashboard mb-4">
        ← Torna alla Dashboard
    </a>

    <!-- ============================================================
         ⭐ FORM MODIFICA CATEGORIA (STILIZZATO)
         ============================================================ -->
    <div class="admin-form">

        <h3 class="mb-3">Modifica Categoria</h3>

        <form id="formAdminModificaCategoria"
              action="<%= request.getContextPath() %>/admin/categorie"
              method="post"
              novalidate>

            <!-- Operazione UPDATE -->
            <input type="hidden" name="action" value="update">

            <!-- ID categoria -->
            <input type="hidden" name="id" value="<%= c.getId() %>">

            <!-- Nome categoria -->
            <label class="form-label">Nome Categoria</label>
            <input type="text"
                   name="nome"
                   class="form-control"
                   value="<%= c.getNome() %>"
                   required>

            <!-- Pulsanti -->
            <button type="submit" class="btn btn-dark mt-3">Salva Modifiche</button>

            <a href="<%= request.getContextPath() %>/admin/categorie"
               class="btn btn-secondary mt-3">
                Annulla
            </a>

        </form>

    </div>

    <!-- ⭐ Logout -->
    <div class="logout mt-5">
        <a class="btn-logout" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
