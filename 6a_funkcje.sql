-- Autor Krzysztof Karkuciński nr indeksu 175846

-- FUNKCJE
--1. Prosta funkcje zliczająca wszystkich wedkarzy w bazie
CREATE FUNCTION Liczba_Wedkarzy RETURN NUMBER IS
v_liczba_w NUMBER(5);
BEGIN
SELECT count(*) INTO v_liczba_w FROM wedkarz;
RETURN v_liczba_w;
END;

-- wywołanie
BEGIN
DBMS_OUTPUT.PUT_LINE(LICZBA_WEDKARZY);
END;


--2. Funkcja sprawdza ile wypraw wędkarskich było przeprowadzonych przed datą która jest wpisywana jako parametr w funkcji ile_wypraw_przed
CREATE OR REPLACE FUNCTION ile_wypraw_przed(p_data DATE) RETURN INTEGER IS
 v_ile_wypraw INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_ile_wypraw FROM wyprawa w WHERE w.data < p_data;
  RETURN v_ile_wypraw;
END;

-- wywołanie
SELECT * FROM wyprawa;
BEGIN
DBMS_OUTPUT.PUT_LINE(ile_wypraw_przed('2016-10-18'));
DBMS_OUTPUT.PUT_LINE(ile_wypraw_przed(SYSDATE));
END;


--3. Funkcja która na podstwaie ID wedkarza dostarczanego jako parametr oblicza jego wiek.
CREATE OR REPLACE FUNCTION Ile_Lat (p_id IN NUMBER)
RETURN NUMBER IS
v_ile_lat NUMBER(4);
v_data DATE;
BEGIN
SELECT data_ur INTO v_data FROM wedkarz WHERE ID_WEDKARZ=p_id;
v_ile_lat := ROUND(MONTHS_BETWEEN(sysdate, v_data)/12,0);
RETURN v_ile_lat;
END;

--wywołanie
BEGIN
DBMS_OUTPUT.PUT_LINE('Wędkarz ten ma '||Ile_Lat(7)||' lat.');
END;


--4. Funkcja sprawdza ile w bazie jest ryb które są większe niż wpisany parametr funkcji ile_wiekszych
CREATE OR REPLACE FUNCTION ile_wiekszych(p_dlugosc IN INT) RETURN INT IS
  CURSOR ryby IS SELECT * FROM ryba;
  v_licznik INT := 0;
BEGIN
  FOR i IN ryby LOOP
    IF (i.dlugosc > p_dlugosc) THEN
      v_licznik := v_licznik + 1;
    END IF;
  END LOOP;
  RETURN v_licznik;
END;

--wywołanie
BEGIN
  DBMS_OUTPUT.PUT_LINE(ile_wiekszych(200));
END;


--5. Funkcja sprawdza czy dana ryba jest czesto poławiana czy raczej sporadycznie. 
 CREATE OR REPLACE FUNCTION czy_czesto_lapana(
    v_gatunek ryba.gatunek%TYPE)
    RETURN BOOLEAN IS
    v_ilosc NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_ilosc FROM ryba WHERE gatunek=v_gatunek;
    IF v_ilosc>2 THEN
    RETURN TRUE;
    ELSE
    RETURN FALSE;
    END IF;
END;
    
-- wywołanie	
-- Zamiast 'Sum' jako parametr można również podać 'Szczupak' lub 'Okoń'
    SET SERVEROUTPUT ON;
    BEGIN
    IF (czy_czesto_lapana('Sum')) THEN
    DBMS_OUTPUT.PUT_LINE('tak');
    ELSE
    DBMS_OUTPUT.PUT_LINE('nie');
    END IF;
    END;
	
