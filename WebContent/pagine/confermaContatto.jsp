<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Contatto - Il Tempio del Digitale</title>

    <!-- ⭐ Bootstrap per layout responsive -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

<!-- ⭐ Navbar riutilizzabile -->
<jsp:include page="../component/navbar.jsp"/>

<div class="container my-5">

    <!-- ⭐ Sezione principale di conferma -->
    <div class="info-page text-center">

        <!-- Titolo -->
        <h1 class="mb-4">Grazie per averci contattato!</h1>

        <!-- Messaggio descrittivo -->
        <p class="lead">
            Abbiamo ricevuto il tuo messaggio e ti risponderemo al più presto.
        </p>

        <!-- ⭐ Dati inviati dall’utente
             Recuperati tramite request.getAttribute()
             dalla servlet ContattiServlet
        -->
        <div class="mt-4 text-start">
            <h5 class="fw-bold">Dettagli del messaggio:</h5>

            <ul class="list-group mt-3">

                <!-- Nome -->
                <li class="list-group-item">
                    <i class="bi bi-person-fill text-primary"></i>
                    <strong>Nome:</strong> <%= request.getAttribute("nome") %>
                </li>

                <!-- Email -->
                <li class="list-group-item">
                    <i class="bi bi-envelope-fill text-primary"></i>
                    <strong>Email:</strong> <%= request.getAttribute("email") %>
                </li>

                <!-- Messaggio -->
                <li class="list-group-item">
                    <i class="bi bi-chat-left-text-fill text-primary"></i>
                    <strong>Messaggio:</strong> <%= request.getAttribute("messaggio") %>
                </li>

            </ul>
        </div>

        <!-- ⭐ Pulsante Torna alla Home
             Corretto con il tuo stile: btn-secondary btn-lg
             e link corretto: /index (gestito dalla servlet Home)
        -->
        <a href="<%= request.getContextPath() %>/"
           class="btn btn-secondary btn-lg mt-4">
            <i class="bi bi-house-door"></i> Torna alla Home
        </a>

    </div>
</div>

<!-- ⭐ Footer riutilizzabile -->
<jsp:include page="../component/footer.jsp"/>

<!-- ⭐ Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
