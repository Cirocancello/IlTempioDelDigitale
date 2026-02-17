package controller.admin;

import dao.ProdottoDAO;
import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Categoria;
import model.Prodotto;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;

/**
 * UploadProdottoServlet
 * ------------------------------------------------------------
 * Questa servlet gestisce due operazioni:
 *
 *  1) Creazione di un nuovo prodotto con immagine
 *  2) Aggiornamento dell’immagine di un prodotto esistente
 *
 * È annotata con @MultipartConfig, che abilita l’upload di file
 * tramite form HTML con enctype="multipart/form-data".
 *
 * La servlet gestisce sia:
 *  - la parte logica (DAO, DB)
 *  - la parte fisica (salvataggio file sul server)
 */
@WebServlet("/admin/uploadProdotto")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // Buffer temporaneo di 1MB
        maxFileSize = 1024 * 1024 * 5,        // Dimensione massima file: 5MB
        maxRequestSize = 1024 * 1024 * 10     // Dimensione massima richiesta: 10MB
)
public class UploadProdottoServlet extends HttpServlet {

    // ======================================================================
    // ⭐ Metodo POST → gestisce sia create che updateImage
    // ======================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // L’azione indica quale operazione vogliamo eseguire:
        // - "create" → nuovo prodotto
        // - "updateImage" → aggiornamento immagine
        String action = request.getParameter("action");

        // Connessione al DB tramite try-with-resources:
        // la connessione viene chiusa automaticamente alla fine del blocco.
        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO dao = new ProdottoDAO(conn);

            // ============================================================
            // ⭐ 1) CREAZIONE NUOVO PRODOTTO
            // ============================================================
            if ("create".equals(action)) {

                // --------------------------------------------------------
                // ⭐ Lettura parametri testuali dal form
                // --------------------------------------------------------
                String nome = request.getParameter("nome");
                String brand = request.getParameter("brand");
                String informazioni = request.getParameter("informazioni");
                double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                int quantita = Integer.parseInt(request.getParameter("quantita"));
                int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

                // --------------------------------------------------------
                // ⭐ Lettura file immagine dal form
                // Il form deve avere enctype="multipart/form-data"
                // --------------------------------------------------------
                Part filePart = request.getPart("immagine");

                // --------------------------------------------------------
                // ⭐ Validazione immagine
                // Controlla:
                //   - esistenza file
                //   - MIME type
                //   - estensione
                //   - dimensione
                // --------------------------------------------------------
                validateImage(filePart);

                // --------------------------------------------------------
                // ⭐ Generazione nome file unico
                // Usando il timestamp evitiamo sovrascritture
                // --------------------------------------------------------
                String fileName = System.currentTimeMillis() + "_" +
                        filePart.getSubmittedFileName().toLowerCase();

                // --------------------------------------------------------
                // ⭐ Recupero percorso reale della cartella immagini
                // getRealPath() converte un percorso relativo del progetto
                // in un percorso assoluto sul file system del server.
                // --------------------------------------------------------
                String uploadPath = getServletContext().getRealPath("/assets/img/prodotti");

                // Creo la cartella se non esiste
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // --------------------------------------------------------
                // ⭐ Copia fisica del file sul server
                // Il file viene salvato nella cartella reale del progetto.
                // --------------------------------------------------------
                File file = new File(uploadDir, fileName);
                Files.copy(filePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // --------------------------------------------------------
                // ⭐ Percorso relativo da salvare nel DB
                // Questo è il percorso che useremo nelle JSP (<img src="...">)
                // --------------------------------------------------------
                String imageUrl = "assets/img/prodotti/" + fileName;

                // --------------------------------------------------------
                // ⭐ Creazione oggetto Prodotto
                // --------------------------------------------------------
                Categoria categoria = new Categoria(categoriaId, null);

                Prodotto p = new Prodotto();
                p.setNome(nome);
                p.setBrand(brand);
                p.setInformazioni(informazioni);
                p.setPrezzo(prezzo);
                p.setQuantita(quantita);
                p.setImageUrl(imageUrl);
                p.setVisibile(true);
                p.setCategoria(categoria);

                // --------------------------------------------------------
                // ⭐ Inserimento nel DB
                // --------------------------------------------------------
                dao.insert(p);

                // --------------------------------------------------------
                // ⭐ Redirect alla lista prodotti (PRG)
                // Evita reinvio del form al refresh
                // --------------------------------------------------------
                response.sendRedirect(request.getContextPath() + "/admin/prodotti");
                return;
            }

            // ============================================================
            // ⭐ 2) AGGIORNAMENTO IMMAGINE DI UN PRODOTTO ESISTENTE
            // ============================================================
            if ("updateImage".equals(action)) {

                // ID del prodotto da aggiornare
                int id = Integer.parseInt(request.getParameter("id"));

                // Recupero prodotto dal DB
                Prodotto prodotto = dao.findById(id);
                if (prodotto == null)
                    throw new ServletException("Prodotto non trovato");

                // Lettura file immagine
                Part filePart = request.getPart("immagine");

                // Se non è stato selezionato alcun file → non aggiornare nulla
                if (filePart == null || filePart.getSize() == 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/prodotti?action=edit&id=" + id);
                    return;
                }

                // Validazione immagine
                validateImage(filePart);

                // Nome file unico
                String fileName = System.currentTimeMillis() + "_" +
                        filePart.getSubmittedFileName().toLowerCase();

                // Percorso reale cartella immagini
                String uploadPath = getServletContext().getRealPath("/assets/img/prodotti");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // Copia fisica del file
                File file = new File(uploadDir, fileName);
                Files.copy(filePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // Aggiornamento percorso immagine
                String imageUrl = "assets/img/prodotti/" + fileName;
                prodotto.setImageUrl(imageUrl);

                // Aggiornamento nel DB
                dao.update(prodotto);

                // Torna alla pagina di modifica (PRG)
                response.sendRedirect(request.getContextPath() + "/admin/prodotti?action=edit&id=" + id);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Errore durante l'upload del prodotto");
        }
    }

    // ======================================================================
    // ⭐ Metodo di validazione immagine
    // ======================================================================
    private void validateImage(Part filePart) throws ServletException {

        // Controllo che il file esista
        if (filePart == null || filePart.getSize() == 0)
            throw new ServletException("Nessun file selezionato");

        // Controllo MIME type
        String mimeType = filePart.getContentType();
        if (mimeType == null || !mimeType.startsWith("image/"))
            throw new ServletException("Il file caricato non è un'immagine valida");

        // Controllo estensione
        String fileName = filePart.getSubmittedFileName().toLowerCase();
        if (!(fileName.endsWith(".jpg") ||
                fileName.endsWith(".jpeg") ||
                fileName.endsWith(".png") ||
                fileName.endsWith(".gif")))
            throw new ServletException("Formato immagine non supportato (usa JPG, PNG o GIF)");

        // Controllo dimensione massima
        if (filePart.getSize() > 5 * 1024 * 1024)
            throw new ServletException("L'immagine supera la dimensione massima di 5MB");
    }
}
