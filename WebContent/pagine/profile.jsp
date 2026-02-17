<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!--
>“Uso JSTL, la JavaServer Pages Standard Tag Library, per gestire condizioni e cicli nelle JSP senza usare scriptlet.
Questo rende le pagine più pulite, leggibili e aderenti al pattern MVC.
In particolare uso la libreria Core (c:) per if, forEach e choose.”
-->

<%
    /**
     * ⭐ Protezione JSP
     * -----------------
     * Anche se la servlet controlla già l’autenticazione,
     * aggiungo una protezione lato JSP per evitare accessi diretti.
     * Se la sessione non esiste o manca il token "auth",
     * reindirizzo al login.
     */
    if (session == null || session.getAttribute("auth") == null) {
        response.sendRedirect(request.getContextPath() + "/pagine/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Profilo Utente</title>

    <!-- ⭐ Bootstrap CSS -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">

    <!-- ⭐ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

<!-- ⭐ Navbar riutilizzabile -->
<jsp:include page="../component/navbar.jsp"/>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <!-- ⭐ CARD PROFILO UTENTE -->
            <div class="card shadow-sm mb-4">
                <div class="card-header text-center">
                    <h4><i class="bi bi-person-circle"></i> Profilo Utente</h4>
                </div>

                <div class="card-body">

                    <!-- ⭐ Dati utente caricati dalla servlet -->
                    <p><strong><i class="bi bi-person"></i> Nome:</strong> ${utente.nome}</p>
                    <p><strong><i class="bi bi-person"></i> Cognome:</strong> ${utente.cognome}</p>
                    <p><strong><i class="bi bi-envelope"></i> Email:</strong> ${utente.email}</p>
                    <p><strong><i class="bi bi-geo-alt"></i> Provincia:</strong> ${utente.provincia}</p>
                    <p><strong><i class="bi bi-mailbox"></i> CAP:</strong> ${utente.cap}</p>
                    <p><strong><i class="bi bi-house"></i> Indirizzo:</strong> ${utente.via} ${utente.civico}</p>

                    <!-- ⭐ Ruolo utente con JSTL -->
                    <p><strong><i class="bi bi-shield-lock"></i> Ruolo:</strong>
                        <c:choose>
                            <c:when test="${utente.role == 1}">Admin</c:when>
                            <c:otherwise>Utente</c:otherwise>
                        </c:choose>
                    </p>

                </div>
            </div>

            <!-- ⭐ CARD PREFERITI -->
            <div class="card shadow-sm mb-4">
                <div class="card-header text-center">
                    <h4><i class="bi bi-heart"></i> I miei Preferiti</h4>
                </div>

                <div class="card-body">

                    <!-- ⭐ Caso: nessun preferito -->
                    <c:if test="${empty listaPreferiti}">
                        <p class="text-muted">Non hai ancora salvato nessun prodotto tra i preferiti.</p>
                    </c:if>

                    <!-- ⭐ Lista preferiti -->
                    <c:forEach var="p" items="${listaPreferiti}">

                        <div class="d-flex justify-content-between align-items-center border-bottom py-2">

                            <!-- ⭐ Mini-card prodotto -->
                            <div class="d-flex align-items-center">

                                <!-- Immagine prodotto -->
                                <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                     class="img-thumbnail me-3"
                                     style="width: 60px; height: 60px; object-fit: cover;">

                                <div>
                                    <strong>${p.nome}</strong><br>
                                    <span class="text-success">€ ${p.prezzo}</span>
                                </div>
                            </div>

                            <!-- ⭐ Azioni: visualizza + rimuovi -->
                            <div class="d-flex align-items-center">

                                <!-- Vai al prodotto -->
                                <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                                   class="btn btn-sm btn-outline-secondary me-2">
                                    <i class="bi bi-eye"></i>
                                </a>

                                <!-- Rimuovi dai preferiti -->
                                <form method="post"
                                      action="${pageContext.request.contextPath}/preferiti?action=remove"
                                      class="mb-0">
                                    <input type="hidden" name="id_prodotto" value="${p.id}">
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>

                            </div>

                        </div>

                    </c:forEach>

                </div>
            </div>

            <!-- ⭐ Pulsanti finali -->
            <a href="<%= request.getContextPath() %>/ordini" class="btn btn-primary">
                <i class="bi bi-receipt"></i> I miei ordini
            </a>

            <a href="<%= request.getContextPath() %>/" class="btn btn-secondary mt-3">
                <i class="bi bi-house"></i> Torna alla Home
            </a>

        </div>
    </div>
</div>

<!-- ⭐ Footer riutilizzabile -->
<jsp:include page="../component/footer.jsp"/>

</body>
</html>
