// ======================================================================
// SCRIPT GENERALE DEL SITO
// ======================================================================
// Questo file contiene:
//  - Messaggi inline (UX feedback)
//  - Gestione click globali (carrello / preferiti)
//  - Validazione form generica (Bootstrap)
//  - Ricerca live nel catalogo (filtraggio client-side)
//  - Carousel personalizzato
// ======================================================================

console.log("Il Tempio del Digitale - assets caricati correttamente!");


// ======================================================================
// FUNZIONE GENERALE: mostra messaggi inline
// ======================================================================
function mostraMessaggio(testo, tipo = "success") {
  const box = document.createElement("div");
  box.className = "alert alert-" + tipo + " mt-3";
  box.textContent = testo;

  const container = document.querySelector(".container") || document.body;
  container.prepend(box);

  setTimeout(() => box.remove(), 3000);
}


// ======================================================================
// CLICK GLOBALI (carrello / preferiti)
// ======================================================================
document.addEventListener("click", function (e) {

  // Aggiunta al carrello
  const cartForm = e.target && e.target.closest("form[action$='/carrello']");

  if (cartForm) {
    const inputNome = cartForm.querySelector("input[name='nome']");
    const nomeProdotto = inputNome ? inputNome.value : "Prodotto";

    mostraMessaggio("🛒 '" + nomeProdotto + "' aggiunto al carrello!", "success");
    return;
  }

  // Aggiunta ai preferiti
  const favForm = e.target && e.target.closest("form[action$='/preferiti']");

  if (favForm) {
    const inputId = favForm.querySelector("input[name='id_prodotto']");
    const idProdotto = inputId ? inputId.value : "?";

    mostraMessaggio("❤️ Prodotto ID " + idProdotto + " aggiunto ai preferiti!", "info");
  }
});


// ======================================================================
// DOM READY
// ======================================================================
document.addEventListener("DOMContentLoaded", function () {

  // ====================================================================
  // VALIDAZIONE FORM GENERICA (Bootstrap)
  // ====================================================================
  const form = document.querySelector("form.needs-validation");

  if (form) {
    form.addEventListener("submit", function (event) {

      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
        mostraMessaggio("⚠️ Compila tutti i campi prima di inviare.", "danger");
      }

      form.classList.add("was-validated");
    });
  }


  // ====================================================================
  // RICERCA LIVE NEL CATALOGO (client-side)
  // ====================================================================
  const searchInput = document.getElementById("searchCatalogo");

  if (searchInput) {
    searchInput.addEventListener("keyup", function () {

      const filter = searchInput.value.toLowerCase();
      const cards = document.querySelectorAll(".card");

      cards.forEach(card => {
        const titleEl = card.querySelector(".card-title");
        const titolo = titleEl ? titleEl.textContent.toLowerCase() : "";

        card.style.display = titolo.includes(filter) ? "" : "none";
      });
    });
  }


  // ====================================================================
  // CAROUSEL PERSONALIZZATO
  // ====================================================================
  const items = document.querySelectorAll(".carousel-item");
  const buttons = document.querySelectorAll(".carousel-button");
  let currentItem = 0;

  function showItem(index) {
    items.forEach((item, i) => {
      item.classList.toggle("carousel-item--visible", i === index);
    });
  }

  if (items.length > 0) {

    showItem(0);

    if (buttons.length >= 2) {

      // Precedente
      buttons[0].addEventListener("click", function () {
        currentItem = currentItem === 0 ? items.length - 1 : currentItem - 1;
        showItem(currentItem);
      });

      // Successivo
      buttons[1].addEventListener("click", function () {
        currentItem = currentItem === items.length - 1 ? 0 : currentItem + 1;
        showItem(currentItem);
      });
    }

    // Auto-play
    setInterval(function () {
      currentItem = currentItem === items.length - 1 ? 0 : currentItem + 1;
      showItem(currentItem);
    }, 5000);
  }

});
