document.addEventListener("DOMContentLoaded", () => {

    // ---------------------------
    // VALIDAZIONE LOGIN
    // ---------------------------
    const formLogin = document.getElementById("formLogin");

    if (formLogin) {
        formLogin.addEventListener("submit", function(e) {

            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

            if (!emailRegex.test(email)) {
                alert("Inserisci un'email valida.");
                e.preventDefault();
                return;
            }

            if (!passwordRegex.test(password)) {
                alert("La password deve contenere almeno 6 caratteri e includere lettere e numeri.");
                e.preventDefault();
                return;
            }
        });
    }

	// ---------------------------
	// VALIDAZIONE REGISTRAZIONE
	// ---------------------------
	const formRegistrazione = document.getElementById("formRegistrazione");

	if (formRegistrazione) {
	    formRegistrazione.addEventListener("submit", function(e) {

	        const nome = document.getElementById("nome").value.trim();
	        const cognome = document.getElementById("cognome").value.trim();
	        const email = document.getElementById("email").value.trim();
	        const password = document.getElementById("password").value.trim();
	        const conferma = document.getElementById("conferma").value.trim();

	        const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

	        if (!nomeRegex.test(nome)) {
	            alert("Il nome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!nomeRegex.test(cognome)) {
	            alert("Il cognome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!emailRegex.test(email)) {
	            alert("Inserisci un'email valida.");
	            e.preventDefault();
	            return;
	        }

	        if (!passwordRegex.test(password)) {
	            alert("La password deve contenere almeno 6 caratteri e includere lettere e numeri.");
	            e.preventDefault();
	            return;
	        }

	        if (password !== conferma) {
	            alert("Le password non coincidono.");
	            e.preventDefault();
	            return;
	        }
	    });
	}
	
	// ---------------------------
	// VALIDAZIONE CHECKOUT
	// ---------------------------
	const formCheckout = document.getElementById("formCheckout");

	if (formCheckout) {
	    formCheckout.addEventListener("submit", function(e) {

	        const indirizzo = document.getElementById("indirizzoSpedizione").value.trim();
	        const metodo = document.getElementById("metodoPagamento").value.trim();

	        const indirizzoRegex = /^.{5,}$/; // minimo 5 caratteri

	        if (!indirizzoRegex.test(indirizzo)) {
	            alert("Inserisci un indirizzo valido (minimo 5 caratteri).");
	            e.preventDefault();
	            return;
	        }

	        if (metodo === "") {
	            alert("Seleziona un metodo di pagamento.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE LOGIN ADMIN
	// ---------------------------
	const formAdminLogin = document.getElementById("formAdminLogin");

	if (formAdminLogin) {
	    formAdminLogin.addEventListener("submit", function(e) {

	        const email = document.querySelector("#formAdminLogin input[name='email']").value.trim();
	        const password = document.querySelector("#formAdminLogin input[name='password']").value.trim();

	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        
			const passwordRegex = /^[A-Za-z0-9]{3,}$/;

	        if (!emailRegex.test(email)) {
	            alert("Inserisci un'email valida.");
	            e.preventDefault();
	            return;
	        }

	        if (!passwordRegex.test(password)) {
	            alert("La password deve contenere almeno 3 caratteri alfanumerici.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE ADMIN UTENTE
	// ---------------------------
	const formAdminUtente = document.getElementById("formAdminUtente");

	if (formAdminUtente) {
	    formAdminUtente.addEventListener("submit", function(e) {

	        const nome = formAdminUtente.querySelector("input[name='nome']").value.trim();
	        const cognome = formAdminUtente.querySelector("input[name='cognome']").value.trim();
	        const email = formAdminUtente.querySelector("input[name='email']").value.trim();
	        const password = formAdminUtente.querySelector("input[name='password']").value.trim();
	        const ruolo = formAdminUtente.querySelector("select[name='role']").value;

	        const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{6,}$/;

	        if (!nomeRegex.test(nome)) {
	            alert("Il nome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!nomeRegex.test(cognome)) {
	            alert("Il cognome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!emailRegex.test(email)) {
	            alert("Inserisci un'email valida.");
	            e.preventDefault();
	            return;
	        }

	        if (!passwordRegex.test(password)) {
	            alert("La password deve contenere almeno 6 caratteri e includere lettere e numeri.");
	            e.preventDefault();
	            return;
	        }

	        if (ruolo !== "0" && ruolo !== "1") {
	            alert("Seleziona un ruolo valido.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE ADMIN CATEGORIA
	// ---------------------------
	const formAdminCategoria = document.getElementById("formAdminCategoria");

	if (formAdminCategoria) {
	    formAdminCategoria.addEventListener("submit", function(e) {

	        const nome = formAdminCategoria.querySelector("input[name='nome']").value.trim();

	        if (nome.length < 3) {
	            alert("Il nome della categoria deve contenere almeno 3 caratteri.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE ADMIN CREA PRODOTTO
	// ---------------------------
	const formAdminProdotto = document.getElementById("formAdminProdotto");

	if (formAdminProdotto) {
	    formAdminProdotto.addEventListener("submit", function(e) {

	        const nome = formAdminProdotto.querySelector("input[name='nome']").value.trim();
	        const brand = formAdminProdotto.querySelector("input[name='brand']").value.trim();
	        const info = formAdminProdotto.querySelector("textarea[name='informazioni']").value.trim();
	        const prezzo = formAdminProdotto.querySelector("input[name='prezzo']").value.trim();
	        const quantita = formAdminProdotto.querySelector("input[name='quantita']").value.trim();

	        if (nome.length < 3) {
	            alert("Il nome deve contenere almeno 3 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (brand.length < 2) {
	            alert("Il brand deve contenere almeno 2 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (info.length < 10) {
	            alert("Le informazioni devono contenere almeno 10 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (isNaN(prezzo) || parseFloat(prezzo) <= 0) {
	            alert("Inserisci un prezzo valido.");
	            e.preventDefault();
	            return;
	        }

	        if (isNaN(quantita) || parseInt(quantita) < 0) {
	            alert("Inserisci una quantità valida.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE ADMIN MODIFICA CATEGORIA
	// ---------------------------
	const formAdminModificaCategoria = document.getElementById("formAdminModificaCategoria");

	if (formAdminModificaCategoria) {
	    formAdminModificaCategoria.addEventListener("submit", function(e) {

	        const nome = formAdminModificaCategoria.querySelector("input[name='nome']").value.trim();

	        if (nome.length < 3) {
	            alert("Il nome della categoria deve contenere almeno 3 caratteri.");
	            e.preventDefault();
	            return;
	        }
	    });
	}


	// ---------------------------
	// VALIDAZIONE ADMIN MODIFICA PRODOTTO
	// ---------------------------
	const formAdminModificaProdotto = document.getElementById("formAdminModificaProdotto");

	if (formAdminModificaProdotto) {
	    formAdminModificaProdotto.addEventListener("submit", function(e) {

	        const nome = formAdminModificaProdotto.querySelector("input[name='nome']").value.trim();
	        const brand = formAdminModificaProdotto.querySelector("input[name='brand']").value.trim();
	        const info = formAdminModificaProdotto.querySelector("textarea[name='informazioni']").value.trim();
	        const prezzo = formAdminModificaProdotto.querySelector("input[name='prezzo']").value.trim();
	        const quantita = formAdminModificaProdotto.querySelector("input[name='quantita']").value.trim();

	        if (nome.length < 3) {
	            alert("Il nome deve contenere almeno 3 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (brand.length < 2) {
	            alert("Il brand deve contenere almeno 2 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (info.length < 10) {
	            alert("Le informazioni devono contenere almeno 10 caratteri.");
	            e.preventDefault();
	            return;
	        }

	        if (isNaN(prezzo) || parseFloat(prezzo) <= 0) {
	            alert("Inserisci un prezzo valido.");
	            e.preventDefault();
	            return;
	        }

	        if (isNaN(quantita) || parseInt(quantita) < 0) {
	            alert("Inserisci una quantità valida.");
	            e.preventDefault();
	            return;
	        }
	    });
	}

	// ---------------------------
	// VALIDAZIONE ADMIN MODIFICA UTENTE
	// ---------------------------
	const formAdminModificaUtente = document.getElementById("formAdminModificaUtente");

	if (formAdminModificaUtente) {
	    formAdminModificaUtente.addEventListener("submit", function(e) {

	        const nome = formAdminModificaUtente.querySelector("input[name='nome']").value.trim();
	        const cognome = formAdminModificaUtente.querySelector("input[name='cognome']").value.trim();
	        const email = formAdminModificaUtente.querySelector("input[name='email']").value.trim();
	        const ruolo = formAdminModificaUtente.querySelector("select[name='role']").value;

	        const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']{2,30}$/;
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	        if (!nomeRegex.test(nome)) {
	            alert("Il nome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!nomeRegex.test(cognome)) {
	            alert("Il cognome deve contenere solo lettere.");
	            e.preventDefault();
	            return;
	        }

	        if (!emailRegex.test(email)) {
	            alert("Inserisci un'email valida.");
	            e.preventDefault();
	            return;
	        }

	        if (ruolo !== "0" && ruolo !== "1") {
	            alert("Seleziona un ruolo valido.");
	            e.preventDefault();
	            return;
	        }
	    });
	}
	
	//-----------------------------------------
	// VALIDAZIONE FILE + ANTEPRIMA IMMAGINE
	//-----------------------------------------
	
	const inputFile = document.getElementById("immagine");
	const preview = document.getElementById("preview");
	const form = document.getElementById("formAdminProdotto"); // più preciso

	if (inputFile && preview && form) {

	    // 1) Anteprima immagine
	    inputFile.addEventListener("change", function () {
	        const file = this.files[0];

	        if (!file) return;

	        const validExtensions = ["image/jpeg", "image/png", "image/gif"];
	        if (!validExtensions.includes(file.type)) {
	            alert("Formato non valido. Usa JPG, PNG o GIF.");
	            this.value = "";
	            preview.src = "";
	            return;
	        }

	        if (file.size > 5 * 1024 * 1024) {
	            alert("L'immagine supera i 5MB.");
	            this.value = "";
	            preview.src = "";
	            return;
	        }
			
			const categoria = document.getElementById("categoria").value;
			if (!categoria || categoria === "0") {
			    alert("Seleziona una categoria.");
			    e.preventDefault();
			    return;
			}


	        const reader = new FileReader();
	        reader.onload = e => preview.src = e.target.result;
	        reader.readAsDataURL(file);
	    });

	    // 2) Validazione campi
	    form.addEventListener("submit", function (e) {
	        const nome = document.getElementById("nome").value.trim();
	        const brand = document.getElementById("brand").value.trim();
	        const prezzo = document.getElementById("prezzo").value.trim();
	        const quantita = document.getElementById("quantita").value.trim();

	        if (!nome || !brand || !prezzo || !quantita) {
	            alert("Compila tutti i campi obbligatori.");
	            e.preventDefault();
	        }
	    });
	}


});
