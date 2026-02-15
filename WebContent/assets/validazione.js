document.addEventListener("DOMContentLoaded", () => {
	console.log("✅ VALIDAZIONE VERSIONE CORRETTA CARICATA");


    // ==========================
    // FUNZIONI GLOBALI
    // ==========================

    function mostraErroreForm(form, testo) {
        let box = form.querySelector(".errore-form");

        if (!box) {
            box = document.createElement("div");
            box.className = "alert alert-danger errore-form mt-2";
            form.prepend(box);
        }

        box.textContent = testo;

        setTimeout(() => box.remove(), 4000);
    }

    function invalidaCampo(campo, form, messaggio) {
        campo.classList.add("is-invalid");
        mostraErroreForm(form, messaggio);
    }

    function pulisciErrori(form) {
        form.querySelectorAll(".is-invalid").forEach(el => el.classList.remove("is-invalid"));
    }

    // ==========================
    // VALIDAZIONE LOGIN
    // ==========================
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

    // ==========================
    // VALIDAZIONE REGISTRAZIONE
    // ==========================
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

    // ==========================
    // VALIDAZIONE CHECKOUT
    // ==========================
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

    // ==========================
    // VALIDAZIONE ADMIN LOGIN
    // ==========================
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

    // ==========================
    // VALIDAZIONE ADMIN UTENTE
    // ==========================
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

    // ==========================
    // VALIDAZIONE ADMIN CATEGORIA
    // ==========================
    const formAdminCategoria = document.getElementById("formAdminCategoria");

    if (formAdminCategoria) {
        formAdminCategoria.addEventListener("submit", function(e) {

            pulisciErrori(formAdminCategoria);

            const nome = formAdminCategoria.querySelector("input[name='nome']");

            if (nome.value.trim().length < 3) {
                e.preventDefault();
                invalidaCampo(nome, formAdminCategoria, "Il nome della categoria deve contenere almeno 3 caratteri.");
                return;
            }
        });
    }

    // ==========================
    // VALIDAZIONE ADMIN CREA PRODOTTO
    // ==========================
    const formAdminProdotto = document.getElementById("formAdminProdotto");

    if (formAdminProdotto) {
        formAdminProdotto.addEventListener("submit", function(e) {

            pulisciErrori(formAdminProdotto);

            const nome = formAdminProdotto.querySelector("input[name='nome']");
            const brand = formAdminProdotto.querySelector("input[name='brand']");
            const info = formAdminProdotto.querySelector("textarea[name='informazioni']");
            const prezzo = formAdminProdotto.querySelector("input[name='prezzo']");
            const quantita = formAdminProdotto.querySelector("input[name='quantita']");

            if (nome.value.trim().length < 3) {
                e.preventDefault();
                invalidaCampo(nome, formAdminProdotto, "Il nome deve contenere almeno 3 caratteri.");
                return;
            }

            if (brand.value.trim().length < 2) {
                e.preventDefault();
                invalidaCampo(brand, formAdminProdotto, "Il brand deve contenere almeno 2 caratteri.");
                return;
            }

            if (info.value.trim().length < 10) {
                e.preventDefault();
                invalidaCampo(info, formAdminProdotto, "Le informazioni devono contenere almeno 10 caratteri.");
                return;
            }

            if (isNaN(prezzo.value) || parseFloat(prezzo.value) <= 0) {
                e.preventDefault();
                invalidaCampo(prezzo, formAdminProdotto, "Inserisci un prezzo valido.");
                return;
            }

            if (isNaN(quantita.value) || parseInt(quantita.value) < 0) {
                e.preventDefault();
                invalidaCampo(quantita, formAdminProdotto, "Inserisci una quantità valida.");
                return;
            }
        });
    }

    // ==========================
    // VALIDAZIONE ADMIN MODIFICA CATEGORIA
    // ==========================
    const formAdminModificaCategoria = document.getElementById("formAdminModificaCategoria");

    if (formAdminModificaCategoria) {
        formAdminModificaCategoria.addEventListener("submit", function(e) {

            pulisciErrori(formAdminModificaCategoria);

            const nome = formAdminModificaCategoria.querySelector("input[name='nome']");

            if (nome.value.trim().length < 3) {
                e.preventDefault();
                invalidaCampo(nome, formAdminModificaCategoria, "Il nome della categoria deve contenere almeno 3 caratteri.");
                return;
            }
        });
    }

    // ==========================
    // VALIDAZIONE ADMIN MODIFICA PRODOTTO
    // ==========================
    const formAdminModificaProdotto = document.getElementById("formAdminModificaProdotto");

    if (formAdminModificaProdotto) {
        formAdminModificaProdotto.addEventListener("submit", function(e) {

            pulisciErrori(formAdminModificaProdotto);

            const nome = formAdminModificaProdotto.querySelector("input[name='nome']");
            const brand = formAdminModificaProdotto.querySelector("input[name='brand']");
            const info = formAdminModificaProdotto.querySelector("textarea[name='informazioni']");
            const prezzo = formAdminModificaProdotto.querySelector("input[name='prezzo']");
            const quantita = formAdminModificaProdotto.querySelector("input[name='quantita']");

            if (nome.value.trim().length < 3) {
                e.preventDefault();
                invalidaCampo(nome, formAdminModificaProdotto, "Il nome deve contenere almeno 3 caratteri.");
                return;
            }

            if (brand.value.trim().length < 2) {
                e.preventDefault();
                invalidaCampo(brand, formAdminModificaProdotto, "Il brand deve contenere almeno 2 caratteri.");
                return;
            }

            if (info.value.trim().length < 10) {
                e.preventDefault();
                invalidaCampo(info, formAdminModificaProdotto, "Le informazioni devono contenere almeno 10 caratteri.");
                return;
            }

            if (isNaN(prezzo.value) || parseFloat(prezzo.value) <= 0) {
                e.preventDefault();
                invalidaCampo(prezzo, formAdminModificaProdotto, "Inserisci un prezzo valido.");
                return;
            }

            if (isNaN(quantita.value) || parseInt(quantita.value) < 0) {
                e.preventDefault();
                invalidaCampo(quantita, formAdminModificaProdotto, "Inserisci una quantità valida.");
                return;
            }
        });
    }

    // ==========================
    // VALIDAZIONE ADMIN MODIFICA UTENTE
    // ==========================
    const formAdminModificaUtente = document.getElementById("formAdminModificaUtente");

    if (formAdminModificaUtente) {
        formAdminModificaUtente.addEventListener("submit", function(e) {

            pulisciErrori(formAdminModificaUtente);

            const nome = formAdminModificaUtente.querySelector("input[name='nome']");
            const cognome = formAdminModificaUtente.querySelector("input[name='cognome']");
            const email = formAdminModificaUtente.querySelector("input[name='email']");
            const ruolo = formAdminModificaUtente.querySelector("select[name='role']");

            const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!nomeRegex.test(nome.value.trim())) {
                e.preventDefault();
                invalidaCampo(nome, formAdminModificaUtente, "Il nome deve contenere solo lettere.");
                return;
            }

            if (!nomeRegex.test(cognome.value.trim())) {
                e.preventDefault();
                invalidaCampo(cognome, formAdminModificaUtente, "Il cognome deve contenere solo lettere.");
                return;
            }

            if (!emailRegex.test(email.value.trim())) {
                e.preventDefault();
                invalidaCampo(email, formAdminModificaUtente, "Inserisci un'email valida.");
                return;
            }

            if (ruolo.value !== "0" && ruolo.value !== "1") {
                e.preventDefault();
                invalidaCampo(ruolo, formAdminModificaUtente, "Seleziona un ruolo valido.");
                return;
            }
        });
    }

});
