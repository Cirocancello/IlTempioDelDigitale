<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Feedback" %>
<%@ page import="java.util.*" %>

<%
    /**
     * ⭐ Recupero dei feedback dalla request
     * -------------------------------------
     * La servlet che apre questa pagina imposta "feedbacks"
     * come attributo request. Qui lo recupero per mostrarlo.
     */
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Feedback degli utenti</title>

    <!-- ⭐ Bootstrap per layout responsive -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ⭐ Icone Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Foglio di stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<body>

<div class="container my-5">

    <!-- ⭐ Titolo pagina -->
    <h2 class="mb-4">
        <i class="bi bi-chat-left-text"></i> Feedback degli utenti
    </h2>

    <% 
        /**
         * ⭐ Caso 1: Nessun feedback presente
         * ----------------------------------
         * Se la lista è vuota o nulla, mostro un messaggio informativo.
         */
        if (feedbacks == null || feedbacks.isEmpty()) { 
    %>

        <div class="feedback-empty">
            Nessun feedback disponibile.
        </div>

    <% 
        } else { 
            /**
             * ⭐ Caso 2: Feedback presenti
             * ---------------------------
             * Ciclo la lista e mostro ogni feedback con:
             * - avatar (prima lettera del titolo)
             * - titolo
             * - stelle
             * - descrizione
             * - data
             */
            for (Feedback f : feedbacks) { 

                // Gestione titolo vuoto → "Anonimo"
                String titolo = f.getTitolo();
                if (titolo == null || titolo.isBlank()) titolo = "Anonimo";

                // Avatar = iniziale del titolo
                String iniziale = titolo.substring(0,1).toUpperCase();
    %>

        <!-- ⭐ Singolo feedback -->
        <div class="feedback-item">

            <!-- Avatar circolare -->
            <div class="feedback-avatar"><%= iniziale %></div>

            <!-- Contenuto del feedback -->
            <div class="feedback-content">

                <!-- Titolo -->
                <h5 class="feedback-title"><%= titolo %></h5>

                <!-- ⭐ Stelle del punteggio -->
                <div class="feedback-stars mb-2">
                    <% 
                        for (int i = 1; i <= 5; i++) { 
                            if (i <= f.getScore()) { 
                    %>
                                <i class="bi bi-star-fill"></i>
                    <% 
                            } else { 
                    %>
                                <i class="bi bi-star"></i>
                    <% 
                            }
                        } 
                    %>
                </div>

                <!-- Descrizione -->
                <p class="mb-2"><%= f.getDescrizione() %></p>

                <!-- Data -->
                <small class="text-muted">Data: <%= f.getData() %></small>

            </div>

        </div>

    <% 
            } // fine ciclo for
        } // fine else
    %>

    <!-- ⭐ Pulsante per tornare al catalogo -->
    <a href="<%= request.getContextPath() %>/catalogo" class="btn btn-secondary mt-4">
        <i class="bi bi-arrow-left"></i> Torna al catalogo
    </a>

</div>

</body>
</html>
