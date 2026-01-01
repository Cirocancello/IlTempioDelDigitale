USE td;

-- Inserimento categorie
INSERT INTO categoria (nome) VALUES
('Smartphone'),
('Smartwatch'),
('Tablet'),
('Notebook');

-- Inserimento prodotti con immagini locali
INSERT INTO prodotto (nome, brand, prezzo, quantita, image_url, informazioni)
VALUES
('Apple iPhone 16 Pro Max 256GB Natural Titanium', 'Apple', 1399.00, 10, 'assets/img/prodotti/apple-iphone-16-pro-max-256gb-natural-titanium.jpg', 'Smartphone top di gamma con design in titanio'),
('Apple Watch Series 7 45mm Alluminio Mezzanotte', 'Apple', 349.00, 15, 'assets/img/prodotti/apple-watch-series-7-45-mm-alluminio-mezzanotte-cinturino-sport-nero.jpg', 'Smartwatch elegante con cinturino sportivo'),
('Lenovo Tab M10 HD 332GB Iron Grey', 'Lenovo', 199.00, 12, 'assets/img/prodotti/lenovo-tab-m10-hd-332gb-iron-grey-wi-filte.jpg', 'Tablet Lenovo con ampio spazio di archiviazione'),
('Notebook Dell 5580 i5 6th Gen 8GB 256GB SSD', 'Dell', 449.00, 6, 'assets/img/prodotti/notebook-dell-5580-i5-6th-gen-8gb-256gb-ssd-lcd-156-.jpg', 'Notebook professionale con SSD veloce'),
('Notebook Lenovo 145 i5 8th Gen 8GB 256GB NVMe', 'Lenovo', 499.00, 5, 'assets/img/prodotti/notebook-lenovo-l480-i5-8th-gen-8gb-256gb-nvme-lcd-14.jpg', 'Notebook compatto con prestazioni solide'),
('Apple iPhone 16 128GB Natural Titanium', 'Apple', 730.00, 5, 'assets/img/prodotti/apple-iphone-16-pro-max-256gb-natural-titanium.jpg', 'Smartphone con processore potente e fotocamera avanzata'),
('Pc Nuc - i5-5250u - 8GB - 250GB SSD', 'Nuc', 730.00,10, 'assets/img/prodotti/pc-nuc-i5-5250u-8gb-250gb-ssd.jpg', 'Pc compatto e dalle prestazioni eccellenti'),
('Samsung Galaxy A55 5G 8+256GB Awesome Navy', 'Samsung', 320.00, 8, 'assets/img/prodotti/samsung-galaxy-a55-8256gb-awesome-navy.jpg', 'smartphone Android avanzato e completo con alcune eccellenze'),
('Samsung Galaxy S25 Ultra', 'Samsung', 1010.00, 8, 'assets/img/prodotti/samsung-galaxy-s25-ultra.jpg', 'Smartphone elegante con fotocamera avanzata');
