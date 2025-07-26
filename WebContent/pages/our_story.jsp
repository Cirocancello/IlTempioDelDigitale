<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <link rel="stylesheet" href="<%= getServletContext().getContextPath() + "/assets/css/global.css"%>">
	<link rel="stylesheet" href="<%= getServletContext().getContextPath() + "/assets/css/our_story.css"%>">
    <%@ include file="../components/navbar.jsp" %>
    <title>Our story</title>
  </head>
  <body>
  <div class="contenitore">
    <h3>Chi siamo</h3>
    <p class="paragraph">
      Il nostro Team &egrave; formato da professionisti giovani e intraprendenti, costantemente
      orientati all' innovazione e attenti ai cambiamenti del settore tecnologico.<br/>
      Grazie a un mix di competenze tecniche e passione per il mondo digitale, abbiamo conosciuto
      una rapida crescita, diventando un punto di riferimento per clienti privati e aziende, sia a Napoli
      che su tutto il territorio nazionale.<br />
    </p>
    <h3>Perch&egrave; dovresti sceglierci?</h3>
    <p class="paragraph">
      Il nostro Team &egrave; composto da giovani esperti e appassionati di tecnologia e informatica.<br/>
      Rimaniamo costantementi aggiornati sulla continue e molteplici innovazioni e
      soluzioni ed evoluzioni tecnologiche ma ciò che ci distingue sono anche alcuni aspetti fondamentali nelle
      scelte che facciamo:
    </p>
    <ul>
      <li class="paragraph">
        Siamo specializzati da anni nel settore del Digitale, sia per la
        vendita di PC, che per tutto ciò che riguarda la tecnologia
      </li>  
     
      <li class="paragraph">
        Cerchiamo costantemente le soluzione migliori, che generalmente il
        mercato non offre.
      </li>
      
      <li class="paragraph">
        Servizio Clienti / Post Vendita sempre a vostra disposizione anche
        telefonicamente.
      </li>
      <li class="paragraph">Orario flessibile ( 9.30-13 / 14.30-19 ). Dal Lunedi al Sabato.</li>
      <li class="paragraph">
        Comodit&agrave; ( Siamo raggiungibili facilmente anche con i mezzi
        pubblici ).
      </li>
    </ul>
  </div>  
  </body>
   <%@ include file="../components/footer.jsp" %>
</html>
