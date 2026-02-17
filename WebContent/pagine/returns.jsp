<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Resi - Il Tempio del Digitale</title>

    <!-- ⭐ Bootstrap per layout responsive -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body class="container my-5">

    <!-- ⭐ SEZIONE INFORMATIVA PRINCIPALE -->
    <div class="info-page">

        <!-- Titolo pagina -->
        <h1>Politiche di Reso</h1>

        <!-- Testo descrittivo -->
        <p>
            Se non sei soddisfatto del tuo acquisto, puoi restituire i prodotti entro 
            <strong>14 giorni</strong>.
        </p>

        <p>
            I prodotti devono essere integri e accompagnati dalla ricevuta di acquisto.
        </p>

        <p>
            Per avviare una richiesta di reso, contatta il nostro servizio clienti.
        </p>

        <!-- ⭐ Pulsante Torna alla Home
             Corretto con il tuo stile: btn-secondary (coerente con tutto il sito)
             e link corretto: /index (gestito dalla servlet Home)
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
