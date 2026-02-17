<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    /**
     * ⭐ Logout automatico
     * --------------------
     * Quando l’utente apre la pagina di login, invalido la sessione
     * se esiste. In questo modo:
     * - evito che un utente già loggato rimanga autenticato
     * - garantisco che la pagina login sia sempre “pulita”
     */
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

    <!-- ⭐ Bootstrap CSS per layout responsive -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

<!-- ⭐ Navbar inclusa come componente riutilizzabile -->
<jsp:include page="/component/navbar.jsp"/>

<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">

                <!-- ⭐ Card grafica del login -->
                <div class="card login-card shadow-sm">

                    <div class="card-header text-center">
                        <h4 class="mb-0">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </h4>
                    </div>

                    <div class="card-body">

                        <!-- ⭐ Messaggio di errore lato server -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <!-- ⭐ Form di login -->
                        <!-- 
                             - action → chiama la LoginServlet
                             - method="post" → invio sicuro dei dati
                             - novalidate → disattiva validazione HTML5 per usare JS personalizzato
                        -->
                        <form id="formLogin"
                              action="${pageContext.request.contextPath}/login"
                              method="post"
                              novalidate>

                            <!-- Campo email -->
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="bi bi-envelope"></i> Email
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="email"
                                       name="email">
                            </div>

                            <!-- Campo password -->
                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="bi bi-lock"></i> Password
                                </label>
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password">
                            </div>

                            <!-- Pulsante invio -->
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-box-arrow-in-right"></i> Accedi
                            </button>
                        </form>

                        <!-- ⭐ Pulsante per tornare alla home -->
                        <a href="${pageContext.request.contextPath}/"
                           class="btn btn-secondary w-100 mt-3">
                            <i class="bi bi-house"></i> Torna alla Home
                        </a>

                    </div>

                    <!-- ⭐ Footer della card con link alla registrazione -->
                    <div class="card-footer text-center border-top pt-3">
                        <small>
                            Non hai un account?
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

<!-- ⭐ Footer riutilizzabile -->
<jsp:include page="/component/footer.jsp"/>

<!-- ⭐ Validazione lato client -->
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

<!-- ⭐ Script generali -->
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
