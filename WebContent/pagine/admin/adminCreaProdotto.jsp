<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Categoria" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>

<%
    // ============================================================
    // ⭐ CONTROLLO ACCESSO ADMIN
    // La pagina è accessibile solo se:
    //   - esiste una sessione
    //   - esiste un utente in sessione
    //   - il ruolo dell’utente è 1 (admin)
    // Questo protegge l’area riservata.
    // ============================================================
    Utente admin = (Utente) session.getAttribute("utente");
    if (admin == null || admin.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // ============================================================
    // ⭐ Recupero lista categorie passata dalla servlet
    // Serve per popolare il menu a tendina
    // ============================================================
    List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Crea Nuovo Prodotto</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Stile personalizzato admin -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/admin.css">
</head>

<body class="p-4">

<div class="container">

    <!-- ⭐ Titolo pagina -->
    <h1 class="mb-4">Crea Nuovo Prodotto</h1>

    <!-- ⭐ Pulsante ritorno alla Dashboard -->
    <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn-back-dashboard mb-4">
        ← Torna alla Dashboard
    </a>

    <% if (categorie == null || categorie.isEmpty()) { %>

        <!-- ⭐ Messaggio se non esistono categorie -->
        <div class="alert alert-warning">
            Nessuna categoria disponibile. Creane una prima di aggiungere prodotti.
        </div>

        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">
            Torna alla Gestione Prodotti
        </a>

    </div>
</body>
</html>

<% return; } %>

    <!-- ============================================================
         ⭐ FORM CREAZIONE PRODOTTO
         Invia i dati alla servlet UploadProdottoServlet.
         enctype="multipart/form-data" è obbligatorio per l’upload file.
         ============================================================ -->
    <form id="formAdminProdotto"
          action="<%= request.getContextPath() %>/admin/uploadProdotto"
          method="post"
          enctype="multipart/form-data"
          novalidate>

        <!-- ⭐ Indica alla servlet che questa è un’operazione CREATE -->
        <input type="hidden" name="action" value="create">

        <!-- ⭐ Nome prodotto -->
        <div class="mb-3">
            <label class="form-label">Nome</label>
            <input type="text" name="nome" class="form-control" required>
        </div>

        <!-- ⭐ Brand -->
        <div class="mb-3">
            <label class="form-label">Brand</label>
            <input type="text" name="brand" class="form-control" required>
        </div>

        <!-- ⭐ Informazioni / descrizione -->
        <div class="mb-3">
            <label class="form-label">Informazioni</label>
            <textarea name="informazioni" class="form-control" rows="3" required></textarea>
        </div>

        <!-- ⭐ Prezzo -->
        <div class="mb-3">
            <label class="form-label">Prezzo</label>
            <input type="number" step="0.01" name="prezzo" class="form-control" required>
        </div>

        <!-- ⭐ Quantità -->
        <div class="mb-3">
            <label class="form-label">Quantità</label>
            <input type="number" name="quantita" class="form-control" required>
        </div>

        <!-- ============================================================
             ⭐ UPLOAD IMMAGINE
             accept="image/*" limita la selezione a file immagine.
             L’immagine verrà validata e salvata dalla servlet.
             ============================================================ -->
        <div class="mb-3">
            <label class="form-label">Immagine Prodotto</label>
            <input type="file" id="immagine" name="immagine" class="form-control" accept="image/*" required>

            <!-- ⭐ Anteprima immagine (gestita da JS) -->
            <img id="preview" src="" style="max-width: 200px; margin-top: 10px; display: none;">
        </div>

        <!-- ⭐ Visibilità prodotto -->
        <div class="mb-3">
            <label class="form-label">Visibile</label>
            <select name="visibile" class="form-select">
                <option value="true">Sì</option>
                <option value="false">No</option>
            </select>
        </div>

        <!-- ⭐ Selezione categoria -->
        <div class="mb-3">
            <label class="form-label">Categoria</label>
            <select name="categoriaId" class="form-select" required>
                <% for (Categoria c : categorie) { %>
                    <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                <% } %>
            </select>
        </div>

        <!-- ⭐ Pulsanti -->
        <button class="btn btn-dark mt-3">Crea Prodotto</button>
        <a href="<%= request.getContextPath() %>/admin/prodotti" class="btn btn-secondary mt-3">Annulla</a>

    </form>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Script validazione lato client -->
<script src="<%= request.getContextPath() %>/assets/validazione.js"></script>

</body>
</html>
