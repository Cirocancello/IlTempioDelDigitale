<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Categoria" %>
<%@ page import="java.util.List" %>

<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Prodotti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Stile personalizzato -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body class="p-4">

<div class="container">

    <h1 class="mb-4">Gestione Prodotti</h1>

    <!-- 🔙 Pulsante Torna alla Dashboard + Aggiungi Prodotto -->
    <div class="d-flex justify-content-between mb-4">

        <a href="<%= request.getContextPath() %>/pagine/adminDashboard.jsp" class="btn-admin-action">
            ← Torna alla Dashboard
        </a>

        <!-- 🔥 LINK CORRETTO PER APRIRE IL FORM DI CREAZIONE -->
        <a href="<%= request.getContextPath() %>/admin/prodotti?action=create" class="btn-admin-action">
            Aggiungi Prodotto
        </a>

    </div>


    <% if (prodotti == null || prodotti.isEmpty()) { %>

        <div class="alert alert-warning mt-3">Nessun prodotto disponibile.</div>

    <% } else { %>

        <table class="table table-striped table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Brand</th>
                    <th>Prezzo</th>
                    <th>Quantità</th>
                    <th>Categoria</th>
                    <th>Visibile</th>
                    <th>Azioni</th>
                </tr>
            </thead>

            <tbody>
            <% for (Prodotto p : prodotti) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getBrand() %></td>
                    <td>€ <%= p.getPrezzo() %></td>
                    <td><%= p.getQuantita() %></td>
                    <td><%= p.getCategoria().getNome() %></td>
                    <td><%= p.isVisibile() ? "Sì" : "No" %></td>

                    <td>

                        <!-- Modifica -->
                        <form action="<%= request.getContextPath() %>/admin/prodotti" method="get" class="d-inline">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button class="btn btn-sm btn-primary">Modifica</button>
                        </form>

                        <!-- Elimina -->
                        <form action="<%= request.getContextPath() %>/admin/prodotti"
                              method="post" class="d-inline"
                              onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button class="btn btn-sm btn-danger">Elimina</button>
                        </form>

                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

    <% } %>

</div>

</body>
</html>
