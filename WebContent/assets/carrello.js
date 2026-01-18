document.addEventListener("DOMContentLoaded", () => {

    // Recupera dinamicamente il context path dal body
    const base = document.body.dataset.base;

    // 🟦 FUNZIONE GENERALE PER INVIARE RICHIESTE AJAX AL CARRELLO
    function aggiornaCarrello(action, id) {

        fetch(base + "/carrello-ajax", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "action=" + action + "&id=" + id
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {

                // Aggiorna il badge nella navbar
                const badge = document.getElementById("cart-count");
                if (badge) badge.textContent = data.quantita;

                // Aggiorna UI del carrello (solo in carrello.jsp)
                if (action === "inc" || action === "dec" || action === "rimuovi") {
                    aggiornaUI(id, action);
                }
            }
        })
        .catch(err => console.error("Errore AJAX:", err));
    }

    // 🟦 AGGIUNTA AL CARRELLO (catalogo.jsp + prodotto.jsp)
    document.querySelectorAll(".add-cart").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("aggiungi", id);
        });
    });

    // 🟦 INCREMENTO QUANTITÀ (carrello.jsp)
    document.querySelectorAll(".btn-inc").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("inc", id);
        });
    });

    // 🟦 DECREMENTO QUANTITÀ (carrello.jsp)
    document.querySelectorAll(".btn-dec").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("dec", id);
        });
    });

    // 🟦 RIMOZIONE PRODOTTO (carrello.jsp)
    document.querySelectorAll(".btn-remove").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("rimuovi", id);
        });
    });

    // 🟦 FUNZIONE PER AGGIORNARE LA UI DEL CARRELLO
    function aggiornaUI(id, action) {

        const row = document.querySelector(`#row-${id}`);
        const qty = document.querySelector(`#qty-${id}`);

        if (!row) return;

        if (action === "rimuovi") {
            row.remove();
            aggiornaTotale();
            return;
        }

        if (action === "inc") {
            qty.textContent = parseInt(qty.textContent) + 1;
        }

        if (action === "dec") {
            let nuova = parseInt(qty.textContent) - 1;
            if (nuova <= 0) {
                row.remove();
            } else {
                qty.textContent = nuova;
            }
        }

        aggiornaTotale(); // ⭐ AGGIORNA IL TOTALE DOPO OGNI AZIONE
    }

    // 🟦 FUNZIONE PER RICALCOLARE IL TOTALE DELL'ORDINE
    function aggiornaTotale() {

        let totale = 0;

        document.querySelectorAll("tr[id^='row-']").forEach(row => {
            const prezzo = parseFloat(row.querySelector("td:nth-child(5)").textContent);
            const quantita = parseInt(row.querySelector("span[id^='qty-']").textContent);
            totale += prezzo * quantita;
        });

        const totaleUI = document.getElementById("totale-ordine");
        if (totaleUI) totaleUI.textContent = totale.toFixed(2);
    }

});
