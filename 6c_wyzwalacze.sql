-- Autor Krzysztof Karkuciñski nr indeksu 175846

--  TRIGGERS 

-- 1. Wyzwalacz - sugeruje wpisanie zbyt du¿ych wartoœci.
CREATE OR REPLACE TRIGGER za_duzy_rozmiar
AFTER UPDATE OR INSERT ON ryba
FOR EACH ROW
WHEN (new.dlugosc > 250)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ponad 250 cm ? nie pomyli³eœ sie ?');
END;

INSERT INTO ryba VALUES (15,'Jesiotr',280,43);


-- 2. Wyzwalacz - nazwa kraju zawsze bedzie wpisana wielkimi literami
CREATE OR REPLACE TRIGGER nazwa_kraju_wielkie_litery
BEFORE UPDATE OR INSERT ON adres
FOR EACH ROW
BEGIN
:NEW.kraj := Upper(:NEW.kraj);
END;

--wywo³anie
INSERT INTO adres VALUES (16,'polska','Gdañsk','Hallera',43);
SELECT * FROM adres WHERE id_adres=16;

-- 3. Wyzwalacz - archiwizacja producentów podczas ich usuwania i zapisywanie usuwanych wierszy w inne tabeli 
CREATE OR REPLACE TRIGGER archiwizacja_producentow
BEFORE DELETE ON producent
FOR EACH ROW
BEGIN
    INSERT INTO producent_archiwum VALUES (:OLD.id_producenta,:OLD.nazwa,:OLD.adres_id_adres);
END;

--wywo³anie
INSERT INTO producent VALUES (7,'SUNTO',12);
DELETE FROM producent WHERE nazwa='SUNTO';
SELECT * FROM producent_archiwum;


-- 4. Wyzwalacz - wyœwietlanie przeprowadzanych operacji na tabeli wedkarz
CREATE OR REPLACE TRIGGER wyswietlanie_zmian_wedkarzy
BEFORE DELETE OR INSERT OR UPDATE ON wedkarz
FOR EACH ROW
BEGIN 
IF INSERTING THEN DBMS_OUTPUT.PUT_LINE('Dodany wêdkarz: '||:NEW.imie||' '||:NEW.nazwisko);
ELSIF UPDATING THEN DBMS_OUTPUT.PUT_LINE('Zmieniony wêdkarz: '||:OLD.imie||' '||:OLD.nazwisko); 
ELSIF DELETING THEN DBMS_OUTPUT.PUT_LINE('Usuniety wêdkarz: '||:OLD.imie||' '||:OLD.nazwisko);
END IF;
END;

--wywo³anie
INSERT INTO wedkarz VALUES (9,'Marian','Opania','1943-02-01',1,1,3);
UPDATE wedkarz SET adres_id_adres=3 WHERE id_wedkarz=9;
DELETE FROM wedkarz WHERE id_wedkarz=9;


--5. Wyzwalacz - historia zmian na tabeli ryba zapisywana do innej tabeli w której mamy czas zmiany rodzaj zmiany i gatunek który zosta³ zmieniony/usuniety/dodany 
CREATE OR REPLACE TRIGGER historia_zmian
BEFORE DELETE OR INSERT OR UPDATE ON ryba
FOR EACH ROW
BEGIN 
IF INSERTING THEN INSERT INTO ryba_zmiany VALUES(SYSDATE,'Wstawienie wiersza',:NEW.gatunek);
ELSIF UPDATING THEN INSERT INTO ryba_zmiany VALUES(SYSDATE,'Zmiana wiersza',:OLD.gatunek);
ELSIF DELETING THEN INSERT INTO ryba_zmiany VALUES(SYSDATE,'Usuwanie wiersza',:OLD.gatunek);
END IF;
END;

--wywo³anie
INSERT INTO ryba VALUES (13,'Kleñ',60,3.3);
DELETE FROM ryba WHERE id_ryby=13;
SELECT * FROM ryba_zmiany;