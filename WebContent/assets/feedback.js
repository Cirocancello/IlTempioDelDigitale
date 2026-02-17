/* ============================================================
   ⭐ SCRIPT FEEDBACK (stelle + menu a tendina)
   ============================================================ */


/* ============================================================
   ⭐ SEZIONE 1 — Gestione stelle cliccabili (rating)
   ============================================================ */

const stars = document.querySelectorAll('#starRating i');
const scoreInput = document.getElementById('scoreInput');

if (stars && scoreInput) {

    stars.forEach(star => {
        star.addEventListener('click', () => {

            const value = star.getAttribute('data-value');
            scoreInput.value = value;

            // Reset grafico
            stars.forEach(s => {
                s.classList.remove('bi-star-fill');
                s.classList.add('bi-star');
            });

            // Riempio le stelle fino al valore selezionato
            for (let i = 0; i < value; i++) {
                stars[i].classList.remove('bi-star');
                stars[i].classList.add('bi-star-fill');
            }
        });
    });
}


/* ============================================================
   ⭐ SEZIONE 2 — Compilazione automatica del Titolo
   ============================================================ */

const titoloSelect = document.getElementById("titoloSelect");
const titoloInput = document.getElementById("titolo");

if (titoloSelect && titoloInput) {
    titoloSelect.addEventListener("change", function() {
        if (this.value) {
            titoloInput.value = this.value;
        }
    });
}


/* ============================================================
   ⭐ SEZIONE 3 — Compilazione automatica della Descrizione
   ============================================================ */

const descrizioneSelect = document.getElementById("descrizioneSelect");
const descrizioneInput = document.getElementById("descrizione");

if (descrizioneSelect && descrizioneInput) {
    descrizioneSelect.addEventListener("change", function() {
        if (this.value) {
            descrizioneInput.value = this.value;
        }
    });
}


/* ============================================================
   ⭐ SEZIONE 4 — Blocco invio se score non selezionato
   ============================================================ */

/**
 * 🔥 VERSIONE DEFINITIVA:
 * Trova QUALSIASI form che invia a "aggiungi-feedback",
 * indipendentemente da context path, parametri, ecc.
 */
const feedbackForm = document.querySelector('form[action]');

if (feedbackForm && feedbackForm.action.includes("aggiungi-feedback") && scoreInput) {

    feedbackForm.addEventListener("submit", function (e) {

        if (!scoreInput.value || scoreInput.value.trim() === "") {

            e.preventDefault(); // blocca invio

            alert("Per favore seleziona un punteggio cliccando sulle stelline.");

            // Effetto visivo sulle stelle
            stars.forEach(s => {
                s.style.transition = "0.2s";
                s.style.transform = "scale(1.2)";
                setTimeout(() => s.style.transform = "scale(1)", 200);
            });
        }
    });
}
