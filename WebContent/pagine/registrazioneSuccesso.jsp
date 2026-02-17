<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione completata</title>

    <!-- ⭐ Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>

<body>

<!-- ⭐ CONTENITORE PRINCIPALE -->
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <!-- ⭐ CARD DI CONFERMA REGISTRAZIONE -->
            <div class="card shadow-sm text-center">

                <!-- Header verde di successo -->
                <div class="card-header bg-success text-white">
                    <h4>
                        <i class="bi bi-person-check"></i> Registrazione completata
                    </h4>
                </div>

                <!-- Corpo della card -->
                <div class="card-body">

                    <!-- Messaggio principale -->
                    <p class="card-text">
                        Utente registrato correttamente!
                    </p>

                    <!-- Messaggio secondario -->
                    <p class="text-muted">
                        Ora puoi effettuare il login per accedere al tuo profilo.
                    </p>

                    <!-- ⭐ Pulsante per andare al login -->
                    <a href="${pageContext.request.contextPath}/pagine/login.jsp" 
                       class="btn btn-primary mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Vai al Login
                    </a>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
