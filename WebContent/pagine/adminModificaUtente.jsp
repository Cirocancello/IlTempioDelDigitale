<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>
<%@ page import="dao.UtenteDAO" %>
<%@ page import="db.DBConnection" %>

<%
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    UtenteDAO dao = new UtenteDAO();
    Utente u = dao.findById(id);

    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/admin/utenti");
        return;
    }
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

    <!-- 🔙 Pulsante ritorno alla Dashboard Admin -->
    <a href="<%= request.getContextPath() %>/pagine/adminDashboard.jsp" 
       class="btn btn-outline-secondary mb-4">
        ← Torna alla Dashboard
    </a>

    <form action="<%= request.getContextPath() %>/admin/utenti" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= u.getId() %>">

        <div class="row">
            <div class="col-md-6">
                <label>Nome</label>
                <input type="text" name="nome" value="<%= u.getNome() %>" required>
            </div>

            <div class="col-md-6">
                <label>Cognome</label>
                <input type="text" name="cognome" value="<%= u.getCognome() %>" required>
            </div>
        </div>

        <label>Email</label>
        <input type="email" name="email" value="<%= u.getEmail() %>" required>

        <label>Ruolo</label>
        <select name="role" required>
            <option value="0" <%= u.getRole()==0 ? "selected" : "" %>>Utente</option>
            <option value="1" <%= u.getRole()==1 ? "selected" : "" %>>Admin</option>
        </select>

        <button type="submit" class="btn btn-dark mt-3">Salva Modifiche</button>
        <a href="<%= request.getContextPath() %>/admin/utenti" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div>

</body>
</html>
