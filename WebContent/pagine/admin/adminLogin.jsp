<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Login Admin</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container" style="max-width: 500px;">

    <h1 class="mb-4 text-center">Area Admin</h1>

    <div class="admin-form">

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form id="formAdminLogin"
              action="<%= request.getContextPath() %>/admin/login"
              method="post"
              autocomplete="off"
              novalidate>

            <label for="adminEmail">Email</label>
            <input type="email"
                   id="adminEmail"
                   name="email"
                   class="form-control"
                   required>

            <label for="adminPassword" class="mt-3">Password</label>
            <input type="password"
                   id="adminPassword"
                   name="password"
                   class="form-control"
                   required
                   autocomplete="new-password">

            <button type="submit" class="btn btn-dark w-100 mt-4">Accedi</button>
        </form>

        <!-- ⭐ Pulsante per accedere come utente -->
        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/pagine/login.jsp" class="btn btn-outline-secondary w-100">
                Accedi come utente
            </a>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
