document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("campoRicerca");
    const risultati = document.getElementById("risultati");

    if (!input || !risultati) {
        console.error("Elemento di ricerca non trovato nella pagina.");
        return;
    }

    input.addEventListener("keyup", function () {
        const testo = input.value.trim();

        // Se il campo è vuoto → svuoto i risultati
        if (testo === "") {
            risultati.innerHTML = "";
            return;
        }

        fetch("RicercaProdottiServlet?q=" + encodeURIComponent(testo))
            .then(response => response.text())
            .then(html => {

                // ⭐ Manipolazione del DOM: aggiorno il contenitore dei risultati
                risultati.innerHTML = html;

                // ⭐ Aggiungo una classe per animazione (DOM manipulation)
                risultati.classList.add("fade-in");
                setTimeout(() => risultati.classList.remove("fade-in"), 200);
            })
            .catch(error => {
                console.error("Errore nella ricerca AJAX:", error);

                // ⭐ Messaggio inline in caso di errore (DOM manipulation)
                risultati.innerHTML = `
                    <div class="alert alert-danger mt-2">
                        Errore durante la ricerca. Riprova.
                    </div>
                `;
            });
    });

});
