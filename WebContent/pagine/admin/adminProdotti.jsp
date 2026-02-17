<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Categoria" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>

<%
    // ============================================================
    // ⭐ Controllo accesso Admin
    // ============================================================
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // ============================================================
    // ⭐ Recupero dati passati dalla servlet
    // ============================================================
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Prodotti</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile personalizzato admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body class="p-4">

<div class="container">

    <!-- ============================================================
         ⭐ TITOLO + NAVIGAZIONE
         ============================================================ -->
    <h1 class="mb-4">Gestione Prodotti</h1>

    <div class="d-flex justify-content-between mb-4">

        <!-- Torna alla dashboard -->
        <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn-admin-action">
            ← Torna alla Dashboard
        </a>

        <!-- Aggiungi nuovo prodotto -->
        <a href="<%= request.getContextPath() %>/admin/prodotti?action=create" class="btn-admin-action">
            Aggiungi Prodotto
        </a>

    </div>

    <!-- ============================================================
         ⭐ MESSAGGIO SE NON CI SONO PRODOTTI
         ============================================================ -->
    <% if (prodotti == null || prodotti.isEmpty()) { %>

        <div class="alert alert-warning mt-3">Nessun prodotto disponibile.</div>

    <% } else { %>

        <!-- ============================================================
             ⭐ TABELLA PRODOTTI
             ============================================================ -->
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

                        <!-- ============================================================
                             ⭐ MODIFICA PRODOTTO
                             ============================================================ -->
                        <form action="<%= request.getContextPath() %>/admin/prodotti"
                              method="get" class="d-inline">

                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= p.getId() %>">

                            <button class="btn btn-sm btn-primary">Modifica</button>
                        </form>

                        <!-- ============================================================
                             ⭐ ELIMINA PRODOTTO
                             ============================================================ -->
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
