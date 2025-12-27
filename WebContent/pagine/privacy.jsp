<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy - Il Tempio del Digitale</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- CSS custom -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body class="container my-5">

    <div class="info-page">
        <h1>Privacy Policy</h1>
        <p>La tua privacy è importante per noi. I tuoi dati personali vengono trattati nel rispetto delle normative vigenti.</p>
        <p>Non condividiamo le tue informazioni con terze parti senza il tuo consenso.</p>
        <p>Per maggiori dettagli, consulta la nostra informativa completa.</p>

        <!-- Bottone ritorno alla Home -->
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-primary btn-home">
            <i class="bi bi-house-door"></i> Torna alla Home
        </a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
