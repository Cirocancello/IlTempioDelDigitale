<%@ page contentType="text/html; charset=UTF-8" %>

<!-- ⭐ JSTL per cicli e condizioni -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Il Tempio del Digitale - Home</title>

    <!-- ⭐ Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- ⭐ Stile personalizzato -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>

<body>

<!-- ⭐ Navbar riutilizzabile -->
<jsp:include page="../component/navbar.jsp"/>

<!-- ⭐ HERO SECTION -->
<div class="container my-5 text-center">

    <img src="${pageContext.request.contextPath}/assets/img/logo/logo.PNG"
         alt="Logo"
         class="mb-4"
         style="max-width:150px;">

    <h1 class="mb-3">Benvenuto al Tempio del Digitale</h1>

    <p class="lead">
        Scopri i nostri prodotti, i servizi e la passione che ci guida nel mondo digitale.
    </p>

    <!-- ⭐ CAROSELLO -->
    <header class="carousel-container">
        <div class="carousel">

            <!-- Slide 1 -->
            <div class="carousel-item carousel-item--visible">
                <img src="${pageContext.request.contextPath}/assets/img/index/carousel/andras-vas-Bd7gNnWJBkU-unsplash.jpg"
                     class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Potenza e precisione digitale</h1>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/index/carousel/balkouras-nicos-ncOQxZe8Krw-unsplash.jpg"
                     class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Dentro il cuore della tecnologia</h1>
                </div>
            </div>

            <!-- Slide 3 -->
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/index/carousel/joshua-ng-1sSfrozgiFk-unsplash.jpg"
                     class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Hardware e innovazione senza confini</h1>
                </div>
            </div>

            <!-- Frecce -->
            <div class="carousel-actions">
                <button class="carousel-button">
                    <i class="fas fa-chevron-left fa-3x"></i>
                </button>
                <button class="carousel-button">
                    <i class="fas fa-chevron-right fa-3x"></i>
                </button>
            </div>

        </div>
    </header>

    <!-- ⭐ Pulsanti principali -->
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-primary btn-lg me-2">
            <i class="bi bi-shop"></i> Vai al Catalogo
        </a>

        <a href="${pageContext.request.contextPath}/pagine/chiSiamo.jsp" class="btn btn-outline-secondary btn-lg me-2">
            <i class="bi bi-people"></i> Chi Siamo
        </a>

        <a href="${pageContext.request.contextPath}/pagine/contatti.jsp" class="btn btn-outline-green btn-lg">
            <i class="bi bi-envelope"></i> Contattaci
        </a>
    </div>
</div>

<!-- ⭐ SEZIONE PUNTI DI FORZA -->
<div class="container my-5">
    <div class="row">

        <div class="col-md-4 text-center">
            <i class="bi bi-laptop display-4 text-primary"></i>
            <h4 class="mt-3">Tecnologia</h4>
            <p>Prodotti selezionati per innovazione e qualità.</p>
        </div>

        <div class="col-md-4 text-center">
            <i class="bi bi-lightbulb display-4 text-warning"></i>
            <h4 class="mt-3">Creatività</h4>
            <p>Soluzioni digitali pensate per ispirare e crescere.</p>
        </div>

        <div class="col-md-4 text-center">
            <i class="bi bi-shield-check display-4 text-success"></i>
            <h4 class="mt-3">Affidabilità</h4>
            <p>Servizi sicuri e supporto costante per i nostri clienti.</p>
        </div>

    </div>
</div>

<!-- ⭐ SEZIONE PRODOTTI PIÙ VENDUTI -->
<div class="container my-5 top-products">

    <h2 class="text-center mb-4">Prodotti più venduti</h2>

    <div class="row">

        <!-- ⭐ Se la lista è presente e non vuota -->
        <c:if test="${not empty prodottiTop}">
            <c:forEach var="p" items="${prodottiTop}">

                <div class="col-md-4 mb-4">
                    <div class="card h-100 text-center shadow-sm">

                        <img src="${p.imageUrl}"
                             class="card-img-top"
                             alt="${p.nome}">

                        <div class="card-body">
                            <h5 class="card-title">${p.nome}</h5>
                            <p class="card-text">${p.informazioni}</p>
                            <p class="fw-bold">€ ${p.prezzo}</p>

                            <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-primary">
                                <i class="bi bi-cart"></i> Acquista
                            </a>
                        </div>

                    </div>
                </div>

            </c:forEach>
        </c:if>

        <!-- ⭐ Se la lista è vuota -->
        <c:if test="${empty prodottiTop}">
            <p class="text-center">Nessun prodotto disponibile al momento.</p>
        </c:if>

    </div>
</div>

<!-- ⭐ Footer -->
<jsp:include page="../component/footer.jsp"/>

<!-- ⭐ Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/script.js"></script>

</body>
</html>
