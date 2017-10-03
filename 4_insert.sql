--create sequence autonumerowanie 
--minvalue 0
--maxvalue 9999
--start with 0
--increment by 1;
-- autonumerowanie.nextval

--producenci
INSERT INTO adres VALUES (1,'Warszawa','POLSKA','Sielna',55);
INSERT INTO adres VALUES (2,'Warszawa','POLSKA','Klorowa',15);
INSERT INTO adres VALUES (3,'Poznan','POLSKA','Madalinskiego',165);
INSERT INTO adres VALUES (4,'New York','USA','Maleck',1);
INSERT INTO adres VALUES (5,'LAS Vegas','USA','Corck',1521);
INSERT INTO adres VALUES (6,'Baltimore','USA','Outer Ring',67);

--wedkarze
INSERT INTO adres VALUES (7,'Poznan','POLSKA','Kopernika',77);
INSERT INTO adres VALUES (8,'Bydgoszcz','POLSKA','Fabryczna',45);
INSERT INTO adres VALUES (9,'Wroclaw','POLSKA','Kopernika',32);
INSERT INTO adres VALUES (10,'Poznan','POLSKA','Oczna',3);
INSERT INTO adres VALUES (11,'Ustka','POLSKA','Potoczna',8);
INSERT INTO adres VALUES (12,'Slupsk','POLSKA','Malinowa',15);

-- kola
INSERT INTO adres VALUES (13,'Poznan','POLSKA','Morska',69);
INSERT INTO adres VALUES (14,'Poznan','POLSKA','Kopernika',25);
INSERT INTO adres VALUES (15,'Warszawa','POLSKA','Hallera',99);

-- napęd
INSERT INTO naped VALUES (1,4,'Silnik elektryczny');
INSERT INTO naped VALUES (2,2,'Silnik elektryczny');
INSERT INTO naped VALUES (3,1,'Wiosla');
INSERT INTO naped VALUES (4,4,'Silnik spalinowy');
INSERT INTO naped VALUES (5,6,'Silnik spalinowy');
INSERT INTO naped VALUES (6,7,'Silnik spalinowy');

-- wiatr
INSERT INTO wiatr VALUES (1,0,'brak');
INSERT INTO wiatr VALUES (2,9,'N');
INSERT INTO wiatr VALUES (3,2,'S');
INSERT INTO wiatr VALUES (4,3,'W');
INSERT INTO wiatr VALUES (5,1,'NW');
INSERT INTO wiatr VALUES (6,2,'NW');

-- transport
INSERT INTO transport VALUES (1,'Lodz metalowa',4,3);
INSERT INTO transport VALUES (2,'Ponton',2,1);
INSERT INTO transport VALUES (3,'Ponton',3,2);
INSERT INTO transport VALUES (4,'Lodz metalowa',4,4);
INSERT INTO transport VALUES (5,'Lodz z tworzywa',4,4);
INSERT INTO transport VALUES (6,'Lodz z tworzywa',6,5);

--kola
INSERT INTO kolo_wedkarskie VALUES (1,'Slupia',232,'2000-10-28',13);
INSERT INTO kolo_wedkarskie VALUES (2,'SUM',663,'1982-11-21',14);
INSERT INTO kolo_wedkarskie VALUES (3,'Dolna rzeka',45,'1955-11-24',15);
INSERT INTO kolo_wedkarskie VALUES (4,'Delta',222,'1980-11-21',15);
INSERT INTO kolo_wedkarskie VALUES (5,'Pomorskie kolo wedkarskie',112,'1980-12-31',15);
INSERT INTO kolo_wedkarskie VALUES (6,'Siatka',362,'1978-12-11',15);



--zachmurzenie
INSERT INTO zachmurzenie VALUES (1,'1/8',80);
INSERT INTO zachmurzenie VALUES (2,'3/8',50);
INSERT INTO zachmurzenie VALUES (3,'8/8',70);
INSERT INTO zachmurzenie VALUES (4,'5/8',90);
INSERT INTO zachmurzenie VALUES (5,'4/8',70);
INSERT INTO zachmurzenie VALUES (6,'2/8',65);

--miejsce
INSERT INTO miejsce VALUES (1,'Zarnowiec','Jezioro');
INSERT INTO miejsce VALUES (2,'Dlugie','Jezioro');
INSERT INTO miejsce VALUES (3,'Morskie','Jezioro');
INSERT INTO miejsce VALUES (4,'Glebokie','Jezioro');
INSERT INTO miejsce VALUES (5,'Odra','Rzeka');
INSERT INTO miejsce VALUES (6,'Slupia','Rzeka');


--godzina
INSERT INTO godzina VALUES (1,'wieczor',21);
INSERT INTO godzina VALUES (2,'wieczor',18);
INSERT INTO godzina VALUES (3,'wieczor',19);
INSERT INTO godzina VALUES (4,'wieczor',20);
INSERT INTO godzina VALUES (5,'poludnie',12);
INSERT INTO godzina VALUES (6,'poludnie',11);

--pogoda
INSERT INTO pogoda VALUES (1,11,1020,1,6);
INSERT INTO pogoda VALUES (2,21,1010,1,3);
INSERT INTO pogoda VALUES (3,21,999,1,3);
INSERT INTO pogoda VALUES (4,17,1001,4,3);
INSERT INTO pogoda VALUES (5,19,1003,3,4);
INSERT INTO pogoda VALUES (6,26,1008,2,5);

--wyprawa
INSERT INTO wyprawa VALUES (1,'2016-10-20',5,2,1);
INSERT INTO wyprawa VALUES (2,'2016-10-28',2,4,2);
INSERT INTO wyprawa VALUES (3,'2016-10-27',1,2,4);
INSERT INTO wyprawa VALUES (4,'2016-10-11',2,4,6);
INSERT INTO wyprawa VALUES (5,'2016-10-20',6,5,3);
INSERT INTO wyprawa VALUES (6,'2016-10-28',1,6,6);

TO_DATE('2003/07/09', 'yyyy/mm/dd')


--doswiadczenie
INSERT INTO doswiadczenie VALUES (1,2,100);
INSERT INTO doswiadczenie VALUES (2,7,50);
INSERT INTO doswiadczenie VALUES (3,8,800);
INSERT INTO doswiadczenie VALUES (4,21,1200);
INSERT INTO doswiadczenie VALUES (5,0,20);
INSERT INTO doswiadczenie VALUES (6,2,133);

-- wedkarz
INSERT INTO wedkarz VALUES (1,'Marian','Kowalski','1982-10-21',1,7,5);
INSERT INTO wedkarz VALUES (2,'Michal','Pinori','1982-06-29',3,8,5);
INSERT INTO wedkarz VALUES (3,'Edek','Mak','1983-10-20',3,9,1);
INSERT INTO wedkarz VALUES (4,'Krzysztof','Mag','1984-02-21',4,10,2);
INSERT INTO wedkarz VALUES (5,'Rafal','Duda','1989-10-23',5,11,3);
INSERT INTO wedkarz VALUES (6,'Jaroslaw','Mackiewicz','1995-09-20',6,12,4);

--producent
INSERT INTO producent VALUES (1,'DAM',1);
INSERT INTO producent VALUES (2,'MIKADO',2);
INSERT INTO producent VALUES (3,'BASS',3);
INSERT INTO producent VALUES (4,'OKUMA',4);
INSERT INTO producent VALUES (5,'DRAGON',5);
INSERT INTO producent VALUES (6,'BALZER',6);

--linka
INSERT INTO linka VALUES (1,0.18,1,'Plecionka',6);
INSERT INTO linka VALUES (2,0.22,1,'Plecionka',5);
INSERT INTO linka VALUES (3,0.19,1,'Plecionka',6);
INSERT INTO linka VALUES (4,0.24,1,'Zylka',5);
INSERT INTO linka VALUES (5,0.11,1,'Zylka',6);
INSERT INTO linka VALUES (6,0.11,1,'Plecionka',6);

--przynety
INSERT INTO przyneta VALUES (1,12,'zielony','wobler',6);
INSERT INTO przyneta VALUES (2,12,'czerwony','guma',1);
INSERT INTO przyneta VALUES (3,14,'czerwony','guma',1);
INSERT INTO przyneta VALUES (4,21,'czerwony','guma',2);
INSERT INTO przyneta VALUES (5,8,'czerwony','wirowka',2);
INSERT INTO przyneta VALUES (6,9,'niebieski','wirowka',2);

--kolowrotek
INSERT INTO kolowrotek VALUES (1,9,'stala',1);
INSERT INTO kolowrotek VALUES (2,5,'stala',1);
INSERT INTO kolowrotek VALUES (3,5,'stala',1);
INSERT INTO kolowrotek VALUES (4,3,'stala',1);
INSERT INTO kolowrotek VALUES (5,6,'ruchoma',1);
INSERT INTO kolowrotek VALUES (6,9,'ruchoma',1);

--wedka
INSERT INTO wedka VALUES (1,220,30,3);
INSERT INTO wedka VALUES (2,240,34,3);
INSERT INTO wedka VALUES (3,400,43,3);
INSERT INTO wedka VALUES (4,330,53,3);
INSERT INTO wedka VALUES (5,390,63,4);
INSERT INTO wedka VALUES (6,290,33,4);

--sprzet
INSERT INTO sprzet VALUES (1,3,1,4,2);
INSERT INTO sprzet VALUES (2,2,2,5,4);
INSERT INTO sprzet VALUES (3,2,3,5,5);
INSERT INTO sprzet VALUES (4,3,5,6,3);
INSERT INTO sprzet VALUES (5,5,6,1,1);
INSERT INTO sprzet VALUES (6,1,3,2,2);

--ryba
INSERT INTO ryba VALUES (1,'Szczupak',69,3.1);
INSERT INTO ryba VALUES (2,'Szczupak',77,4.5);
INSERT INTO ryba VALUES (3,'Szczupak',80,5.1);
INSERT INTO ryba VALUES (4,'Szczupak',121,26.1);
INSERT INTO ryba VALUES (5,'Szczupak',46,2.2);
INSERT INTO ryba VALUES (6,'Szczupak',101,12.2);
INSERT INTO ryba VALUES (7,'Okoń',45,3.4);
INSERT INTO ryba VALUES (8,'Okoń',29,1.2);
INSERT INTO ryba VALUES (9,'Sum',112,23.1);
INSERT INTO ryba VALUES (10,'Sum',90,30.1);
INSERT INTO ryba VALUES (11,'Sum',200,49.3);
INSERT INTO ryba VALUES (12,'Sum',190,40.1);

--złowienie_ryby
INSERT INTO zlowienie_ryby VALUES (1,'tak',1,1,1,1,1);
INSERT INTO zlowienie_ryby VALUES (2,'tak',2,2,2,2,2);
INSERT INTO zlowienie_ryby VALUES (3,'tak',3,3,4,3,3);
INSERT INTO zlowienie_ryby VALUES (4,'tak',4,4,4,4,4);
INSERT INTO zlowienie_ryby VALUES (5,'tak',5,5,4,4,5);
INSERT INTO zlowienie_ryby VALUES (6,'tak',6,5,5,4,5);
INSERT INTO zlowienie_ryby VALUES (7,'nie',7,6,6,6,6);
INSERT INTO zlowienie_ryby VALUES (8,'nie',8,3,1,1,6);
INSERT INTO zlowienie_ryby VALUES (9,'tak',9,3,2,2,1);
INSERT INTO zlowienie_ryby VALUES (10,'tak',10,4,3,2,2);
INSERT INTO zlowienie_ryby VALUES (11,'tak',11,3,4,3,6);
INSERT INTO zlowienie_ryby VALUES (12,'tak',12,6,5,4,6);
