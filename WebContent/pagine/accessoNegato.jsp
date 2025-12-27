<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Accesso Negato</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- CSS personalizzato -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <!-- Card accesso negato -->
            <div class="card shadow-sm text-center">
                <div class="card-header bg-danger text-white">
                    <h4><i class="bi bi-shield-lock"></i> Accesso Negato</h4>
                </div>
                <div class="card-body">
                    <p class="card-text">
                        Non sei autorizzato a visualizzare questa pagina. Devi effettuare il login.
                    </p>
                    <!-- ✅ Correzione: link alla login.jsp -->
                    <a href="${pageContext.request.contextPath}/pagine/login.jsp" 
                       class="btn btn-primary mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Vai al Login
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../component/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
