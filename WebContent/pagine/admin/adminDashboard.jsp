<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>

<%
    // ============================================================
    // ⭐ CONTROLLO ACCESSO ADMIN
    // La dashboard è accessibile solo se:
    //   - esiste una sessione
    //   - esiste un utente in sessione
    //   - il ruolo dell’utente è 1 (admin)
    // Questo controllo protegge l’area riservata.
    // ============================================================
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
     ⭐ CONTENITORE PRINCIPALE DELLA DASHBOARD
     ============================================================ -->
<div class="dashboard-container">

    <!-- ⭐ Titolo di benvenuto con nome admin -->
    <h1 class="mb-4">Benvenuto, <%= admin.getNome() %> 👋</h1>

    <!-- ============================================================
         ⭐ GRIGLIA DELLE SEZIONI AMMINISTRATIVE
         Ogni card rappresenta un modulo dell’area admin:
         - Prodotti
         - Categorie
         - Ordini
         - Utenti
         ============================================================ -->
    <div class="grid">

        <!-- ⭐ Gestione Prodotti -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Prodotti</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/prodotti">Vai</a>
        </div>

        <!-- ⭐ Gestione Categorie -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Categorie</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/categorie">Vai</a>
        </div>

        <!-- ⭐ Gestione Ordini -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Ordini</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/ordini">Vai</a>
        </div>

        <!-- ⭐ Gestione Utenti -->
        <div class="card p-4">
            <h2 class="mb-3">Gestione Utenti</h2>
            <a class="btn btn-dark w-100" href="<%= request.getContextPath() %>/admin/utenti">Vai</a>
        </div>

    </div>

    <!-- ============================================================
         ⭐ Logout amministratore
         ============================================================ -->
    <div class="logout mt-5">
        <a class="btn-logout" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

    <!-- ============================================================
         ⭐ Link per tornare all’area utente
         Utile se l’amministratore vuole accedere come utente normale
         ============================================================ -->
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
