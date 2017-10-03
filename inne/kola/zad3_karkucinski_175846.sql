-- zadanie 1
SET SERVEROUTPUT ON
SET AUTOPRINT ON;               -- czy ; jest tu potrzebny
<<etykieta_zewnetrzna>>
DECLARE
VARIABLE v_wynik NUMBER:=1;
v_liczba NUMBER(10):=&Prosze_o_podanie_liczby;
BEGIN 
  DECLARE
  v_liczba NUMBER(10):=&Prosze_o_podanie_liczby;
  BEGIN 
  :v_wynik:=etykieta_zewnetrzna.v_liczba*v_liczba;
  DBMS_OUTPUT.PUT_LINE(:v_wynik);
  END;
END;
PRINT v_wynik;


--zadanie 2
CREATE TABLE buty(id_buty INT,typ VARCHAR2(20),marka VARCHAR2(20),rozmiar NUMBER(8,2));
INSERT INTO buty VALUES(1,'sportowe','nike',44);
INSERT INTO buty VALUES(2,'sportowe','reebok',45);
INSERT INTO buty VALUES(3,'pantofle','fly-high',46); 

DECLARE
v_liczba NUMBER(10):=&Podaj_rozmiar_buta;
v_rekord1 buty.rozmiar%TYPE;
v_rekord2 buty.rozmiar%TYPE;
v_rekord3 buty.rozmiar%TYPE;
BEGIN
SELECT rozmiar INTO v_rekord1 FROM buty WHERE id_buty=1;
SELECT rozmiar INTO v_rekord2 FROM buty WHERE id_buty=2;
SELECT rozmiar INTO v_rekord3 FROM buty WHERE id_buty=3;
IF v_liczba IN (v_rekord1,v_rekord2,v_rekord3) THEN
DBMS_OUTPUT.PUT_LINE('Posiadamy buty w Twoim rozmiarze');
ELSE
DBMS_OUTPUT.PUT_LINE('Nie posiadamy butów w Twoim rozmiarze');
END IF;
END;

--zadanie 3
DECLARE 
v_liczba NUMBER(10):=&Podaj_liczbe;
v_slownie VARCHAR2(30);
BEGIN
CASE v_liczba
WHEN 1 THEN v_slownie:='Styczeñ';
WHEN 2 THEN v_slownie:='Luty';
WHEN 3 THEN v_slownie:='Marzec';
WHEN 4 THEN v_slownie:='Kwiecieñ';
WHEN 5 THEN v_slownie:='Maj';
WHEN 6 THEN v_slownie:='Czerwiec';
WHEN 7 THEN v_slownie:='Lipiec';
WHEN 8 THEN v_slownie:='Sierpieñ';
WHEN 9 THEN v_slownie:='Wrzesieñ';
WHEN 10 THEN v_slownie:='Pa¿dziernik';
WHEN 11 THEN v_slownie:='Listopad';
WHEN 12 THEN v_slownie:='Grudzieñ';
ELSE v_slownie:='NIe ma takiego miesi¹ca';
END CASE;
DBMS_OUTPUT.PUT_LINE(v_slownie);
END;

--zadanie 4
CREATE TABLE student (id_student NUMBER(11), imie VARCHAR2(15),nazwisko VARCHAR2(20), srednia NUMBER(4,2), stypendium NUMBER(8,2));
INSERT INTO student VALUES (1,'Jan','Kowalski',5,2000);
INSERT INTO student VALUES (2,'Anna','Zdolna',4, 1000);
INSERT INTO student VALUES (3,'Agata','Muza',3.5, 100);
INSERT INTO student VALUES (4,'Anna','Kula',3, 1);
INSERT INTO student VALUES (5,'Kacper','Adamek',2, 0);

DECLARE
v_liczba NUMBER(10):=&Podaj_id_studenta;
v_stypendium NUMBER(10);
v_avg NUMBER(5,2):=775.25;
BEGIN
SELECT stypendium INTO v_stypendium FROM student WHERE id_student=v_liczba;
DBMS_OUTPUT.PUT_LINE(v_stypendium);
IF (v_stypendium=2000) THEN DBMS_OUTPUT.PUT_LINE('Stypendium najwy¿sze ');
ELSIF (v_stypendium=1) THEN DBMS_OUTPUT.PUT_LINE('Stypendium najni¿sze ');
ELSIF (v_stypendium!=2000 AND v_stypendium!=1 AND v_stypendium<v_avg) THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest mniejsze od œredniej ');
ELSE DBMS_OUTPUT.PUT_LINE('Stypendium jest wieksza od œredniej ');
END IF;
END;

-- zadanie 5
DECLARE
v_liczba NUMBER(10):=&Podaj_id_studenta;
v_stypendium NUMBER(10);
v_avg NUMBER(5,2):=775.25;
BEGIN
SELECT stypendium INTO v_stypendium FROM student WHERE id_student=v_liczba;
DBMS_OUTPUT.PUT_LINE(v_stypendium);
CASE
WHEN  v_stypendium=2000 THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest najwieksze ');
WHEN  v_stypendium=1 THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest najmniejsze ');
WHEN  v_stypendium=1000 THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest powy¿ej œredniej ');
WHEN  v_stypendium=100 THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest poni¿ej œredniej ');
WHEN  v_stypendium=0 THEN DBMS_OUTPUT.PUT_LINE('Stypendium jest poni¿ej œrednie ');
END CASE;
END;


-- Zadanie 6

-- Zadanie 7
DECLARE
v_litera VARCHAR2(1):='C';
BEGIN
CASE v_litera
WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE (TO_CHAR (SYSDATE,'HH24:MI:SS'));
WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE (TO_CHAR (SYSDATE, 'YYYY-MM-DD'));
END CASE;
END;

-- DBMS_OUTPUT.put_line (TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
