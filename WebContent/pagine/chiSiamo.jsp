<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Chi Siamo - Il Tempio del Digitale</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Assets -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="../component/navbar.jsp"/>

<!-- Hero Section -->
<div class="container my-5 text-center">
    <h1 class="mb-3">Chi Siamo</h1>
    <p class="lead">La nostra missione è portare innovazione digitale con passione, creatività e affidabilità.</p>   
</div>

<!-- Sezione informativa -->
<div class="container my-5">
    <div class="row g-4">
        <div class="col-md-6">
            <h3>Le nostre origini</h3>
            <p>
                La nostra storia nasce dalla convinzione che il mondo digitale offra opportunità straordinarie,
                capaci di arricchire la vita quotidiana e professionale. Abbiamo fondato il nostro e-commerce
                con l'obiettivo di creare un ponte tra innovazione tecnologica ed esigenze concrete del mercato,
                offrendo una piattaforma dove eccellenza e affidabilità si incontrano.
            </p>
            <p>
                Fin dall'inizio ci siamo specializzati nella selezione e vendita di soluzioni digitali all'avanguardia.
                Siamo partiti con entusiasmo e oggi continuiamo a crescere, guidati dalla stessa passione e dall'impegno
                costante nel fornire ai nostri clienti il meglio, sia online che offline.
            </p>
        </div>
        <div class="col-md-6">
            <h3>Perché sceglierci?</h3>
            <p>
                Il nostro team è composto da giovani esperti e appassionati di tecnologia e informatica.
                Rimaniamo costantemente aggiornati sulle innovazioni e soluzioni tecnologiche, ma ciò che ci distingue
                sono alcuni aspetti fondamentali nelle scelte che facciamo:
                Specializzati da anni nel settore digitale, dalla vendita di PC alle soluzioni tecnologiche più avanzate.
                Cerchiamo costantemente le soluzioni migliori, spesso non disponibili sul mercato tradizionale.
            </p>
            <ul class="list-group">               
                <li class="list-group-item">Servizio clienti e post-vendita sempre a disposizione, anche telefonicamente.</li>
                <li class="list-group-item">Orario flessibile (9.30-13 / 14.30-19) dal lunedì al sabato.</li>
                <li class="list-group-item">Comodità: siamo facilmente raggiungibili anche con i mezzi pubblici.</li>
            </ul>
        </div>
        <div class="col-md-6">
            <h3>I nostri valori</h3>
            <ul class="list-group">
                <li class="list-group-item"><i class="bi bi-lightbulb"></i> Innovazione continua</li>
                <li class="list-group-item"><i class="bi bi-people"></i> Collaborazione e trasparenza</li>
                <li class="list-group-item"><i class="bi bi-shield-check"></i> Affidabilità e sicurezza</li>
                <li class="list-group-item"><i class="bi bi-heart"></i> Passione per il digitale</li>
            </ul>
        </div>
    </div>
</div>

<!-- Sezione Team -->
<div class="container my-5">
    <h2 class="text-center mb-4">Il Nostro Team</h2>
    <p class="text-center text-muted">Il team di ingegneri e designer che ha reso possibile tutto questo</p>
    <div class="row justify-content-center">
        <%-- Card membro team --%>
        <div class="col-md-3 col-sm-6 mb-4">
            <div class="card h-100 text-center shadow-sm">
                <img src="<%= request.getContextPath() %>/assets/img/noi/ciro.jpg" 
                     class="card-img-top rounded-circle mx-auto mt-3" style="width:150px; height:150px; object-fit:cover;" alt="Ciro Cancello">
                <div class="card-body">
                    <h5 class="card-title">Ciro Cancello</h5>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <div class="card h-100 text-center shadow-sm">
                <img src="<%= request.getContextPath() %>/assets/img/noi/nadia.jpg" 
                     class="card-img-top rounded-circle mx-auto mt-3" style="width:150px; height:150px; object-fit:cover;" alt="Rinaldi Nadia">
                <div class="card-body">
                    <h5 class="card-title">Rinaldi Nadia</h5>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <div class="card h-100 text-center shadow-sm">
                <img src="<%= request.getContextPath() %>/assets/img/noi/giovanni.jpg" 
                     class="card-img-top rounded-circle mx-auto mt-3" style="width:150px; height:150px; object-fit:cover;" alt="Giovanni Cancello">
                <div class="card-body">
                    <h5 class="card-title">Giovanni Cancello</h5>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <div class="card h-100 text-center shadow-sm">
                <img src="<%= request.getContextPath() %>/assets/img/noi/vincenzo.jpg" 
                     class="card-img-top rounded-circle mx-auto mt-3" style="width:150px; height:150px; object-fit:cover;" alt="Vincenzo Cancello">
                <div class="card-body">
                    <h5 class="card-title">Vincenzo Cancello</h5>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <div class="card h-100 text-center shadow-sm">
                <img src="<%= request.getContextPath() %>/assets/img/noi/luca.jpg" 
                     class="card-img-top rounded-circle mx-auto mt-3" style="width:150px; height:150px; object-fit:cover;" alt="Luca Cancello">
                <div class="card-body">
                    <h5 class="card-title">Luca Cancello</h5>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Call to action -->
<div class="container text-center my-5">
    <h4>Vuoi saperne di più?</h4>
    <a href="<%= request.getContextPath() %>/pagine/contatti.jsp" class="btn btn-primary btn-lg mt-3 me-2">
        <i class="bi bi-envelope"></i> Contattaci
    </a>
    <!-- Pulsante Torna alla Home -->
    <a href="<%= request.getContextPath() %>/index" class="btn btn-secondary btn-lg mt-3">
        <i class="bi bi-house"></i> Torna alla Home
    </a>
</div>

<jsp:include page="../component/footer.jsp"/>

<!-- Bootstrap JS + Script custom -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/script.js"></script>

</body>
</html>
