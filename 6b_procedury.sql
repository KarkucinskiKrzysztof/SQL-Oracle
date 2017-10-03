-- Autor Krzysztof Karkuciñski nr indeksu 175846

-- PROCEDURY

--1. Zwiekszenie wszystkich d³ugoœci ryb w tabeli ryba
CREATE OR REPLACE PROCEDURE zwiekszenie_rozmiaru_ryb IS 
v_wydluzenie number := 20;
BEGIN 
UPDATE ryba SET dlugosc=dlugosc+v_wydluzenie;
END;

-- wywo³anie
SELECT dlugosc FROM ryba;
EXECUTE ZWIEKSZENIE_ROZMIARU_RYB;
SELECT dlugosc FROM ryba;

--2. Procedura wyœwietla ³¹czn¹ d³ugoœc i ciê¿ar z³apanych ryb oraz zlicza iloœæ z³apanych sztuk poszczegunlych gatunków.
CREATE OR REPLACE PROCEDURE suma
IS 
v_dlugosc NUMBER;
v_waga NUMBER(8,2);
v_szczupaki NUMBER;
v_okonie NUMBER;
v_sumy NUMBER;
BEGIN 
SELECT SUM(dlugosc) INTO v_dlugosc FROM ryba;
SELECT SUM(ciezar) INTO v_waga FROM ryba;
SELECT COUNT(gatunek) INTO v_szczupaki FROM ryba WHERE gatunek='Szczupak';
SELECT COUNT(gatunek) INTO v_okonie FROM ryba WHERE gatunek='Okoñ';
SELECT COUNT(gatunek) INTO v_sumy FROM ryba WHERE gatunek='Sum';
DBMS_OUTPUT.PUT_LINE('Cakowita dugoœæ zapanych ryb to: '||v_dlugosc||' cm ,natomiast ich l¹czna waga wynosi: '||v_waga||' kg.');
DBMS_OUTPUT.PUT_LINE(v_szczupaki||' szczupaków '||', '||v_okonie||' okoni oraz '||v_sumy||' sumy.');
END;

-- wywo³anie
EXECUTE suma;


--3.  Zwiekszenie masy  dowolnej konkretnej ryby podaj¹c przy tym o ile masa ma byæ zwiekszona 
CREATE OR REPLACE PROCEDURE zwiekszenie_ciezaru_ryby (
v_id IN ryba.id_ryby%TYPE,
v_dodatkowa_waga IN ryba.ciezar%TYPE)
IS 
BEGIN 
UPDATE ryba SET ciezar=ciezar+v_dodatkowa_waga WHERE id_ryby=v_id;
END;

-- wywo³anie
SELECT * FROM ryba;    
EXECUTE zwiekszenie_ciezaru_ryby(1,7.99);


--4.  Procedura wyœwietla w³aœciwoœci przynety na podstawie jej id które wpisujemy jako parametr procedury
CREATE OR REPLACE PROCEDURE parametry_przynety (
v_id IN przyneta.id_przynety%TYPE)
IS 
v_rozmiar NUMBER;
v_kolor VARCHAR2(40);
v_typ VARCHAR2(40);
BEGIN 
SELECT rozmiar INTO v_rozmiar FROM przyneta WHERE id_przynety=v_id;
SELECT kolor INTO v_kolor FROM przyneta WHERE id_przynety=v_id;
SELECT typ INTO v_typ FROM przyneta WHERE id_przynety=v_id;
DBMS_OUTPUT.PUT_LINE('Rozmiar przynety to: '||v_rozmiar||' cm, kolor: '||v_kolor||', oraz typ : '||v_typ);
END;

-- wywo³anie    
EXECUTE parametry_przynety(2);


--5. Dodawanie wêdkarza do tabeli wedkarz  z automatycznym generowaniem ID
CREATE OR REPLACE PROCEDURE dodajWedkarza(
    v_imie IN wedkarz.imie%TYPE,
    v_nazwisko IN wedkarz.nazwisko%TYPE,
    v_data_ur IN wedkarz.data_ur%TYPE,
    v_kolo_wedkarskie_id_kola IN wedkarz.kolo_wedkarskie_id_kola%TYPE,
    v_adres_id_adres IN wedkarz.adres_id_adres%TYPE,
    v_doswiadczenie IN wedkarz.doswiadczenie_id_doswiadczenie%TYPE)
    IS
    v_id number;
    BEGIN
    SELECT MAX(id_wedkarz) INTO v_id FROM wedkarz;
    v_id:=v_id+1;
    INSERT INTO wedkarz VALUES(v_id,v_imie,v_nazwisko,v_data_ur,v_kolo_wedkarskie_id_kola,v_adres_id_adres,v_doswiadczenie);
    COMMIT;
    END;
    
-- wywo³anie	
    EXECUTE dodajWedkarza('Piotr','Drabina','1999-01-02',1,12,3);
    SELECT imie,nazwisko FROM wedkarz;














