// script.js

// Messaggio di benvenuto in console
console.log("Il Tempio del Digitale - assets caricati correttamente!");

// ==========================
// Validazione form (con alert)
// ==========================
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form.needs-validation");
    if (form) {
        form.addEventListener("submit", function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                alert("⚠️ Compila tutti i campi prima di inviare.");
            }
            form.classList.add("was-validated");
        }, false);
    }

    // Ripristino Dark Mode da localStorage
    if (localStorage.getItem("darkMode") === "enabled") {
        enableDarkMode();
    }
});

// ==========================
// Funzioni Dark Mode
// ==========================
function enableDarkMode() {
    document.body.classList.add("dark-mode");
    localStorage.setItem("darkMode", "enabled");
}

function disableDarkMode() {
    document.body.classList.remove("dark-mode");
    localStorage.setItem("darkMode", "disabled");
}

function toggleDarkMode() {
    if (document.body.classList.contains("dark-mode")) {
        disableDarkMode();
    } else {
        enableDarkMode();
    }
}

// ==========================
// Gestione Carrello (demo)
// ==========================
document.addEventListener("click", function (e) {
    if (e.target && e.target.closest("form[action$='/carrello']")) {
        const form = e.target.closest("form");
        const nomeProdotto = form.querySelector("input[name='nome']").value;
        alert("🛒 '" + nomeProdotto + "' aggiunto al carrello!");
    }
});

// ==========================
// Gestione Preferiti (demo)
// ==========================
document.addEventListener("click", function (e) {
    if (e.target && e.target.closest("form[action$='/preferiti']")) {
        const form = e.target.closest("form");
        const idProdotto = form.querySelector("input[name='id_prodotto']").value;
        alert("❤️ Prodotto ID " + idProdotto + " aggiunto ai preferiti!");
    }
});

// ==========================
// Ricerca Live nel Catalogo
// ==========================
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("searchCatalogo");
    if (searchInput) {
        searchInput.addEventListener("keyup", function () {
            const filter = searchInput.value.toLowerCase();
            const cards = document.querySelectorAll(".card");
            cards.forEach(card => {
                const titolo = card.querySelector(".card-title").textContent.toLowerCase();
                card.style.display = titolo.includes(filter) ? "" : "none";
            });
        });
    }
});

// ==========================
// Carousel custom
// ==========================
const items = document.querySelectorAll('.carousel-item');
const buttons = document.querySelectorAll('.carousel-button');
let currentItem = 0;

function showItem(index) {
    items.forEach((item, i) => {
        item.classList.remove('carousel-item--visible');
        if (i === index) {
            item.classList.add('carousel-item--visible');
        }
    });
}

if (buttons.length >= 2) {
    buttons[0].addEventListener('click', () => {
        currentItem = (currentItem === 0) ? items.length - 1 : currentItem - 1;
        showItem(currentItem);
    });

    buttons[1].addEventListener('click', () => {
        currentItem = (currentItem === items.length - 1) ? 0 : currentItem + 1;
        showItem(currentItem);
    });
}

// Avvio automatico ogni 5 secondi
setInterval(() => {
    currentItem = (currentItem === items.length - 1) ? 0 : currentItem + 1;
    showItem(currentItem);
}, 5000);
