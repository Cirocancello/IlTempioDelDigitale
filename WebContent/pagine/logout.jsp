<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
          
    <!-- Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
   

    <!-- Redirect automatico dopo 5 secondi -->
    <meta http-equiv="refresh" content="5;url=${pageContext.request.contextPath}/pagine/login.jsp">

</head>
<body>

<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <!-- Card logout -->
            <div class="card shadow-sm text-center">
                <div class="card-header">
                    <h4><i class="bi bi-box-arrow-right"></i> Logout</h4>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Sei stato disconnesso</h5>
                    <p class="card-text">La tua sessione è stata chiusa correttamente.</p>
                    
                    <!-- Messaggio di saluto -->
                    <p class="mt-3 text-success">
                        Grazie per aver visitato <strong>Il Tempio del Digitale</strong>, a presto! 
                        <i class="bi bi-emoji-smile"></i>
                    </p>

                    <!-- Link manuale al login -->
                    <a href="${pageContext.request.contextPath}/pagine/login.jsp" 
                       class="btn btn-primary mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Vai subito al Login
                    </a>
                </div>
                <div class="card-footer text-muted">
                    Verrai reindirizzato automaticamente alla pagina di login tra pochi secondi...
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../component/footer.jsp"/>

</body>
</html>
