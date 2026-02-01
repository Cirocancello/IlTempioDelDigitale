document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("campoRicerca");
    const risultati = document.getElementById("risultati");

    if (!input || !risultati) {
        console.error("Elemento di ricerca non trovato nella pagina.");
        return;
    }

    input.addEventListener("keyup", function () {
        const testo = input.value.trim();

        // Se il campo è vuoto, svuoto i risultati
        if (testo === "") {
            risultati.innerHTML = "";
            return;
        }

        fetch("RicercaProdottiServlet?q=" + encodeURIComponent(testo))
            .then(response => response.text())
            .then(html => {
                risultati.innerHTML = html;
            })
            .catch(error => {
                console.error("Errore nella ricerca AJAX:", error);
            });
    });

});
