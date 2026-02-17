<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Prodotto, model.Categoria" %>

<%
    /**
     * ⭐ Recupero dati passati dalla CatalogoServlet
     * ------------------------------------------------
     * - prodotti: lista dei prodotti filtrati (per categoria o ricerca)
     * - categorie: lista delle categorie disponibili
     * - categoriaSelezionata: ID della categoria scelta dall’utente
     * - query: testo inserito nella barra di ricerca
     */
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");

    String categoriaSelezionata = request.getParameter("categoria");
    String query = request.getParameter("q");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Catalogo Prodotti</title>

    <!-- ⭐ Bootstrap + Icone -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- ⭐ Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>

<!-- ⭐ data-base: fondamentale per il JS del carrello -->
<body data-base="<%= request.getContextPath() %>">

<!-- ⭐ Navbar riutilizzabile -->
<jsp:include page="/component/navbar.jsp"/>

<div class="container mt-5">

    <!-- ⭐ Titolo pagina -->
    <h2 class="mb-4"><i class="bi bi-shop"></i> Catalogo</h2>

    <!-- ⭐ Pulsante Home -->
    <a href="<%= request.getContextPath() %>/" class="btn btn-secondary mb-4">
        <i class="bi bi-house"></i> Torna alla Home
    </a>

    <!-- ⭐⭐⭐ RICERCA NORMALE (NON AJAX) -->
    <form method="get" action="<%= request.getContextPath() %>/catalogo" class="mb-4">
        <label class="form-label fw-bold">Cerca prodotto</label>
        <input type="text" name="q" class="form-control w-50"
               placeholder="Cerca per nome..."
               value="<%= (query != null ? query : "") %>">
    </form>

    <!-- ⭐⭐⭐ FILTRO PER CATEGORIA -->
    <form method="get" action="<%= request.getContextPath() %>/catalogo" class="mb-4">

        <label class="form-label fw-bold">Filtra per categoria</label>

        <select name="categoria" class="form-select w-auto d-inline-block" onchange="this.form.submit()">
            <option value="">Tutte le categorie</option>

            <% 
                if (categorie != null) {
                    for (Categoria c : categorie) { 
            %>

                <!-- ⭐ Seleziona automaticamente la categoria scelta -->
                <option value="<%= c.getId() %>"
                    <%= (categoriaSelezionata != null && categoriaSelezionata.equals(String.valueOf(c.getId()))) 
                        ? "selected" : "" %>>
                    <%= c.getNome() %>
                </option>

            <% 
                    }
                } 
            %>
        </select>

    </form>

    <!-- ⭐⭐⭐ LISTA PRODOTTI -->
    <div id="listaProdotti">

    <% if (prodotti == null || prodotti.isEmpty()) { %>

        <!-- ⭐ Nessun prodotto trovato -->
        <div class="alert alert-info">Nessun prodotto trovato.</div>

    <% } else { %>

        <div class="row">

            <% for (Prodotto p : prodotti) { %>

                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">

                        <!-- ⭐ Immagine prodotto -->
                        <img src="<%= request.getContextPath() %>/<%= p.getImageUrl() %>"
                             class="card-img-top" alt="<%= p.getNome() %>">

                        <!-- ⭐ Corpo card -->
                        <div class="card-body d-flex flex-column justify-content-between" style="min-height: 220px;">

                            <!-- ⭐ Nome + prezzo -->
                            <div>
                                <h5 class="card-title"><%= p.getNome() %></h5>
                                <p class="card-text text-success">
                                    € <%= String.format("%.2f", p.getPrezzo()) %>
                                </p>
                            </div>

                            <!-- ⭐ Pulsanti azione -->
                            <div>

                                <!-- ⭐ Vedi dettagli -->
                                <a href="<%= request.getContextPath() %>/prodotto?id=<%= p.getId() %>"
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-eye"></i> Vedi dettagli
                                </a>

                                <!-- ⭐ Aggiungi al carrello (AJAX) -->
                                <button class="btn btn-primary ms-2 add-cart" data-id="<%= p.getId() %>">
                                    <i class="bi bi-cart-plus"></i> Aggiungi
                                </button>

                                <!-- ⭐ Aggiungi ai preferiti -->
                                <form method="post" action="<%= request.getContextPath() %>/preferiti" class="d-inline">
                                    <input type="hidden" name="id_prodotto" value="<%= p.getId() %>">
                                    <button type="submit" class="btn btn-outline-danger ms-2">
                                        <i class="bi bi-heart"></i>
                                    </button>
                                </form>

                            </div>

                        </div>
                    </div>
                </div>

            <% } %>

        </div>

    <% } %>

    </div>

</div>

<!-- ⭐ Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- ⭐ Script AJAX carrello -->
<script src="<%= request.getContextPath() %>/assets/carrello.js"></script>

</body>
</html>
