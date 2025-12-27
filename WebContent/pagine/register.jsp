<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione Utente</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
       
    <!-- Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<jsp:include page="/component/navbar.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">

            <!-- Card registrazione -->
            <div class="card register-card shadow-sm">
                <div class="card-header text-center">
                    <h4><i class="bi bi-person-plus"></i> Registrazione</h4>
                </div>

                <div class="card-body">

                    <!-- Messaggio di errore -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Form di registrazione -->
                    <form action="${pageContext.request.contextPath}/register" 
                          method="post" 
                          class="needs-validation" 
                          novalidate>

                        <!-- Nome -->
                        <div class="mb-3">
                            <label for="nome" class="form-label">
                                <i class="bi bi-person"></i> Nome
                            </label>
                            <input type="text" class="form-control" id="nome" name="nome" required>
                        </div>

                        <!-- Cognome -->
                        <div class="mb-3">
                            <label for="cognome" class="form-label">
                                <i class="bi bi-person"></i> Cognome
                            </label>
                            <input type="text" class="form-control" id="cognome" name="cognome" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email
                            </label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <!-- Provincia -->
                        <div class="mb-3">
                            <label for="provincia" class="form-label">Provincia</label>
                            <input type="text" class="form-control" id="provincia" name="provincia">
                        </div>

                        <!-- CAP -->
                        <div class="mb-3">
                            <label for="cap" class="form-label">CAP</label>
                            <input type="text" class="form-control" id="cap" name="cap">
                        </div>

                        <!-- Via -->
                        <div class="mb-3">
                            <label for="via" class="form-label">Via</label>
                            <input type="text" class="form-control" id="via" name="via">
                        </div>

                        <!-- Civico -->
                        <div class="mb-3">
                            <label for="civico" class="form-label">Civico</label>
                            <input type="text" class="form-control" id="civico" name="civico">
                        </div>

                        <!-- Pulsante Registrati -->
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-person-plus"></i> Registrati
                        </button>

                        <!-- Pulsante Torna alla Home -->
                        <a href="${pageContext.request.contextPath}/index" 
                           class="btn btn-secondary w-100 mt-3">
                            <i class="bi bi-house"></i> Torna alla Home
                        </a>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/component/footer.jsp"/>
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
