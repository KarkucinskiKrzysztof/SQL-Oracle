--zadanie 1
SET SERVEROUTPUT ON
DECLARE
v_napis VARCHAR2(30):= 'Napis do wyswietlenia';
v_zmienna NUMBER(6,4):= 2.7123;
BEGIN
DBMS_OUTPUT.PUT_LINE(v_napis||'  '||v_zmienna);
END;

--zadanie 2
DECLARE
v_liczbaa NUMBER(10):=&Prosze_o_podanie_liczby_A;
v_liczbab NUMBER(10):=&Prosze_o_podanie_liczby_B;
BEGIN 
DBMS_OUTPUT.PUT_LINE('Mnozenie a*b = '||v_liczbaa*v_liczbab);
END;

--zadanie 3
DECLARE
c_pi CONSTANT NUMBER(10,8) := 3.14159265;
v_promien_kuli NUMBER(10,2):=&podaj_promien_kuli;
v_wynik_objetosc NUMBER(20,8):= (4/3)*c_pi*v_promien_kuli*v_promien_kuli*v_promien_kuli;
v_wynik_pole NUMBER(20,8):= (4*c_pi*v_promien_kuli*v_promien_kuli);
BEGIN
DBMS_OUTPUT.PUT_LINE('Pole powierzchni cakowitej to: '||v_wynik_pole);
DBMS_OUTPUT.PUT_LINE('Objetoœæ kuli to: '||v_wynik_objetosc);
END;

-- zadanie 4
CREATE TABLE pracownik
  (
    id_pracownik    NUMBER (10) NOT NULL ,
    imie            VARCHAR2 (40) NOT NULL ,
    nazwisko        VARCHAR2 (40) NOT NULL 
    );
ALTER TABLE pracownik ADD CONSTRAINT pracownik2_PK PRIMARY KEY ( id_pracownik ) ;
INSERT INTO pracownik VALUES (1,'Jan','Kowalski');
INSERT INTO pracownik VALUES (2,'Jerzy','Nowak');
INSERT INTO pracownik VALUES (3,'Anna','Galka');
INSERT INTO pracownik VALUES (4,'Hanna','Mialka');


SET SERVEROUTPUT ON
DECLARE
v_ilosc NUMBER(10);
BEGIN 
SELECT COUNT(*) INTO v_ilosc FROM pracownik;
DBMS_OUTPUT.PUT_LINE('W tabeli Pracownik jest '||v_ilosc||' rekordów');
END;

--zadanie 5
SET SERVEROUTPUT ON
DECLARE
v_imie pracownik.imie%TYPE;
v_nazwisko pracownik.nazwisko%TYPE;
BEGIN 
SELECT imie INTO v_imie FROM pracownik WHERE id_pracownik=3;
SELECT nazwisko INTO v_nazwisko FROM pracownik WHERE id_pracownik=3;
DBMS_OUTPUT.PUT_LINE('W tabeli Pracownik id=3 odpowieda imie: '||v_imie||' nazwisko: '||v_nazwisko);
END;


--zadanie 6
SET SERVEROUTPUT ON
DECLARE
v_rekord pracownik%ROWTYPE;
BEGIN 
SELECT ID_PRACOWNIK ,IMIE ,NAZWISKO  INTO v_rekord FROM pracownik WHERE id_pracownik=2;
DBMS_OUTPUT.PUT_LINE('Pracownik o id = '||v_rekord.id_pracownik||' to '||v_rekord.imie||' '||v_rekord.nazwisko);
v_rekord.id_pracownik:=10;
INSERT INTO pracownik2 VALUES (v_rekord.id_pracownik,v_rekord.imie,v_rekord.nazwisko);
END;


--zadanie 8
CREATE TABLE osoba
  (
    id_osoba         NUMBER (10) NOT NULL ,
    imie             VARCHAR2 (40) NOT NULL ,
    nazwisko         VARCHAR2 (40) NOT NULL ,
    roczne_zarobki   NUMBER (10,2) NOT NULL 
    );
ALTER TABLE osoba ADD CONSTRAINT osoba_PK PRIMARY KEY ( id_osoba ) ;
INSERT INTO osoba VALUES (1,'Jan','Kowalski',8765.12);
INSERT INTO osoba VALUES (2,'Anna','Nowak',6543.11);
INSERT INTO osoba VALUES (3,'Ewa','Nowak',5555.55);

SET SERVEROUTPUT ON
DECLARE
SUBTYPE KASA IS NUMBER (20,2);
v_zmienna KASA;
BEGIN 
SELECT roczne_zarobki INTO v_zmienna FROM osoba WHERE id_osoba=1;
DBMS_OUTPUT.PUT_LINE(v_zmienna);
END;




