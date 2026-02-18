// ======================================================================
// VALIDAZIONE FORM — SCRIPT UNICO PER TUTTO IL SITO
// ======================================================================
// Questo file gestisce la validazione lato client di:
// - Login utente
// - Registrazione
// - Checkout
// - Login Admin
// - CRUD Admin (Utenti, Categorie, Prodotti)
// 
// La validazione lato client migliora l’esperienza utente (UX) e riduce
// gli errori prima dell’invio al server, ma NON sostituisce la validazione
// lato server, che rimane obbligatoria.
// ======================================================================
// 1) Regex del nome
// const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
// Cosa significa?
// Questa regex accetta:
// lettere A–Z e a–z
// lettere accentate (à è ì ò ù, ecc.)
// spazi
// apostrofi (per nomi tipo D'Angelo)
// Spiegazione pezzo per pezzo
// Parte	             Significato
// ^	                 inizio stringa
// [A-Za-zÀ-ÖØ-öø-ÿ\s']	 caratteri ammessi: lettere, lettere accentate, spazi, apostrofo
// {2,30}	             lunghezza minima 2, massima 30
// $	                 fine stringa
//==========================================================================
// 2) Regex dell’email
// const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
// Cosa significa?
// È una regex semplice che controlla che l’email abbia la forma:
// qualcosa@qualcosa.qualcosa
// Spiegazione pezzo per pezzo
// Parte	Significato
// ^	    inizio stringa
// [^\s@]+	uno o più caratteri che NON siano spazi o @
// @	    deve esserci una chiocciola
// [^\s@]+	parte dopo la @ (dominio)
// \.	    un punto letterale
// [^\s@]+	estensione (com, it, org, ecc.)
// $	    fine stringa
//============================================================================
// 3) Regex della password
// const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;
// Cosa significa?
// La password deve:
// contenere almeno una lettera
// contenere almeno un numero
// essere lunga almeno 6 caratteri
// Spiegazione pezzo per pezzo
// Parte	        Significato
// ^	            inizio stringa
// (?=.*[A-Za-z])	deve contenere almeno una lettera
// (?=.*\d)	        deve contenere almeno una cifra
// .{6,}	        almeno 6 caratteri di qualsiasi tipo
// $	            fine stringa


document.addEventListener("DOMContentLoaded", () => {

    console.log("✅ Script validazione caricato correttamente");

    // ==================================================================
    // FUNZIONI GLOBALI DI SUPPORTO
    // ==================================================================

    /**
     * Mostra un messaggio di errore in cima al form.
     * Se il box non esiste, lo crea.
     */
    function mostraErroreForm(form, testo) {
        let box = form.querySelector(".errore-form");

        if (!box) {
            box = document.createElement("div");
            box.className = "alert alert-danger errore-form mt-2";
            form.prepend(box);
        }

        box.textContent = testo;

        // Rimuove automaticamente il messaggio dopo 4 secondi
        setTimeout(() => box.remove(), 4000);
    }

    /**
     * Evidenzia un campo come non valido e mostra un messaggio nel form.
     */
    function invalidaCampo(campo, form, messaggio) {
        campo.classList.add("is-invalid");
        mostraErroreForm(form, messaggio);
    }

    /**
     * Ripulisce tutti gli errori visivi dal form.
     */
    function pulisciErrori(form) {
        form.querySelectorAll(".is-invalid").forEach(el => el.classList.remove("is-invalid"));
    }

    // ==================================================================
    // VALIDAZIONE LOGIN UTENTE
    // ==================================================================
    const formLogin = document.getElementById("formLogin");

    if (formLogin) {
        formLogin.addEventListener("submit", function(e) {

            pulisciErrori(formLogin);

            const email = document.getElementById("email");
            const password = document.getElementById("password");

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

            if (!emailRegex.test(email.value.trim())) {
                e.preventDefault();
                invalidaCampo(email, formLogin, "Inserisci un'email valida.");
                return;
            }

            if (!passwordRegex.test(password.value.trim())) {
                e.preventDefault();
                invalidaCampo(password, formLogin, "La password deve contenere almeno 6 caratteri, con lettere e numeri.");
                return;
            }
        });
    }

    // ==================================================================
    // VALIDAZIONE REGISTRAZIONE UTENTE
    // ==================================================================
    const formRegistrazione = document.getElementById("formRegistrazione");

    if (formRegistrazione) {
        formRegistrazione.addEventListener("submit", function(e) {

            pulisciErrori(formRegistrazione);

            const nome = document.getElementById("nome");
            const cognome = document.getElementById("cognome");
            const email = document.getElementById("email");
            const password = document.getElementById("password");
            const conferma = document.getElementById("conferma");

            const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

            if (!nomeRegex.test(nome.value.trim())) {
                e.preventDefault();
                invalidaCampo(nome, formRegistrazione, "Il nome deve contenere solo lettere.");
                return;
            }

            if (!nomeRegex.test(cognome.value.trim())) {
                e.preventDefault();
                invalidaCampo(cognome, formRegistrazione, "Il cognome deve contenere solo lettere.");
                return;
            }

            if (!emailRegex.test(email.value.trim())) {
                e.preventDefault();
                invalidaCampo(email, formRegistrazione, "Inserisci un'email valida.");
                return;
            }

            if (!passwordRegex.test(password.value.trim())) {
                e.preventDefault();
                invalidaCampo(password, formRegistrazione, "La password deve contenere almeno 6 caratteri, con lettere e numeri.");
                return;
            }

            if (password.value.trim() !== conferma.value.trim()) {
                e.preventDefault();
                invalidaCampo(conferma, formRegistrazione, "Le password non coincidono.");
                return;
            }
        });
    }

    // ==================================================================
    // VALIDAZIONE CHECKOUT
    // ==================================================================
    const formCheckout = document.getElementById("formCheckout");

    if (formCheckout) {
        formCheckout.addEventListener("submit", function(e) {

            pulisciErrori(formCheckout);

            const indirizzo = document.getElementById("indirizzoSpedizione");
            const metodo = document.getElementById("metodoPagamento");

            const indirizzoRegex = /^.{5,}$/;

            if (!indirizzoRegex.test(indirizzo.value.trim())) {
                e.preventDefault();
                invalidaCampo(indirizzo, formCheckout, "Inserisci un indirizzo valido (minimo 5 caratteri).");
                return;
            }

            if (metodo.value.trim() === "") {
                e.preventDefault();
                invalidaCampo(metodo, formCheckout, "Seleziona un metodo di pagamento.");
                return;
            }
        });
    }

    // ==================================================================
    // VALIDAZIONE LOGIN ADMIN
    // ==================================================================
    const formAdminLogin = document.getElementById("formAdminLogin");

    if (formAdminLogin) {
        formAdminLogin.addEventListener("submit", function(e) {

            pulisciErrori(formAdminLogin);

            const email = formAdminLogin.querySelector("input[name='email']");
            const password = formAdminLogin.querySelector("input[name='password']");

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const passwordRegex = /^[A-Za-z0-9]{3,}$/;

            if (!emailRegex.test(email.value.trim())) {
                e.preventDefault();
                invalidaCampo(email, formAdminLogin, "Inserisci un'email valida.");
                return;
            }

            if (!passwordRegex.test(password.value.trim())) {
                e.preventDefault();
                invalidaCampo(password, formAdminLogin, "La password deve contenere almeno 3 caratteri alfanumerici.");
                return;
            }
        });
    }

    // ==================================================================
    // VALIDAZIONE ADMIN — CREAZIONE / MODIFICA UTENTE
    // ==================================================================
    const formAdminUtente = document.getElementById("formAdminUtente");

    if (formAdminUtente) {
        formAdminUtente.addEventListener("submit", function(e) {

            pulisciErrori(formAdminUtente);

            const nome = formAdminUtente.querySelector("input[name='nome']");
            const cognome = formAdminUtente.querySelector("input[name='cognome']");
            const email = formAdminUtente.querySelector("input[name='email']");
            const password = formAdminUtente.querySelector("input[name='password']");
            const ruolo = formAdminUtente.querySelector("select[name='role']");

            const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

            if (!nomeRegex.test(nome.value.trim())) {
                e.preventDefault();
                invalidaCampo(nome, formAdminUtente, "Il nome deve contenere solo lettere.");
                return;
            }

            if (!nomeRegex.test(cognome.value.trim())) {
                e.preventDefault();
                invalidaCampo(cognome, formAdminUtente, "Il cognome deve contenere solo lettere.");
                return;
            }

            if (!emailRegex.test(email.value.trim())) {
                e.preventDefault();
                invalidaCampo(email, formAdminUtente, "Inserisci un'email valida.");
                return;
            }

            if (!passwordRegex.test(password.value.trim())) {
                e.preventDefault();
                invalidaCampo(password, formAdminUtente, "La password deve contenere almeno 6 caratteri, con lettere e numeri.");
                return;
            }

            if (ruolo.value !== "0" && ruolo.value !== "1") {
                e.preventDefault();
                invalidaCampo(ruolo, formAdminUtente, "Seleziona un ruolo valido.");
                return;
            }
        });
    }

    // ==================================================================
    // VALIDAZIONE ADMIN — CATEGORIA (CREA / MODIFICA)
    // ==================================================================
    const formAdminCategoria = document.getElementById("formAdminCategoria");
    const formAdminModificaCategoria = document.getElementById("formAdminModificaCategoria");

    function validaCategoria(form, e) {
        pulisciErrori(form);
        const nome = form.querySelector("input[name='nome']");

        if (nome.value.trim().length < 3) {
            e.preventDefault();
            invalidaCampo(nome, form, "Il nome della categoria deve contenere almeno 3 caratteri.");
        }
    }

    if (formAdminCategoria) {
        formAdminCategoria.addEventListener("submit", function(e) {
            validaCategoria(formAdminCategoria, e);
        });
    }

    if (formAdminModificaCategoria) {
        formAdminModificaCategoria.addEventListener("submit", function(e) {
            validaCategoria(formAdminModificaCategoria, e);
        });
    }

    // ==================================================================
    // VALIDAZIONE ADMIN — PRODOTTO (CREA / MODIFICA)
    // ==================================================================
    const formAdminProdotto = document.getElementById("formAdminProdotto");
    const formAdminModificaProdotto = document.getElementById("formAdminModificaProdotto");

    function validaProdotto(form, e) {

        pulisciErrori(form);

        const nome = form.querySelector("input[name='nome']");
        const brand = form.querySelector("input[name='brand']");
        const info = form.querySelector("textarea[name='informazioni']");
        const prezzo = form.querySelector("input[name='prezzo']");
        const quantita = form.querySelector("input[name='quantita']");

        if (nome.value.trim().length < 3) {
            e.preventDefault();
            invalidaCampo(nome, form, "Il nome deve contenere almeno 3 caratteri.");
            return;
        }

        if (brand.value.trim().length < 2) {
            e.preventDefault();
            invalidaCampo(brand, form, "Il brand deve contenere almeno 2 caratteri.");
            return;
        }

        if (info.value.trim().length < 10) {
            e.preventDefault();
            invalidaCampo(info, form, "Le informazioni devono contenere almeno 10 caratteri.");
            return;
        }

        if (isNaN(prezzo.value) || parseFloat(prezzo.value) <= 0) {
            e.preventDefault();
            invalidaCampo(prezzo, form, "Inserisci un prezzo valido.");
            return;
        }

        if (isNaN(quantita.value) || parseInt(quantita.value) < 0) {
            e.preventDefault();
            invalidaCampo(quantita, form, "Inserisci una quantità valida.");
            return;
        }
    }

    if (formAdminProdotto) {
        formAdminProdotto.addEventListener("submit", function(e) {
            validaProdotto(formAdminProdotto, e);
        });
    }

    if (formAdminModificaProdotto) {
        formAdminModificaProdotto.addEventListener("submit", function(e) {
            validaProdotto(formAdminModificaProdotto, e);
        });
    }

});
