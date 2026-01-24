<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Categoria" %>
<%@ page import="dao.CategoriaDAO" %>
<%@ page import="db.DBConnection" %>
<%@ page import="java.sql.Connection" %>

<%
    // Controllo admin
    Object utente = session.getAttribute("utente");
    if (utente == null || ((model.Utente)utente).getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // Recupero ID categoria
    int id = Integer.parseInt(request.getParameter("id"));

    // Connessione + DAO
    Connection conn = DBConnection.getConnection();
    CategoriaDAO dao = new CategoriaDAO(conn);

    Categoria c = dao.findById(id);

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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container my-5">

    <h1 class="mb-4">Modifica Categoria</h1>

    <!-- 🔙 Pulsante ritorno alla Dashboard Admin -->
    <a href="<%= request.getContextPath() %>/admin/dashboard"
       class="btn btn-outline-secondary mb-4">
        ← Torna alla Dashboard
    </a>

    <!-- ⭐ FORM MODIFICA CATEGORIA -->
    <form id="formAdminModificaCategoria"
          action="<%= request.getContextPath() %>/admin/categorie"
          method="post"
          novalidate>

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= c.getId() %>">

        <label class="form-label">Nome Categoria</label>
        <input type="text" name="nome" class="form-control" value="<%= c.getNome() %>" required>

        <button type="submit" class="btn btn-dark mt-3">Salva Modifiche</button>
        <a href="<%= request.getContextPath() %>/admin/categorie" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

</body>
</html>
