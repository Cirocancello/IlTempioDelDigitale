<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Il Tempio del Digitale - Home</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Font Awesome per le frecce del carosello -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Assets -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="component/navbar.jsp"/>

<!-- Hero Section -->
<div class="container my-5 text-center">
    <img src="<%= request.getContextPath() %>/assets/img/logo/logo.PNG" alt="Logo" class="mb-4" style="max-width:150px;">
    <h1 class="mb-3">Benvenuto al Tempio del Digitale</h1>
    <p class="lead">Scopri i nostri prodotti, i servizi e la passione che ci guida nel mondo digitale.</p>
    
    <!-- Carosello -->
    <header class="carousel-container">
        <div class="carousel">
            <div class="carousel-item carousel-item--visible">
                <img src="<%= getServletContext().getContextPath() + "/assets/img/index/carousel/andras-vas-Bd7gNnWJBkU-unsplash.jpg" %>" alt="" class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Potenza e precisione digitale</h1>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<%= getServletContext().getContextPath() + "/assets/img/index/carousel/balkouras-nicos-ncOQxZe8Krw-unsplash.jpg" %>" alt="" class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Dentro il cuore della tecnologia</h1>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<%= getServletContext().getContextPath() + "/assets/img/index/carousel/joshua-ng-1sSfrozgiFk-unsplash.jpg" %>" alt="" class="carousel-image">
                <div class="carousel-text-container">
                    <h1 class="title">Hardware e innovazione senza confini</h1>
                </div>
            </div>

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

    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-primary btn-lg me-2">
            <i class="bi bi-shop"></i> Vai al Catalogo
        </a>        
        <a href="<%= request.getContextPath() %>/pagine/chiSiamo.jsp" class="btn btn-outline-secondary btn-lg me-2">
            <i class="bi bi-people"></i> Chi Siamo
        </a>
        <a href="<%= request.getContextPath() %>/pagine/contatti.jsp" class="btn btn-outline-green btn-lg">

            <i class="bi bi-envelope"></i> Contattaci
        </a>
    </div>
</div>

<!-- Sezione evidenza -->
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

<!-- Sezione Prodotti più venduti -->
<div class="container my-5 top-products">
    <h2 class="text-center mb-4">Prodotti più venduti</h2>
    <div class="row">
        <%
            List<Prodotto> prodottiTop = (List<Prodotto>) request.getAttribute("prodottiTop");
            if (prodottiTop != null && !prodottiTop.isEmpty()) {
                for (Prodotto p : prodottiTop) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card h-100 text-center shadow-sm">
            	<img src="<%= p.getImageUrl() %>" class="card-img-top" alt="<%= p.getNome() %>">           	
              
                <div class="card-body">
                    <h5 class="card-title"><%= p.getNome() %></h5>
                    <p class="card-text"><%= p.getInformazioni() %></p>
                    <p class="fw-bold">€ <%= p.getPrezzo() %></p>
                    <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-primary">
                        <i class="bi bi-cart"></i> Acquista
                    </a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-center">Nessun prodotto disponibile al momento.</p>
        <%
            }
        %>
    </div>
</div>

<jsp:include page="component/footer.jsp"/>

<!-- Bootstrap JS + Script custom -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
