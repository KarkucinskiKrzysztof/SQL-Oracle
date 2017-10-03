--SKOPIUJ, UZUPEŁNIJ ROZWIĄZANIA I ODEŚLIJ PLIK *.SQL.

--GR. O

--ZADANIA NA KOLOKWIUM

--Data: 7.01.2016
--Imię: 
--Nazwisko: 
--Semestr: 3
--Specjalność: Informatyka



--O1. Utwórz typ obiektowy o nazwie t_osoba zawierający atrybuty: id, imie, 
--nazwisko, data_urodzenia, pensja oraz metodę funkcję ile_lat zwracającą 
--informację ile lat ma dana osoba.
--Utwórz tabelę osoba typu obiektowego t_osoba i dodaj do niej co najmniej 3 rekordy.
--Napisać instrukcję testującą działanie utworzonej metody funkcji ile_lat.

--Rozwiązanie:

CREATE type t_osoba AS OBJECT (
id number,
imie varchar(50),
nazwisko varchar(50),
data_urodzenia date,
pensja number,
member function ile_lat return INTEGER
);

/
create or replace type body t_osoba is
member function ile_lat return INTEGER
is
begin
  return floor(months_between(sysdate, SELF.data_urodzenia)) / 12;
end;
end;

/
CREATE TABLE osoba of t_osoba;

INSERT INTO osoba VALUES(t_osoba(1, 'Kamil', 'zielinski', sysdate, 1000));
INSERT INTO osoba VALUES(t_osoba(2, 'Andrzej', 'Kowalski', sysdate - 365, 2000));
INSERT INTO osoba VALUES(t_osoba(3, 'Jan', 'Nowak', sysdate - 10, 3000));



--Test poprawności rozwiązania:
set serveroutput on
declare
  v_osoba t_osoba;
begin
  v_osoba := t_osoba(1, 'Kamil', 'zielinski', sysdate - 370, 1000);
  DBMS_OUTPUT.PUT_LINE('wynik ' || v_osoba.ile_lat());
end;

--Instrukcja usuwająca utworzoną tabelę i utworzony typ obiektowy:

drop TABLE osoba;
drop type t_osoba;

--O2. Napisz procedurę o nazwie podwyzka3, która w tabeli osoba (z zadania O1) 
--trzem osobom najmniej zarabiającym podwyższy pensję o 10%.
--Uwzględnij miejsca ex aequo.
--Do tabeli osoba dodaj kolejne rekordy, tak aby były dwie osoby zarabiające najniższą pensję.
--Zademonstruj działanie utworzonej procedury.

--Rozwiązanie:

INSERT INTO osoba VALUES(t_osoba(1, 'tadek', 'naz1', sysdate, 1000));
INSERT INTO osoba VALUES(t_osoba(2, 'Andrzej', 'Kowalski', sysdate - 365, 2000));
INSERT INTO osoba VALUES(t_osoba(3, 'Jan', 'Nowak', sysdate - 10, 3000));

drop type t_do_podwyzki;
create type t_do_podwyzki is varray(100) of t_osoba; -- index by pls_integer;

CREATE OR REPLACE PROCEDURE podwyzka3 IS
  CURSOR wszyscy_cur is SELECT * FROM OSOBA O ORDER BY O.PENSJA;
  v_osoby_do_podwyzki t_do_podwyzki := t_do_podwyzki();
  v_min_pensja number;
  v_i integer := 1;
  v_ilosc_roznych_pensji number := 0;
BEGIN
  -- select count(*) into v_ilosc_roznych_pensji from (select distinct(o.pensja) from osoba o  ORDER BY O.PENSJA);
  -- SELECT o.pensja FROM OSOBA O where rownum = 1 ORDER BY O.PENSJA;
  --SELECT o.pensja into v_min_pensja FROM OSOBA O where rownum = 1 ORDER BY O.PENSJA;
 -- DBMS_OUTPUT.PUT_LINE(v_min_pensja);
  
  FOR o_osoba in wszyscy_cur loop
    DBMS_OUTPUT.PUT_LINE(o_osoba.imie);
      v_osoby_do_podwyzki.extend;
      v_osoby_do_podwyzki(v_i) := o_osoba;
  /*
    if o_osoba.pensja <= v_min_pensja then
      v_osoby_do_podwyzki.extend;
      v_osoby_do_podwyzki(v_i) := o_osoba;
      v_i := v_i + 1;
    end if;
    */
  end loop;
  
  
 /* for v_osoba in v_osoby_do_podwyzki loop
    DBMS_OUTPUT.PUT_LINE(v_osoba.imie);
  end loop;
  */
  --SELECT * FROM OSOBA O where rownum <= 3 ORDER BY O.PENSJA; 
END;

--Test poprawności rozwiązania:
begin
  podwyzka3;
end;


--Instrukcja usuwająca utworzoną procedurę:

drop procedure t_do_podwyzki;



--O3. Napisać funkcję posiadającą jeden parametr p_data i zwracającą 
--informację ile osób urodziło się (wykorzystaj tabele osoba z zadania O1)
--po wskazanym dniu przez parametr p_data.
--Zademonstruj działanie zaimplementowanej funkcji.

--Rozwiązanie:

CREATE OR REPLACE FUNCTION ile_osob_po(p_data Date) return integer is
 v_ile_osob integer;
begin
  select count(*) into v_ile_osob from osoba o where O.DATA_URODZENIA > p_data;
  return v_ile_osob;
end;

--Test poprawności rozwiązania:
select * from osoba;

begin
  DBMS_OUTPUT.PUT_LINE(ile_osob_po(sysdate - (10*366)));
end;

INSERT INTO osoba VALUES(t_osoba(2, 'Sylweriusz', 'TTTT', sysdate - (10*365), 2000));

select * from osoba;
begin
  DBMS_OUTPUT.PUT_LINE(ile_osob_po(sysdate - (10*366)));
end;

--Instrukcja usuwająca utworzoną funkcję:

drop function ile_osob_po;



--O4. Rozwiązania zadań O2-O3 umieść w pakiecie o nazwie rozwiazanie i zademonstruj, że 
--działają funkcje i procedury w utworzonym pakiecie.
--Dodatkowo przeciąż dowolnie wybraną funkcję lub procedurę
--(napisz co realizuje zaimplementowane przeciążenie).

--Rozwiązanie:

CREATE OR REPLACE PACKAGE zad4 is 
  FUNCTION ile_osob_po(p_data Date) return integer;
  FUNCTION ile_osob_po(p_data Date, przed date) return integer; -- przeciazona
  PROCEDURE podwyzka3;
end zad4;
/
create or replace package body zad4 is 
  FUNCTION ile_osob_po(p_data Date) return integer is
   v_ile_osob integer;
    begin
      select count(*) into v_ile_osob from osoba o where O.DATA_URODZENIA < p_data;
      return v_ile_osob;
    end;
  
  FUNCTION ile_osob_po(p_data Date, przed date) return integer is -- przeciazona
   v_ile_osob integer;
  begin
    select count(*) into v_ile_osob from osoba o where O.DATA_URODZENIA > p_data and O.DATA_URODZENIA < przed;
    return v_ile_osob;
  end;
  
  PROCEDURE podwyzka3 is 
  begin
    DBMS_OUTPUT.PUT_LINE('podwyzka3 z pakietu');
  end;
end zad4;
--Test poprawności rozwiązania (uruchom wszystkie funkcje i procedury z pakietu):

begin
  DBMS_OUTPUT.PUT_LINE('Urodzonych po i przed ' || ZAD4.ILE_OSOB_PO(sysdate - 200, sysdate) );
  DBMS_OUTPUT.PUT_LINE('Urodzonych po ' || ZAD4.ILE_OSOB_PO(sysdate) );
  
  ZAD4.PODWYZKA3;
end;

--Usuwamy utworzony pakiet (całkowicie)
drop package zad4;


--O5. Uniemożliwić w istniejącej tabeli osoba (patrz zadanie O1) przypisanie 
--wielkości pensji mniejszej niż 2134 zł i większej niż 9999 zł.

--Rozwiązanie

create or replace trigger zad5 
before insert or update on osoba 
for each row
begin
  if :new.pensja < 2134 or :new.pensja > 9999 then
    RAISE_APPLICATION_ERROR(-20001, 'Pensja nie moze byc mniejsza niż 2134 zł i większa niż 9999');
  end if;
end;



--Testujemy poprawność rozwiązania:
select * from osoba;
INSERT INTO osoba VALUES(t_osoba(1, 'Pawek', 'Jercha', sysdate, 3000));
select * from osoba;
INSERT INTO osoba VALUES(t_osoba(1, 'Pawek', 'Jercha', sysdate, 1000));

--Instrukcja usuwająca utworzone obiekty:
drop trigger zad5;