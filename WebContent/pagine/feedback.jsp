<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Feedback" %>
<%@ page import="java.util.*" %>

<%
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Feedback degli utenti</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Il tuo CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<div class="container my-5">

    <h2 class="mb-4"><i class="bi bi-chat-left-text"></i> Feedback degli utenti</h2>

    <% if (feedbacks == null || feedbacks.isEmpty()) { %>

        <div class="feedback-empty">
            Nessun feedback disponibile.
        </div>

    <% } else { %>

        <% for (Feedback f : feedbacks) { 
            String titolo = f.getTitolo();
            if (titolo == null || titolo.isBlank()) titolo = "Anonimo";
            String iniziale = titolo.substring(0,1).toUpperCase();
        %>

        <div class="feedback-item">

            <!-- Avatar -->
            <div class="feedback-avatar"><%= iniziale %></div>

            <!-- Contenuto -->
            <div class="feedback-content">

                <h5 class="feedback-title"><%= titolo %></h5>

                <!-- Stelle -->
                <div class="feedback-stars mb-2">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <% if (i <= f.getScore()) { %>
                            <i class="bi bi-star-fill"></i>
                        <% } else { %>
                            <i class="bi bi-star"></i>
                        <% } %>
                    <% } %>
                </div>

                <p class="mb-2"><%= f.getDescrizione() %></p>

                <small class="text-muted">Data: <%= f.getData() %></small>

            </div>

        </div>

        <% } %>

    <% } %>

    <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary mt-4">
        <i class="bi bi-arrow-left"></i> Torna al catalogo
    </a>

</div>

</body>
</html>
