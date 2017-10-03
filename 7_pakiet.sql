-- Autor Krzysztof Karkuciñski nr indeksu 175846

CREATE OR REPLACE PACKAGE projekt IS 
  FUNCTION Liczba_Wedkarzy RETURN NUMBER;
  FUNCTION ile_wypraw_przed(p_data DATE) RETURN INTEGER;
  FUNCTION ile_wypraw_przed(p_data DATE,p_do DATE) RETURN INTEGER;   -- PRZECIAZONA FUNKCJA
  FUNCTION Ile_Lat (p_id IN NUMBER) RETURN NUMBER;
  FUNCTION ile_wiekszych(p_dlugosc IN INT) RETURN INT;
  FUNCTION czy_czesto_lapana(v_gatunek ryba.gatunek%TYPE)RETURN BOOLEAN;
  PROCEDURE zwiekszenie_rozmiaru_ryb;
  PROCEDURE suma;
  PROCEDURE zwiekszenie_ciezaru_ryby (v_id IN ryba.id_ryby%TYPE,v_dodatkowa_waga IN ryba.ciezar%TYPE);
  PROCEDURE parametry_przynety (v_id IN przyneta.id_przynety%TYPE);
  PROCEDURE dodajWedkarza(
    v_imie IN wedkarz.imie%TYPE,
    v_nazwisko IN wedkarz.nazwisko%TYPE,
    v_data_ur IN wedkarz.data_ur%TYPE,
    v_kolo_wedkarskie_id_kola IN wedkarz.kolo_wedkarskie_id_kola%TYPE,
    v_adres_id_adres IN wedkarz.adres_id_adres%TYPE,
    v_doswiadczenie IN wedkarz.doswiadczenie_id_doswiadczenie%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY projekt IS 

-- FUNKCJE
--1. Prosta funkcje zliczaj¹ca wszystkich wedkarzy w bazie
FUNCTION Liczba_Wedkarzy RETURN NUMBER IS
v_liczba_w NUMBER(5);
BEGIN
SELECT count(*) INTO v_liczba_w FROM wedkarz;
RETURN v_liczba_w;
END;

--2. Funkcja sprawdza ile wypraw wêdkarskich by³o przeprowadzonych przed dat¹ która jest wpisywana jako parametr w funkcji ile_wypraw_przed
FUNCTION ile_wypraw_przed(p_data DATE) RETURN INTEGER IS
 v_ile_wypraw INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_ile_wypraw FROM wyprawa w WHERE w.data < p_data;
  RETURN v_ile_wypraw;
END;

FUNCTION ile_wypraw_przed(p_data DATE,p_do DATE) RETURN INTEGER IS  -- PRZECIAZONA FUNKCJA
 v_ile_wypraw INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_ile_wypraw FROM wyprawa w WHERE w.data < p_data AND w.data > p_do;
  RETURN v_ile_wypraw;
END;

--3. Funkcja która na podstwaie ID wedkarza dostarczanego jako parametr oblicza jego wiek.
FUNCTION Ile_Lat (p_id IN NUMBER) RETURN NUMBER IS
v_ile_lat NUMBER(4);
v_data DATE;
BEGIN
SELECT data_ur INTO v_data FROM wedkarz WHERE ID_WEDKARZ=p_id;
v_ile_lat := ROUND(MONTHS_BETWEEN(sysdate, v_data)/12,0);
RETURN v_ile_lat;
END;

--4. Funkcja sprawdza ile w bazie jest ryb które s¹ wiêksze ni¿ wpisany parametr funkcji ile_wiekszych
FUNCTION ile_wiekszych(p_dlugosc IN INT) RETURN INT IS
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

--5. Funkcja sprawdza czy dana ryba jest czesto po³awiana czy raczej sporadycznie. 
FUNCTION czy_czesto_lapana(v_gatunek ryba.gatunek%TYPE)RETURN BOOLEAN IS
v_ilosc NUMBER;
BEGIN
SELECT COUNT(*) INTO v_ilosc FROM ryba WHERE gatunek=v_gatunek;
IF v_ilosc>2 THEN
RETURN TRUE;
ELSE
RETURN FALSE;
END IF;
END;
    
-- PROCEDURY
--1. Zwiekszenie wszystkich d³ugoœci ryb w tabeli ryba
PROCEDURE zwiekszenie_rozmiaru_ryb IS 
v_wydluzenie number := 20;
BEGIN 
UPDATE ryba SET dlugosc=dlugosc+v_wydluzenie;
END;

--2. Procedura wyœwietla ³¹czn¹ d³ugoœc i ciê¿ar z³apanych ryb oraz zlicza iloœæ z³apanych sztuk poszczegunlych gatunków.
PROCEDURE suma
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

--3.  Zwiekszenie masy  dowolnej konkretnej ryby podaj¹c przy tym o ile masa ma byæ zwiekszona 
PROCEDURE zwiekszenie_ciezaru_ryby (
v_id IN ryba.id_ryby%TYPE,
v_dodatkowa_waga IN ryba.ciezar%TYPE)
IS 
BEGIN 
UPDATE ryba SET ciezar=ciezar+v_dodatkowa_waga WHERE id_ryby=v_id;
END;

--4.  Procedura wyœwietla w³aœciwoœci przynety na podstawie jej id które wpisujemy jako parametr procedury
PROCEDURE parametry_przynety (
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
    
--5. Dodawanie wêdkarza do tabeli wedkarz  z automatycznym generowaniem ID
PROCEDURE dodajWedkarza(
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
END;





-- sprawdzenie poprawnoœci dziaania funkcji i procedur
BEGIN
    -- FUNKCJE
	
    -- funkcja 1
    DBMS_OUTPUT.PUT_LINE(projekt.LICZBA_WEDKARZY);
    -- funkcja 2
    DBMS_OUTPUT.PUT_LINE(projekt.ile_wypraw_przed('2016-10-18'));
    -- funkcja 2 - przeciazenie
    DBMS_OUTPUT.PUT_LINE(projekt.ile_wypraw_przed('2016-10-18','2016-10-10'));
    -- funkcja 3
    DBMS_OUTPUT.PUT_LINE('Wêdkarz ten ma '||projekt.Ile_Lat(7)||' lat.');
    -- funkcja 4
    DBMS_OUTPUT.PUT_LINE(projekt.ile_wiekszych(200));
    -- funkcja 5
    IF (czy_czesto_lapana('Sum')) THEN
    DBMS_OUTPUT.PUT_LINE('tak');
    ELSE
    DBMS_OUTPUT.PUT_LINE('nie');
    END IF;
    
    -- PROCEDURY
	
    -- procedura 1
    projekt.zwiekszenie_rozmiaru_ryb;
    -- procedura 2
    projekt.suma;
    -- procedura 3
    projekt.zwiekszenie_ciezaru_ryby(1,7.99);
    -- procedura 4
    projekt.parametry_przynety(3);
    -- procedura 5
    projekt.dodajWedkarza('Edek','Mak','1983-10-20',3,9,1);
END;