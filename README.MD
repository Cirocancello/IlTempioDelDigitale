# 🛒 IlTempioDelDigitale  
E-commerce modulare sviluppato in Java, JSP, Servlet e MySQL

**IlTempioDelDigitale** è un progetto e-commerce completo, progettato con architettura **MVC**.  
Include gestione utenti, catalogo prodotti, carrello dinamico, preferiti, feedback, pannello admin e ricerca AJAX in tempo reale.

---

## 🚀 Funzionalità principali

### 👤 Modulo Utente
- Registrazione con controllo email duplicata  
- Login con gestione errori  
- Logout con invalidazione sessione  
- Pagina profilo protetta tramite filtro di autenticazione  

### 🛍️ Catalogo Prodotti
- Visualizzazione prodotti con immagini, prezzo e dettagli  
- Filtraggio per categoria   
- Gestione del carrello (AJAX) per aggiunta, incremento e decremento prodotti  
- Aggiunta ai preferiti  
- Aggiunta feedback

### ⭐ Feedback
- Inserimento recensioni con titolo, descrizione e valutazione in stelle  
- Calcolo media valutazioni  
- Visualizzazione feedback per prodotto  

### 🛠️ Pannello Admin
- Gestione prodotti (CRUD completo)  
- Gestione categorie  
- Associazione prodotto–categoria  
- Upload immagini prodotto  

---

## 🧱 Architettura del progetto

Struttura chiara e modulare:

src/
├── controller/      → Servlet (logica applicativa)
├── model/           → Classi modello (Prodotto, Utente, Categoria…)
├── dao/             → Data Access Object (CRUD e query)
├── util/            → Utility (DBConnection, helper vari)
├── filter/          → Filtri (autenticazione)

webapp/
├── pagine/          → JSP principali
├── component/       → Componenti riutilizzabili (navbar, footer…)
├── assets/
│     ├── img/       → Immagini
│     ├── styles/    → CSS
│     ├── scripts/   → JS (carrello, )

---

## 🗄️ Database

Tabelle principali:
- `utente`
- `prodotto`
- `categoria`
- `ordine`
- `preferiti`
- `feedback`
- `prodotto_ordine`

---

## 🧪 Tecnologie utilizzate

- **Java 17**
- **JSP / Servlet**
- **Tomcat**
- **MySQL**
- **Bootstrap 5**
- **AJAX / Fetch API**
- **MVC Pattern**

---

## 📦 Installazione

1. Clona il repository  
2. Importa il progetto in IntelliJ / Eclipse  
3. Configura Tomcat  
4. Crea il database MySQL e importa lo schema  
5. Aggiorna le credenziali in `DBConnection.java`  
6. Avvia il server e apri:  
   "http://localhost:8080/IlTempioDelDigitale"
   
7. ambiente di distribuzione:
8. tomcat9/bin/startup.bat
9. "http://localhost:8080/IlTempioDelDigitale"
10. user     tomcat
11. password tomcat
   
12. shutdown.bat per choiudere il server

---

## 🔐 Credenziali Admin

Email:    admin@tempio.it
Password: admin

---

## 👨‍💻 Autore

**Ciro**  
Progetto sviluppato per l'esame di *Tecnologie Software per il Web* — A.A. 2024/2025.