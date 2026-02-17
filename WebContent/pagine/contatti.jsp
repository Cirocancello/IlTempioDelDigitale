<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Contatti - Il Tempio del Digitale</title>

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

<!-- ⭐ HERO SECTION: titolo + descrizione -->
<div class="container my-5 text-center">
    <h1 class="mb-3">Contattaci</h1>
    <p class="lead">
        Hai domande o richieste? Compila il form e ti risponderemo al più presto.
    </p>
</div>

<!-- ⭐ FORM DI CONTATTO -->
<div class="container my-4">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <!-- ⭐ Form con validazione Bootstrap -->
            <form method="post"
                  action="<%= request.getContextPath() %>/contatti"
                  class="needs-validation"
                  novalidate>

                <!-- Nome -->
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" required>
                    <div class="invalid-feedback">Inserisci il tuo nome.</div>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                    <div class="invalid-feedback">Inserisci un indirizzo email valido.</div>
                </div>

                <!-- Messaggio -->
                <div class="mb-3">
                    <label for="messaggio" class="form-label">Messaggio</label>
                    <textarea class="form-control" id="messaggio" name="messaggio" rows="5" required></textarea>
                    <div class="invalid-feedback">Scrivi il tuo messaggio.</div>
                </div>

                <!-- ⭐ Pulsanti azione -->
                <div class="d-flex">

                    <!-- Invia -->
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="bi bi-send"></i> Invia
                    </button>

                    <!-- Torna alla Home (stile corretto e coerente) -->
                    <a href="<%= request.getContextPath() %>/"
                       class="btn btn-secondary">
                        <i class="bi bi-house"></i> Torna alla Home
                    </a>

                </div>

            </form>
        </div>
    </div>
</div>

<!-- ⭐ Footer riutilizzabile -->
<jsp:include page="../component/footer.jsp"/>

<!-- ⭐ Script Bootstrap + script personalizzato -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
