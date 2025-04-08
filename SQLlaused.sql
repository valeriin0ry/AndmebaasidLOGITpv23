--kommentaar
--Xampp control panel
--Connect TO:
--Server Name: localhost - 127.0.0.1
-- Authentification:
-- kasutaja: root
-- parool: ei ole
CREATE DATABASE ashurovLOGITpv23;
USE ashurovLOGITpv23;

--tabeli loomine
--AUTO_INCREMENT - ise täidab tabeli 1,2,3...
CREATE TABLE inimene(
inimeneID int Primary Key identity(1,1),
nimi varchar(50) unique,
synniaeg date,
telefon char(12),
pikkus decimal(5,2),
opilaskodu bit
);
SELECT * FROM inimene;

--tabeli kustutamine
DROP table inimene;

--andmete lisamine
--DDL - data definiton language
--DML - data manipulation language

INSERT INTO inimene
(nimi, synniaeg, telefon, pikkus, opilaskodu)
VALUES
('Peeter Uus', '2021-12-30', '2568952', 90.5, 0),
('Kaarel Oja', '2000-12-30', '2568952', 90.5, 0),
('Kask Mati', '1983-12-30', '33333', 140.5, 0),
('Peeter Oja', '2021-12-30', '333333', 190.5, 0)
;
SELECT * FROM inimene; 
--kustuta id=2
DELETE FROM inimene
WHERE inimeneID=2;


--tabel elukoht
CREATE TABLE elukoht(
elukohtID int PRIMARY KEY identity (1,1),
elukoht varchar(50) UNIQUE,
maakond varchar(50)
);
SELECT * FROM elukoht;
--andmete lisamine tabeli elukoht
INSERT INTO elukoht(elukoht, maakond)
VALUES ('Tallinn', 'Harjumaa'), 
('Tartu', 'Tartumaa'),
('Pärnu', 'Pärnumaa');

--tabeli muutmine uue veergu lisamine
ALTER TABLE inimene ADD elukohtID int;
SELECT * FROM inimene;

--foreign key lisamine

ALTER TABLE inimene
ADD constraint fk_elukoht
FOREIGN KEY (elukohtID)
references elukoht(elukohtID);

SELECT * FROM inimene;
SELECT * FROM elukoht;
INSERT INTO inimene
(nimi, synniaeg, telefon, pikkus, opilaskodu, elukohtID, autoID)
VALUES
('Peeter SUS', '2021-12-30', '2568952', 90.5, 0, 2, 1);
INSERT INTO inimene
(nimi, synniaeg, telefon, pikkus, opilaskodu, elukohtID, autoID)
VALUES
('Peeter SUSPECT', '2021-12-31', '3568952', 91.5, 0, 1, 1);
SELECT * from inimene join elukoht
ON inimene.elukohtID=elukoht.elukohtID;

SELECT i.nimi, i.synniaeg, e.elukoht
from inimene i join elukoht e
ON i.elukohtID=e.elukohtID;

--tabel auto
CREATE TABLE auto(
autoID int PRIMARY KEY identity(1,1),
auto varchar(50) UNIQUE,
autoNR varchar(12),
mudell varchar(10),
mark varchar(15),
vaasta date,
);

INSERT INTO auto(auto, autoNR, mudell, mark, vaasta)
VALUES ('2', 'EEE777', 'E34', 'BMW', '2017-12-30');


SELECT * FROM auto

SELECT * from inimene join auto 
ON inimene.autoID=auto.autoID;


SELECT i.nimi, i.synniaeg, a.auto
from inimene i join auto a
ON i.autoID=a.autoID;

ALTER TABLE inimene ADD autoID int;

ALTER TABLE inimene
ADD constraint fk_auto
FOREIGN KEY (autoID)
references auto(autoID);





CREATE TABLE loom(
loomID int PRIMARY KEY AUTO_INCREMENT,
nimi varchar(50),
kaal decimal(2,2)
);


CREATE TABLE tyyp(
tyypID int PRIMARY KEY AUTO_INCREMENT,
tyyp varchar(50),
kirjeldus varchar(70)
);
INSERT INTO tyyp(tyyp, kirjeldus)
VALUES ('taksa','asub tallinnas');

ALTER TABLE loom ADD tyypID int;


INSERT INTO tyyp(tyyp, kirjeldus)
VALUES ('kass','musta kass');


ALTER TABLE loom
ADD constraint fk_tyyp
FOREIGN KEY (tyypID)
references tyyp(tyypID);

INSERT INTO loom(nimi,kaal)
VALUES ('Faceit','5,70');

ALTER TABLE inimene ADD loomID int;

ALTER TABLE inimene
ADD constraint fk_loom
FOREIGN KEY (loomID)
references loom(loomID);
