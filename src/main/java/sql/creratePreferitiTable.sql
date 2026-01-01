
USE td;
CREATE TABLE td.preferiti (
    id_utente INT NOT NULL,
    id_prodotto INT NOT NULL,
    data_salvataggio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_utente, id_prodotto),
    FOREIGN KEY (id_utente) REFERENCES td.utente(id) ON DELETE CASCADE,
    FOREIGN KEY (id_prodotto) REFERENCES td.prodotto(id) ON DELETE CASCADE
);





