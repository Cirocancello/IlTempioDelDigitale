drop database if exists td;
create database td;
create table td.utente(
id integer primary key auto_increment,
nome text not null,
cognome text not null,
email varchar(500) not null unique,
_password text, 
oauth boolean not null,
propic_url text default ("https://via.placeholder.com/300x225"),
provincia text not null,
cap char(5) not null,
via text not null,
civico text not null,
note text,
_role tinyint default 0);
create table td.ordine(
id varchar(36) primary key not null unique,
id_utente integer not null, 
_data timestamp not null,
stato text not null,
foreign key(id_utente) references utente(id));
create table td.categoria(
id integer primary key auto_increment,
nome text not null);
create table td.prodotto(
id integer primary key auto_increment,
nome text not null,
brand text not null,
prezzo float not null,
quantita integer not null,
image_url text default ("https://via.placeholder.com/300x225"),
informazioni text,
visibile boolean default true,
check (quantita > -1));
create table td.categoria_prodotto(
id_categoria integer,
id_prodotto integer,
primary key (id_categoria, id_prodotto),
foreign key(id_categoria) references categoria(id),
foreign key(id_prodotto) references prodotto(id));
create table td.feedback(
id integer primary key auto_increment,
id_prodotto integer not null,
score tinyint not null,
titolo text,
descrizione text,
_data timestamp not null,
foreign key (id_prodotto) references prodotto(id));
create table td.prodotto_ordine(
id integer primary key auto_increment,
id_prodotto integer not null,
id_ordine varchar(36) not null,
prezzo_effettivo float not null,
iva float not null,
quantita integer not null,
foreign key (id_prodotto) references prodotto(id),
foreign key (id_ordine) references ordine(id),
check (quantita > 0));



