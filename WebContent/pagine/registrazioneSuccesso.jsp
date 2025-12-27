<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione completata</title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow-sm text-center">
                <div class="card-header bg-success text-white">
                    <h4><i class="bi bi-person-check"></i> Registrazione completata</h4>
                </div>
                <div class="card-body">
                    <p class="card-text">Utente registrato correttamente!</p>
                    <p class="text-muted">Ora puoi effettuare il login per accedere al tuo profilo.</p>
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
