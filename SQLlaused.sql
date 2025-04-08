--kommentaar
--SQL Server Management Studio
--Connect TO:
--Server Name: (localdb)\MSSQLLocalDB
- Authentification 2 tüüpi:
--1. Windows Authentification - localdb admini õigused
--2. SQL Server Auth - kontrollida varem tehtud kasutajad

CREATE DATABASE ashurovLOGITpv23;
USE ashurovLOGITpv23;

--tabeli loomine
--identity(1,1) - ise täidab tabeli 1,2,3...
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
(nimi, synniaeg, telefon, pikkus, opilaskodu, elukohtID, autoID)
VALUES
('Peeter Uus', '2021-12-30', '2568952', 90.5, 0, 0),
('Kaarel Oja', '2000-12-30', '2568952', 90.5, 0, 0),
('Kask Mati', '1983-12-30', '33333', 140.5, 0, 0),
('Peeter Oja', '2021-12-30', '333333', 190.5, 0, 0)
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
