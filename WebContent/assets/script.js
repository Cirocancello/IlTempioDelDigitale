// assets/script.js
console.log("Il Tempio del Digitale - assets caricati correttamente!");

// ==========================
// FUNZIONE GENERALE: mostra messaggi inline
// ==========================
function mostraMessaggio(testo, tipo = "success") {
  var box = document.createElement("div");
  box.className = "alert alert-" + tipo + " mt-3";
  box.textContent = testo;

  // Inserisco il messaggio in cima alla pagina
  var container = document.querySelector(".container") || document.body;
  container.prepend(box);

  // Rimuovo dopo 3 secondi
  setTimeout(() => box.remove(), 3000);
}

// ==========================
// CLICK GLOBALI (carrello / preferiti)
// ==========================
document.addEventListener("click", function (e) {
  // Carrello
  var cartForm = e.target && e.target.closest
    ? e.target.closest("form[action$='/carrello']")
    : null;

  if (cartForm) {
    var inputNome = cartForm.querySelector("input[name='nome']");
    var nomeProdotto = inputNome ? inputNome.value : "Prodotto";

    mostraMessaggio("🛒 '" + nomeProdotto + "' aggiunto al carrello!", "success");
    return;
  }

  // Preferiti
  var favForm = e.target && e.target.closest
    ? e.target.closest("form[action$='/preferiti']")
    : null;

  if (favForm) {
    var inputId = favForm.querySelector("input[name='id_prodotto']");
    var idProdotto = inputId ? inputId.value : "?";

    mostraMessaggio("❤️ Prodotto ID " + idProdotto + " aggiunto ai preferiti!", "info");
  }
});

// ==========================
// DOM READY
// ==========================
document.addEventListener("DOMContentLoaded", function () {

  // --------------------------
  // Validazione form (DOM manipulation)
  // --------------------------
  var form = document.querySelector("form.needs-validation");
  if (form) {
    form.addEventListener(
      "submit",
      function (event) {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();

          mostraMessaggio("⚠️ Compila tutti i campi prima di inviare.", "danger");
        }
        form.classList.add("was-validated");
      },
      false
    );
  }

  // --------------------------
  // Ricerca Live nel Catalogo
  // --------------------------
  var searchInput = document.getElementById("searchCatalogo");
  if (searchInput) {
    searchInput.addEventListener("keyup", function () {
      var filter = (searchInput.value || "").toLowerCase();
      var cards = document.querySelectorAll(".card");

      for (var i = 0; i < cards.length; i++) {
        var titleEl = cards[i].querySelector(".card-title");
        var titolo = titleEl ? (titleEl.textContent || "").toLowerCase() : "";
        cards[i].style.display = titolo.indexOf(filter) !== -1 ? "" : "none";
      }
    });
  }

  // --------------------------
  // Carousel custom
  // --------------------------
  var items = document.querySelectorAll(".carousel-item");
  var buttons = document.querySelectorAll(".carousel-button");
  var currentItem = 0;

  function showItem(index) {
    for (var i = 0; i < items.length; i++) {
      if (i === index) items[i].classList.add("carousel-item--visible");
      else items[i].classList.remove("carousel-item--visible");
    }
  }

  if (items && items.length > 0) {
    showItem(0);

    if (buttons && buttons.length >= 2) {
      buttons[0].addEventListener("click", function () {
        currentItem = currentItem === 0 ? items.length - 1 : currentItem - 1;
        showItem(currentItem);
      });

      buttons[1].addEventListener("click", function () {
        currentItem = currentItem === items.length - 1 ? 0 : currentItem + 1;
        showItem(currentItem);
      });
    }

    setInterval(function () {
      currentItem = currentItem === items.length - 1 ? 0 : currentItem + 1;
      showItem(currentItem);
    }, 5000);
  }
});
