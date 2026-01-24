<form action="${pageContext.request.contextPath}/admin/uploadProdotto"
      method="post"
      enctype="multipart/form-data"
      class="form-prodotto">

    <!-- Nome prodotto -->
    <label for="nome">Nome</label>
    <input type="text" id="nome" name="nome" required>

    <!-- Brand -->
    <label for="brand">Brand</label>
    <input type="text" id="brand" name="brand" required>

    <!-- Prezzo -->
    <label for="prezzo">Prezzo (€)</label>
    <input type="number" id="prezzo" name="prezzo" step="0.01" required>

    <!-- Quantità -->
    <label for="quantita">Quantità</label>
    <input type="number" id="quantita" name="quantita" min="0" required>

    <!-- Immagine -->
    <label for="immagine">Immagine prodotto</label>
    <input type="file" id="immagine" name="immagine" accept="image/*" required>

    <!-- Informazioni -->
    <label for="informazioni">Descrizione</label>
    <textarea id="informazioni" name="informazioni" rows="4"></textarea>

    <button type="submit" class="btn btn-primary">Crea prodotto</button>
</form>
