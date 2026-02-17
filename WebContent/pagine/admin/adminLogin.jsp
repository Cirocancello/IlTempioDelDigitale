<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Login Admin</title>

    <!-- ============================================================
         ⭐ Bootstrap per lo stile base
         ============================================================ -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ============================================================
         ⭐ Foglio di stile personalizzato dell’area admin
         ============================================================ -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<!-- ============================================================
     ⭐ Contenitore principale della pagina di login admin
     ============================================================ -->
<div class="admin-container" style="max-width: 500px;">

    <h1 class="mb-4 text-center">Area Admin</h1>

    <div class="admin-form">

        <!-- ============================================================
             ⭐ Messaggio di errore passato dalla servlet (se presente)
             ============================================================ -->
        <% 
            String error = (String) request.getAttribute("error"); 
            if (error != null) { 
        %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <!-- ============================================================
             ⭐ FORM DI LOGIN ADMIN
             - action → invia i dati alla AdminLoginServlet
             - method POST → invio sicuro delle credenziali
             - autocomplete off → evita salvataggi indesiderati
             ============================================================ -->
        <form id="formAdminLogin"
              action="<%= request.getContextPath() %>/admin/login"
              method="post"
              autocomplete="off"
              novalidate>

            <!-- Email admin -->
            <label for="adminEmail">Email</label>
            <input type="email"
                   id="adminEmail"
                   name="email"
                   class="form-control"
                   required>

            <!-- Password admin -->
            <label for="adminPassword" class="mt-3">Password</label>
            <input type="password"
                   id="adminPassword"
                   name="password"
                   class="form-control"
                   required
                   autocomplete="new-password">

            <!-- Pulsante invio -->
            <button type="submit" class="btn btn-dark w-100 mt-4">Accedi</button>
        </form>

        <!-- ============================================================
             ⭐ Link alternativo: login utente normale
             ============================================================ -->
        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/pagine/login.jsp" 
               class="btn btn-outline-secondary w-100">
                Accedi come utente
            </a>
        </div>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
