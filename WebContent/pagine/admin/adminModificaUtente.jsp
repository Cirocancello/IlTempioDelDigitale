<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    // ⭐ RECUPERO UTENTE PASSATO DALLA SERVLET
    // ============================================================
    Utente u = (Utente) request.getAttribute("utente");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Utente</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <h1 class="mb-4">Modifica Utente</h1>

    <a href="<%= request.getContextPath() %>/admin/utenti"
       class="btn btn-outline-secondary mb-4">
        ← Torna alla lista utenti
    </a>

    <% if (u == null) { %>

        <!-- ============================================================
             ⭐ UTENTE NON TROVATO
             ============================================================ -->
        <div class="alert alert-danger">
            Errore: utente non trovato.
        </div>

        <a href="<%= request.getContextPath() %>/admin/utenti" class="btn btn-secondary mt-3">
            Torna alla lista
        </a>

    </div> <!-- chiusura admin-container -->
</body>
</html>

<% return; } %>

    <!-- ============================================================
         ⭐ FORM MODIFICA UTENTE
         ============================================================ -->
    <form action="<%= request.getContextPath() %>/admin/utenti"
          method="post"
          novalidate>

        <!-- Operazione UPDATE -->
        <input type="hidden" name="action" value="update">

        <!-- ID utente -->
        <input type="hidden" name="id" value="<%= u.getId() %>">

        <div class="row">
            <div class="col-md-6">
                <label class="form-label">Nome</label>
                <input type="text" name="nome" value="<%= u.getNome() %>" class="form-control" required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Cognome</label>
                <input type="text" name="cognome" value="<%= u.getCognome() %>" class="form-control" required>
            </div>
        </div>

        <div class="mt-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" value="<%= u.getEmail() %>" class="form-control" required>
        </div>

        <div class="mt-3">
            <label class="form-label">Ruolo</label>
            <select name="role" class="form-select" required>
                <option value="0" <%= u.getRole()==0 ? "selected" : "" %>>Utente</option>
                <option value="1" <%= u.getRole()==1 ? "selected" : "" %>>Admin</option>
            </select>
        </div>

        <button type="submit" class="btn btn-dark mt-3">Salva Modifiche</button>
        <a href="<%= request.getContextPath() %>/admin/utenti" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div> <!-- chiusura admin-container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

</body>
</html>
