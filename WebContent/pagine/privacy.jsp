<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy - Il Tempio del Digitale</title>

    <!-- ⭐ Bootstrap per layout responsive -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body class="container my-5">

    <!-- ⭐ SEZIONE INFORMATIVA -->
    <div class="info-page">

        <!-- Titolo pagina -->
        <h1>Privacy Policy</h1>

        <!-- Testo descrittivo -->
        <p>
            La tua privacy è importante per noi. I tuoi dati personali vengono trattati nel rispetto
            delle normative vigenti e utilizzati esclusivamente per finalità legate ai nostri servizi.
        </p>

        <p>
            Non condividiamo le tue informazioni con terze parti senza il tuo consenso, salvo obblighi
            di legge o necessità operative strettamente collegate ai nostri servizi.
        </p>

        <p>
            Per maggiori dettagli, consulta la nostra informativa completa o contattaci tramite l’apposita sezione.
        </p>

        <!-- 
         ⭐ Pulsante Torna alla Home       
        -->
        <a href="<%= request.getContextPath() %>/"
           class="btn btn-secondary btn-lg mt-4">
            <i class="bi bi-house-door"></i> Torna alla Home
        </a>

    </div>

    <!-- ⭐ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
