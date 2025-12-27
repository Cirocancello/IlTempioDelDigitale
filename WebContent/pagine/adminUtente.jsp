<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Utente" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Utente> utenti = (List<Utente>) request.getAttribute("utenti");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Utenti</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <h1 class="mb-4">Gestione Utenti</h1>

    <!-- 🔙 Pulsante ritorno alla Dashboard Admin -->
    <a href="<%= request.getContextPath() %>/pagine/adminDashboard.jsp" 
       class="btn btn-outline-secondary mb-4">
        ← Torna alla Dashboard
    </a>

    <!-- FORM CREAZIONE UTENTE -->
    <div class="admin-form mb-5">
        <h3 class="mb-3">Crea Nuovo Utente</h3>

        <form action="<%= request.getContextPath() %>/admin/utenti" method="post">
            <input type="hidden" name="action" value="create">

            <div class="row">
                <div class="col-md-6">
                    <label>Nome</label>
                    <input type="text" name="nome" required>
                </div>

                <div class="col-md-6">
                    <label>Cognome</label>
                    <input type="text" name="cognome" required>
                </div>
            </div>

            <label>Email</label>
            <input type="email" name="email" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <label>Ruolo</label>
            <select name="role" required>
                <option value="0">Utente</option>
                <option value="1">Admin</option>
            </select>

            <button type="submit" class="btn btn-dark mt-2">Crea Utente</button>
        </form>
    </div>

    <!-- TABELLA UTENTI -->
    <h3 class="mb-3">Lista Utenti</h3>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
            <th>Ruolo</th>
            <th>Azioni</th>
        </tr>
        </thead>

        <tbody>
        <% if (utenti != null) {
            for (Utente u : utenti) { %>

                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getNome() %></td>
                    <td><%= u.getCognome() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getRole() == 1 ? "Admin" : "Utente" %></td>

                    <td>

                        <!-- LINK MODIFICA -->
                        <a href="<%= request.getContextPath() %>/pagine/adminModificaUtente.jsp?id=<%= u.getId() %>"
                           class="btn btn-sm btn-dark">
                            Modifica
                        </a>

                        <!-- FORM DELETE -->
                        <form action="<%= request.getContextPath() %>/admin/utenti" method="post" class="d-inline">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= u.getId() %>">

                            <button class="btn btn-sm btn-danger"
                                    onclick="return confirm('Eliminare questo utente?')">
                                Elimina
                            </button>
                        </form>

                    </td>
                </tr>

        <%  }
        } %>
        </tbody>
    </table>

    <!-- Logout -->
    <div class="logout mt-5">
        <a class="text-danger fw-bold" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
