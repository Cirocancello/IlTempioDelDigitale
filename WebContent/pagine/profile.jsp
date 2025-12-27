<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Profilo Utente</title>

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

<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <!-- Card profilo -->
            <div class="card shadow-sm mb-4">
                <div class="card-header text-center">
                    <h4><i class="bi bi-person-circle"></i> Profilo Utente</h4>
                </div>
                <div class="card-body">
                    <p><strong><i class="bi bi-person"></i> Nome:</strong> ${utente.nome}</p>
                    <p><strong><i class="bi bi-person"></i> Cognome:</strong> ${utente.cognome}</p>
                    <p><strong><i class="bi bi-envelope"></i> Email:</strong> ${utente.email}</p>
                    <p><strong><i class="bi bi-geo-alt"></i> Provincia:</strong> ${utente.provincia}</p>
                    <p><strong><i class="bi bi-mailbox"></i> CAP:</strong> ${utente.cap}</p>
                    <p><strong><i class="bi bi-house"></i> Indirizzo:</strong> ${utente.via} ${utente.civico}</p>                 
                    <p><strong><i class="bi bi-shield-lock"></i> Ruolo:</strong> 
                        <c:choose>
                            <c:when test="${utente.role == 1}">Admin</c:when>
                            <c:otherwise>Utente</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <!-- Card preferiti -->
            <div class="card shadow-sm">
                <div class="card-header text-center">
                    <h4><i class="bi bi-heart"></i> I miei Preferiti</h4>
                </div>
                <div class="card-body">
                    <c:if test="${empty listaPreferiti}">
                        <p class="text-muted">Non hai ancora salvato nessun prodotto tra i preferiti.</p>
                    </c:if>

                    <c:forEach var="p" items="${listaPreferiti}">
                        <div class="d-flex justify-content-between align-items-center border-bottom py-2">
                            <span>
                                <i class="bi bi-box"></i> Prodotto ID: ${p.prodottoId} 
                                <small class="text-muted">- aggiunto il ${p.data}</small>
                            </span>
                            <form method="post" action="${pageContext.request.contextPath}/preferiti?action=remove" class="mb-0">
                                <input type="hidden" name="id_prodotto" value="${p.prodottoId}">
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i> Rimuovi
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
                <a href="<%= request.getContextPath() %>/ordini" class="btn btn-primary">
    				<i class="bi bi-receipt"></i> I miei ordini
				</a>
                
                 <a href="<%= request.getContextPath() %>/index" class="btn btn-secondary mt-4">
       				<i class="bi bi-house"></i> Torna alla Home
    			 </a> 
            </div>

        </div>
    </div>
   
</div>

<jsp:include page="../component/footer.jsp"/>

</body>
</html>
