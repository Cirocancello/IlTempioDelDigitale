<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="dashboard-container">

    <!-- Titolo -->
    <h1 class="mb-4">Benvenuto, <%= admin.getNome() %> 👋</h1>

    <!-- Griglia delle sezioni -->
    <div class="grid">

        <!-- Prodotti -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Prodotti</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/prodotti">Vai</a>
        </div>

        <!-- Categorie -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Categorie</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/categorie">Vai</a>
        </div>

        <!-- Ordini -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Ordini</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/ordini">Vai</a>
        </div>

        <!-- Utenti -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Utenti</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/utenti">Vai</a>
        </div>

    </div>

    <!-- Logout -->
    <div class="logout mt-5">
        <a class="btn-logout" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

    <!-- ⭐ Torna all’area utente (login utente) -->
    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/pagine/login.jsp" class="btn-admin-action">
            Vai all’area utente
        </a>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
