<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Utente" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Ordini</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body>

<div class="admin-container">

    <h1 class="mb-4">Gestione Ordini</h1>

    <!-- 🔙 Pulsante ritorno alla Dashboard Admin -->
    <a href="<%= request.getContextPath() %>/pagine/adminDashboard.jsp" 
       class="btn btn-outline-secondary mb-4">
        ← Torna alla Dashboard
    </a>

    <h3 class="mb-3">Lista Ordini</h3>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Utente</th>
            <th>Data</th>
            <th>Totale</th>
            <th>Stato</th>
            <th>Azioni</th>
        </tr>
        </thead>

        <tbody>
        <% 
        if (ordini != null) {
            for (Ordine o : ordini) { 
        %>

            <tr>
                <td><%= o.getId() %></td>

                <!-- ⭐ Gestione sicura dell'utente -->
                <td>
                    <%= (o.getUtente() != null) 
                        ? o.getUtente().getEmail() 
                        : "—" %>
                </td>

                <td><%= o.getData() %></td>
                <td>€ <%= o.getTotale() %></td>
                <td><%= o.getStato() %></td>

                <td>

                    <!-- FORM UPDATE STATO -->
                    <form action="<%= request.getContextPath() %>/admin/ordini" method="post" class="d-inline">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= o.getId() %>">

                        <select name="stato" class="form-select form-select-sm d-inline w-auto">
                            <option value="In elaborazione" <%= o.getStato().equals("In elaborazione") ? "selected" : "" %>>In elaborazione</option>
                            <option value="Spedito" <%= o.getStato().equals("Spedito") ? "selected" : "" %>>Spedito</option>
                            <option value="Consegnato" <%= o.getStato().equals("Consegnato") ? "selected" : "" %>>Consegnato</option>
                            <option value="Annullato" <%= o.getStato().equals("Annullato") ? "selected" : "" %>>Annullato</option>
                        </select>

                        <button class="btn btn-sm btn-dark">Aggiorna</button>
                    </form>

                    <!-- FORM DELETE -->
                    <form action="<%= request.getContextPath() %>/admin/ordini" method="post" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= o.getId() %>">

                        <button class="btn btn-sm btn-danger"
                                onclick="return confirm('Eliminare questo ordine?')">
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

    <div class="logout mt-5">
        <a class="text-danger fw-bold" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
