<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>

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
     ⭐ Contenitore principale della pagina di conferma logout
     Questa pagina viene mostrata DOPO che la servlet ha invalidato
     la sessione dell’amministratore.
     ============================================================ -->
<div class="admin-container text-center">

    <!-- Titolo -->
    <h1 class="mb-4">Logout effettuato</h1>

    <!-- Messaggio informativo -->
    <p>La sessione è stata chiusa correttamente.</p>

    <!-- ⭐ Pulsante per tornare al login admin -->
    <a class="btn btn-dark mt-3" href="<%= request.getContextPath() %>/admin/login">
        Torna al Login
    </a>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
