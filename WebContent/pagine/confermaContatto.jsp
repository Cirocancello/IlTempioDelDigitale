<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Contatto - Il Tempio del Digitale</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- CSS custom -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="../component/navbar.jsp"/>

<div class="container my-5">
    <div class="info-page text-center">
        <h1 class="mb-4">Grazie per averci contattato!</h1>
        <p class="lead">Abbiamo ricevuto il tuo messaggio e ti risponderemo al più presto.</p>

        <!-- Dati inviati -->
        <div class="mt-4 text-start">
            <h5 class="fw-bold">Dettagli del messaggio:</h5>
            <ul class="list-group mt-3">
                <li class="list-group-item">
                    <i class="bi bi-person-fill text-primary"></i>
                    <strong>Nome:</strong> <%= request.getAttribute("nome") %>
                </li>
                <li class="list-group-item">
                    <i class="bi bi-envelope-fill text-primary"></i>
                    <strong>Email:</strong> <%= request.getAttribute("email") %>
                </li>
                <li class="list-group-item">
                    <i class="bi bi-chat-left-text-fill text-primary"></i>
                    <strong>Messaggio:</strong> <%= request.getAttribute("messaggio") %>
                </li>
            </ul>
        </div>

        <!-- Bottone ritorno alla Home -->
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-primary btn-home mt-4">
            <i class="bi bi-house-door"></i> Torna alla Home
        </a>
    </div>
</div>

<jsp:include page="../component/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
