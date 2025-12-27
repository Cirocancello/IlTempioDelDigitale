<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>FAQs - Il Tempio del Digitale</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- CSS custom -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body class="container my-5">

    <div class="info-page">
        <h1>Domande Frequenti (FAQs)</h1>
        <p>Qui troverai le risposte alle domande più comuni sui nostri servizi e prodotti.</p>
        
        <ul>
            <li><strong>Come posso registrarmi?</strong> Vai alla pagina Registrati e compila il form.</li>
            <li><strong>Come funziona il carrello?</strong> Aggiungi i prodotti e procedi al checkout.</li>
            <li><strong>Posso modificare il mio ordine?</strong> Sì, fino alla conferma finale.</li>
        </ul>

        <!-- Bottone ritorno alla Home -->
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-primary btn-home">
            <i class="bi bi-house-door"></i> Torna alla Home
        </a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
