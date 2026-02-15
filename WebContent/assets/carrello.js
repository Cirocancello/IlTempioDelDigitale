// Esegui tutto il codice solo quando il DOM è completamente caricato
document.addEventListener("DOMContentLoaded", () => {

    // Recupera dinamicamente il context path dal body (es: /IlTempioDelDigitale)
    // Serve per costruire URL corretti anche se l'app cambia nome o percorso
    const base = document.body.dataset.base;

    // Funzione per mostrare messaggi temporanei all’utente (feedback UX)
    function mostraMessaggio(testo, tipo = "success") {

        // Crea un div Bootstrap dinamico
        const box = document.createElement("div");
        box.className = "alert alert-" + tipo + " mt-3";
        box.textContent = testo;

        // Inserisce il messaggio all'inizio della pagina
        const container = document.querySelector(".container") || document.body;
        container.prepend(box);

        // Rimuove il messaggio dopo 2.5 secondi
        setTimeout(() => box.remove(), 2500);
    }

    // Funzione GENERALE che invia richieste AJAX alla servlet del carrello
    // action = aggiungi / inc / dec / rimuovi
    // id = id del prodotto
    function aggiornaCarrello(action, id) {

        // Usa fetch() per inviare una POST asincrona alla servlet
        fetch(base + "/carrello-ajax", {
            method: "POST",
            headers: {
                // Indica che stiamo inviando parametri come in un form HTML
                "Content-Type": "application/x-www-form-urlencoded"
            },
            // Parametri inviati alla servlet
            body: "action=" + action + "&id=" + id
        })
        // Converte la risposta della servlet in JSON
        .then(res => res.json())
        .then(data => {

            // Se la servlet ha risposto con success = true
            if (data.success) {

                // Aggiorna il badge del carrello nella navbar
                const badge = document.getElementById("cart-count");
                if (badge) badge.textContent = data.quantita;

                // Mostra messaggi diversi in base all’azione
                if (action === "aggiungi") {
                    mostraMessaggio("🛒 Prodotto aggiunto al carrello!", "success");
                }
                if (action === "rimuovi") {
                    mostraMessaggio("❌ Prodotto rimosso dal carrello", "danger");
                }

                // Se siamo nella pagina carrello.jsp, aggiorna la UI
                if (action === "inc" || action === "dec" || action === "rimuovi") {
                    aggiornaUI(id, action);
                }
            }
        })
        // Gestione errori AJAX
        .catch(err => console.error("Errore AJAX:", err));
    }

    // Aggiunta al carrello (catalogo.jsp + prodotto.jsp)
    document.querySelectorAll(".add-cart").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id; // recupera id prodotto dal bottone
            aggiornaCarrello("aggiungi", id);
        });
    });

    // Incremento quantità (carrello.jsp)
    document.querySelectorAll(".btn-inc").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("inc", id);
        });
    });

    // Decremento quantità (carrello.jsp)
    document.querySelectorAll(".btn-dec").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("dec", id);
        });
    });

    // Rimozione prodotto (carrello.jsp)
    document.querySelectorAll(".btn-remove").forEach(btn => {
        btn.addEventListener("click", function () {
            let id = this.dataset.id;
            aggiornaCarrello("rimuovi", id);
        });
    });

    // Aggiorna dinamicamente la UI del carrello (quantità, rimozione righe, totale)
    function aggiornaUI(id, action) {

        const row = document.querySelector(`#row-${id}`); // riga del prodotto
        const qty = document.querySelector(`#qty-${id}`); // quantità del prodotto

        if (!row) return; // se la riga non esiste, esci

        // Rimozione completa del prodotto
        if (action === "rimuovi") {
            row.remove();
            aggiornaTotale();
            return;
        }

        // Incremento quantità
        if (action === "inc") {
            qty.textContent = parseInt(qty.textContent) + 1;
        }

        // Decremento quantità
        if (action === "dec") {
            let nuova = parseInt(qty.textContent) - 1;

            // Se la quantità scende a 0 → rimuovi la riga
            if (nuova <= 0) {
                row.remove();
            } else {
                qty.textContent = nuova;
            }
        }

        // Aggiorna il totale dell’ordine
        aggiornaTotale();
    }

    // Ricalcola il totale dell’ordine sommando tutte le righe
    function aggiornaTotale() {

        let totale = 0;

        // Scorre tutte le righe del carrello
        document.querySelectorAll("tr[id^='row-']").forEach(row => {

            // Legge prezzo e quantità dalla riga
            const prezzo = parseFloat(row.querySelector("td:nth-child(5)").textContent);
            const quantita = parseInt(row.querySelector("span[id^='qty-']").textContent);

            totale += prezzo * quantita;
        });

        // Aggiorna il totale nella UI
        const totaleUI = document.getElementById("totale-ordine");
        if (totaleUI) totaleUI.textContent = totale.toFixed(2);
    }

});
