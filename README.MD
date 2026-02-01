# 🛒 IlTempioDelDigitale  
E-commerce modulare sviluppato in Java, JSP, Servlet e MySQL

IlTempioDelDigitale è un progetto e-commerce completo, progettato con architettura MVC.  
Include gestione utenti, catalogo prodotti, carrello, preferiti, feedback, pannello admin e ricerca dinamica tramite AJAX.

---

## 🚀 Funzionalità principali

### 👤 Modulo Utente
- Registrazione con controllo email duplicata  
- Login con gestione errori  
- Logout con invalidazione sessione  
- Pagina profilo protetta da filtro di autenticazione  

### 🛍️ Catalogo Prodotti
- Visualizzazione prodotti con immagini, prezzo e dettagli  
- Filtraggio per categoria  
- **Ricerca dinamica AJAX** (nuova funzionalità)  
- Aggiunta al carrello (AJAX)  
- Aggiunta ai preferiti  

### ⭐ Feedback
- Inserimento recensioni con titolo, descrizione e stelle  
- Media valutazioni  
- Visualizzazione feedback per prodotto  

### 🛠️ Pannello Admin
- Gestione prodotti (CRUD completo)  
- Gestione categorie  
- Gestione associazioni prodotto–categoria  
- Upload immagini prodotto  

---

## 🧱 Architettura del progetto

Il progetto segue una struttura chiara e professionale:

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
│     ├── scripts/   → JS (carrello, ricerca AJAX…)

Codice

---

## 🔍 Ricerca dinamica AJAX (nuova funzionalità)

Implementata tramite:
- `RicercaProdottiServlet`
- Metodo `search()` in `ProdottoDAO`
- Script `ricerca.js` con `fetch()`  
- Aggiornamento in tempo reale del catalogo

---

## 🗄️ Database

MySQL con tabelle principali:
- `utente`
- `prodotto`
- `categoria`
- `categoria_prodotto`
- `prodotto_ordine`
- `feedback`

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
http://localhost:8080/IlTempioDelDigitale

Codice

---

## 👨‍💻 Autore

**Ciro**  
Progetto sviluppato per l'esame di Tecnologie Software per il Web.