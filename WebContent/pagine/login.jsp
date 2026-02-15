<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    HttpSession sessione = request.getSession(false);
    if (sessione != null) {
        sessione.invalidate();
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">

</head>
<body>

<jsp:include page="/component/navbar.jsp"/>

<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">

                <!-- Card login -->
                <div class="card login-card shadow-sm">

                    <div class="card-header text-center">
                        <h4 class="mb-0"><i class="bi bi-box-arrow-in-right"></i> Login</h4>
                    </div>

                    <div class="card-body">

                        <!-- Messaggi di errore -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form id="formLogin" 
						      action="${pageContext.request.contextPath}/login" 
						      method="post" 
						      novalidate>
						
						    <div class="mb-3">
						        <label for="email" class="form-label">
						            <i class="bi bi-envelope"></i> Email
						        </label>
						        <input type="text" 
						               class="form-control" 
						               id="email" 
						               name="email">
						    </div>
						
						    <div class="mb-3">
						        <label for="password" class="form-label">
						            <i class="bi bi-lock"></i> Password
						        </label>
						        <input type="password" 
						               class="form-control" 
						               id="password" 
						               name="password">
						    </div>
						
						    <button type="submit" class="btn btn-primary w-100">
						        <i class="bi bi-box-arrow-in-right"></i> Accedi
						    </button>
						</form>



                        <!-- Pulsante torna alla Home -->
                        <a href="${pageContext.request.contextPath}/index" 
                           class="btn btn-secondary w-100 mt-3">
                            <i class="bi bi-house"></i> Torna alla Home
                        </a>

                    </div>

                    <div class="card-footer text-center border-top pt-3">
                        <small>Non hai un account? 
                            <a href="${pageContext.request.contextPath}/pagine/register.jsp">
                                <i class="bi bi-person-plus"></i> Registrati
                            </a>
                        </small>
                    </div>

                </div>

            </div>
        </div>
    </div>
</section>

<jsp:include page="/component/footer.jsp"/>

<!-- Validazione client-side -->
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>
<!-- Script generali -->
<script src="<%= request.getContextPath() %>/assets/script.js"></script>
</body>
</html>
