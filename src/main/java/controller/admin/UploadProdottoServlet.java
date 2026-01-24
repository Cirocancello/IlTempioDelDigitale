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

@WebServlet("/admin/uploadProdotto")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB
        maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class UploadProdottoServlet extends HttpServlet {

    /**
     * Gestisce:
     *  - creazione prodotto con upload immagine
     *  - aggiornamento immagine prodotto
     *
     *  I dati testuali vengono gestiti da AdminProdottoServlet.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {

            ProdottoDAO dao = new ProdottoDAO(conn);

            // ----------------------------------------------------
            // ⭐ 1) CREAZIONE PRODOTTO
            // ----------------------------------------------------
            if ("create".equals(action)) {

                // --- Campi testuali ---
                String nome = request.getParameter("nome");
                String brand = request.getParameter("brand");
                String informazioni = request.getParameter("informazioni");
                double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                int quantita = Integer.parseInt(request.getParameter("quantita"));
                int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

                // --- File immagine ---
                Part filePart = request.getPart("immagine");

                // Validazioni immagine
                validateImage(filePart);

                // Nome file univoco
                String fileName = System.currentTimeMillis() + "_" +
                        filePart.getSubmittedFileName().toLowerCase();

                // Percorso fisico
                String uploadPath = getServletContext().getRealPath("/assets/img/prodotti");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // Salvataggio file
                File file = new File(uploadDir, fileName);
                Files.copy(filePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // Percorso da salvare nel DB
                String imageUrl = "assets/img/prodotti/" + fileName;

                // Creazione oggetto prodotto
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

                dao.insert(p);

                response.sendRedirect(request.getContextPath() + "/admin/prodotti");
                return;
            }

            // ----------------------------------------------------
            // ⭐ 2) AGGIORNAMENTO IMMAGINE PRODOTTO
            // ----------------------------------------------------
            if ("updateImage".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Prodotto prodotto = dao.findById(id);

                if (prodotto == null)
                    throw new ServletException("Prodotto non trovato");

                Part filePart = request.getPart("immagine");

                // Validazioni immagine
                validateImage(filePart);

                // Nome file univoco
                String fileName = System.currentTimeMillis() + "_" +
                        filePart.getSubmittedFileName().toLowerCase();

                // Percorso fisico
                String uploadPath = getServletContext().getRealPath("/assets/img/prodotti");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // Salvataggio file
                File file = new File(uploadDir, fileName);
                Files.copy(filePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // Aggiorna percorso immagine
                String imageUrl = "assets/img/prodotti/" + fileName;
                prodotto.setImageUrl(imageUrl);

                dao.update(prodotto);

                // Torna alla pagina di modifica
                response.sendRedirect(request.getContextPath() + "/admin/prodotti?action=edit&id=" + id);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Errore durante l'upload del prodotto");
        }
    }

    /**
     * ⭐ Metodo di utilità per validare un'immagine caricata
     */
    private void validateImage(Part filePart) throws ServletException {

        if (filePart == null || filePart.getSize() == 0)
            throw new ServletException("Nessun file selezionato");

        String mimeType = filePart.getContentType();
        if (mimeType == null || !mimeType.startsWith("image/"))
            throw new ServletException("Il file caricato non è un'immagine valida");

        String fileName = filePart.getSubmittedFileName().toLowerCase();
        if (!(fileName.endsWith(".jpg") ||
                fileName.endsWith(".jpeg") ||
                fileName.endsWith(".png") ||
                fileName.endsWith(".gif")))
            throw new ServletException("Formato immagine non supportato (usa JPG, PNG o GIF)");

        if (filePart.getSize() > 5 * 1024 * 1024)
            throw new ServletException("L'immagine supera la dimensione massima di 5MB");
    }
}
