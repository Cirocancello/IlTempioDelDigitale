<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>FAQs - Il Tempio del Digitale</title>

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

        <!-- ⭐ Titolo pagina -->
        <h1>Domande Frequenti (FAQs)</h1>

        <!-- ⭐ Descrizione introduttiva -->
        <p>
            Qui troverai le risposte alle domande più comuni sui nostri servizi e prodotti.
        </p>

        <!-- ⭐ Lista FAQ (contenuto statico informativo) -->
        <ul>
            <li>
                <strong>Come posso registrarmi?</strong>
                Vai alla pagina Registrati e compila il form.
            </li>

            <li>
                <strong>Come funziona il carrello?</strong>
                Aggiungi i prodotti e procedi al checkout.
            </li>

            <li>
                <strong>Posso modificare il mio ordine?</strong>
                Sì, fino alla conferma finale.
            </li>
        </ul>

        <!-- ⭐ Pulsante Torna alla Home
             Corretto con il tuo stile: btn-secondary (coerente con tutto il sito)
             e link corretto: /index (gestito dalla servlet)
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
