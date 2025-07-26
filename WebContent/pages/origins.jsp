<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <link rel="stylesheet" href="<%= getServletContext().getContextPath() +
    "/assets/css/our_story.css"%>"> <%@ include file="../components/navbar.jsp"
    %>
    <title>Origins</title>
  </head>
  <body>
    <div class="contenitore">
      <h3>Tutto quello che c'&egrave; da sapere su Il Tempio Del Digitale</h3>
      <p class="paragraph">        
        <h4>Le Nostre Origini: Passione per il Digitale, Concretezza nel Reale</b></h4>
        La nostra storia nasce dalla ferma convinzione che il mondo digitale offra opportunità straordinarie, 
        capaci di arricchire la vita quotidiana e professionale di ognuno di noi. 
        Abbiamo fondato il nostro e-commerce con l'obiettivo ambizioso di creare un ponte tra l'innovazione tecnologica
        e le esigenze concrete del mercato, offrendo una piattaforma dove l'eccellenza dei prodotti digitali si sposa con 
        la praticità e l'affidabilità.

        Fin dall'inizio, ci siamo specializzati nella selezione e nella vendita di soluzioni digitali all'avanguardia: 
        
        Siamo partiti con l'entusiasmo di chi crede nel potere del digitale di trasformare e migliorare, e oggi continuiamo a crescere, 
        guidati dalla stessa passione e dall'impegno costante nel fornire ai nostri clienti il meglio, sia online che offline.
      </p>
      <img height="300" width="550" src="<%=
      getServletContext().getContextPath() + "/assets/img/assistenza.jpg"%>">
    </div>
  </body>
  <%@ include file="../components/footer.jsp" %>
</html>
