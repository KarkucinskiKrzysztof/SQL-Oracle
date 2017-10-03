--GR. P

--ZADANIA NA KOLOKWIUM

--Data: 
--Imię: 
--Nazwisko: 
--Semestr: 
--Specjalność: brak

--P1. Utwórz typ obiektowy o nazwie t_pracownik zawierający atrybuty: id, imie, 
--nazwisko, data_zatrudnienia, pensja, dodatek (dodatek może wynosić NULL) 
--oraz metodę funkcję o nazwie staz zwracającą informację ile lat jest zatrudniony dany pracownik.
--Utwórz tabelę pracownik typu obiektowego t_pracownik i dodaj do niej co najmniej 4 rekordy, 
--w tym dodaj co najmniej 1 pracownika posiadającego dodatek równy NULL.
--Napisać instrukcję testującą działanie utworzonej metody funkcji staz.

--Rozwiązanie:
CREATE TYPE t_pracownik
AS OBJECT(
   id INT,
   imie	VARCHAR2(25),
   nazwisko VARCHAR2(25),
   data_zatrudnienia DATE,
   pensja INT,
   dodatek INT,
   MEMBER FUNCTION staz RETURN INT);
/

CREATE TYPE BODY t_pracownik AS
   MEMBER FUNCTION staz RETURN INT IS
   BEGIN
      RETURN (EXTRACT(year from SYSDATE)-EXTRACT(year from data_zatrudnienia));
   END staz;
END;
/

CREATE TABLE pracownik OF t_pracownik;
INSERT INTO pracownik VALUES (1, 'Jacek', 'Jackowski', SYSDATE, 2000, 20);
INSERT INTO pracownik VALUES (2, 'Wacek', 'Wackowski', SYSDATE, 3000, NULL);
INSERT INTO pracownik VALUES (3, 'Franek', 'Frankowski', SYSDATE, 4000, 20);
INSERT INTO pracownik VALUES (4, 'Janek', 'Jankowski', SYSDATE, 5000, 20);
INSERT INTO pracownik VALUES (5, 'Test', 'Testowy', '13/01/07', 6000, 50);

--Test poprawności rozwiązania:
SELECT * FROM PRACOWNIK;
SELECT p.staz() FROM pracownik p WHERE p.id = 5; 


--Instrukcja usuwająca utworzoną tabelę i utworzony typ obiektowy:
DROP TABLE pracownik;
DROP TYPE t_pracownik;


--P2. Napisz procedurę o nazwie oszczednosci, która w tabeli pracownik (patrz zadanie P1) 
--dwóm osobom najwięcej zarabiającym (pensja+dodatek) obniży pensję o 5%. Uwzględnij miejsca ex aequo.
--Do tabeli pracownik dodaj kolejne rekordy, tak aby było trzech pracowników zarabiających 
--najwyższą co do wartości pensję+dodatek.
--Zademonstruj działanie utworzonej procedury.

--Rozwiązanie:
CREATE OR REPLACE PROCEDURE oszczednosci IS
  CURSOR najw_zarab_pracownicy IS
    SELECT * FROM pracownik ORDER BY (pracownik.pensja) DESC;
  v_licznik INT := 0;
  v_znaleziono_conajmniej_dwoch BOOLEAN;
  v_ostatnie_zarobki INT;
  v_obecne_zarobki INT;
BEGIN
  v_znaleziono_conajmniej_dwoch := FALSE;
  FOR i IN najw_zarab_pracownicy LOOP
    v_obecne_zarobki := (i.pensja + i.dodatek);
    EXIT WHEN (v_znaleziono_conajmniej_dwoch AND (v_obecne_zarobki < v_ostatnie_zarobki));
    v_ostatnie_zarobki := (i.pensja + i.dodatek);
    i.pensja := 0.95 * i.pensja;
    v_licznik := v_licznik + 1;
    IF v_licznik >= 2 THEN
      v_znaleziono_conajmniej_dwoch := TRUE;
    END IF;
  END LOOP;
  COMMIT;
END;


--Test poprawności rozwiązania:
SELECT * FROM pracownik;
EXEC oszczednosci;
SELECT * FROM pracownik;


--Instrukcja usuwająca utworzoną procedurę:



--P3. Napisać funkcję o nazwie sprawdz posiadającą jeden parametr p_dodatek i zwracającą 
--informację ilu pracowników (wykorzystaj tabele pracownik z zadania P1)
--posiada dodatek niższy niż dodatek zadany parametrem p_dodatek.
--Zademonstruj działanie zaimplementowanej funkcji.

--Rozwiązanie:
CREATE OR REPLACE FUNCTION sprawdz(p_dodatek IN INT) RETURN INT IS
  CURSOR pracownicy IS SELECT * FROM pracownik;
  v_licznik INT := 0;
BEGIN
  FOR i IN pracownicy LOOP
    IF (i.dodatek < p_dodatek) THEN
      v_licznik := v_licznik + 1;
    END IF;
  END LOOP;
  RETURN v_licznik;
END;

--Test poprawności rozwiązania:
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE(sprawdz(51));
END;

--Instrukcja usuwająca utworzoną funkcję:
DROP FUNCTION sprawdz;




--P4. Rozwiązania zadań P2-P3 umieść w pakiecie o nazwie pakiecik i zademonstruj, że one działają.
--Dodatkowo przeciąż dowolnie wybraną funkcję lub procedurę (napisz co realizuje zaimplementowane przeciążenie).

--Rozwiązanie:
CREATE OR REPLACE PACKAGE pakiecik AS
  PROCEDURE oszczednosci;
  FUNCTION sprawdz(p_dodatek IN INT) RETURN INT;
END;
/
CREATE OR REPLACE PACKAGE BODY pakiecik IS

  PROCEDURE oszczednosci IS
    CURSOR najw_zarab_pracownicy IS
      SELECT * FROM pracownik ORDER BY (pracownik.pensja) DESC;
    v_licznik INT := 0;
    v_znaleziono_conajmniej_dwoch BOOLEAN;
    v_ostatnie_zarobki INT;
    v_obecne_zarobki INT;
  BEGIN
    v_znaleziono_conajmniej_dwoch := FALSE;
    FOR i IN najw_zarab_pracownicy LOOP
      v_obecne_zarobki := (i.pensja + i.dodatek);
      EXIT WHEN (v_znaleziono_conajmniej_dwoch AND (v_obecne_zarobki < v_ostatnie_zarobki));
      v_ostatnie_zarobki := (i.pensja + i.dodatek);
      i.pensja := 0.95 * i.pensja;
      v_licznik := v_licznik + 1;
      IF v_licznik >= 2 THEN
        v_znaleziono_conajmniej_dwoch := TRUE;
      END IF;
    END LOOP;
    COMMIT;
  END oszczednosci;
  
  FUNCTION sprawdz(p_dodatek IN INT) RETURN INT IS
    CURSOR pracownicy IS SELECT * FROM pracownik;
    v_licznik INT := 0;
  BEGIN
    FOR i IN pracownicy LOOP
      IF (i.dodatek < p_dodatek) THEN
        v_licznik := v_licznik + 1;
      END IF;
    END LOOP;
    RETURN v_licznik;
  END;

END pakiecik;


--Test poprawności rozwiązania (uruchom wszystkie funkcje i procedury z pakietu):
PAKIECIK.OSZCZEDNOSCI;
BEGIN
  DBMS_OUTPUT.PUT_LINE(PAKIECIK.SPRAWDZ(21));
END;

--Usuwamy utworzony pakiet (całkowicie):
DROP PACKAGE BODY pakiecik;
DROP PACKAGE pakiecik;


--P5. Uniemożliwić w istniejącej tabeli pracownik (patrz zadanie P1) przypisanie 
--wartości data_zatrudnienia wcześniejszej niż 50 lat temu i późniejszej niż bieżąca data.

--Rozwiązanie
CREATE OR REPLACE TRIGGER sprawdz_date BEFORE INSERT OR UPDATE on pracownik
FOR EACH ROW 
DECLARE
  v_dzien_dzis INT;
  v_miesiac_dzis INT;
  v_rok_dzis INT;
  e_stara_data EXCEPTION;
  e_zbyt_nowa_data EXCEPTION;
BEGIN
  v_dzien_dzis := EXTRACT(day from SYSDATE);
  v_miesiac_dzis := EXTRACT(month from SYSDATE);
  v_rok_dzis := EXTRACT(year from SYSDATE);
  
  IF ((EXTRACT(year from SYSDATE)-EXTRACT(year from :new.data_zatrudnienia) > 50))
    THEN RAISE e_stara_data;
  END IF;
  
  IF (v_rok_dzis <= EXTRACT(year from :new.data_zatrudnienia)) AND  
     (v_miesiac_dzis <= EXTRACT(month from :new.data_zatrudnienia)) AND 
     (v_dzien_dzis < EXTRACT(day from :new.data_zatrudnienia)) THEN
    RAISE e_zbyt_nowa_data;
  END IF;
  
EXCEPTION
  WHEN e_stara_data THEN
    DBMS_OUTPUT.PUT_LINE('Podana data jest starsza niz 50 lat.');
  WHEN e_zbyt_nowa_data THEN
    DBMS_OUTPUT.PUT_LINE('Podana data jest w przyszlosci!');
END;


--Testujemy poprawność rozwiązania:
INSERT INTO pracownik VALUES (6, 'Test', 'Testowy', '2018/02/10', 6000, 50);
INSERT INTO pracownik VALUES (7, 'Test', 'Testowy', '1920/01/10', 6000, 50);
INSERT INTO pracownik VALUES (8, 'Poprawny', 'Poprawny', '2015/01/07', 6000, 50);

SELECT * FROM pracownik;

--Instrukcja usuwająca utworzone obiekty:
DROP TRIGGER sprawdz_date;
DROP TABLE pracownik;

