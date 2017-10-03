-- Autor Krzysztof Karkuci�ski nr indeksu 175846

-- Pokazyje w bazie najlepszego �ewce szczupak�w wraz z ilo�ci� z�apanych ryb.
CREATE VIEW szczupakowy_mistrz AS
SELECT nazwisko,imie,count(gatunek) AS Ilosc_szczupakow FROM wedkarz, zlowienie_ryby,ryba 
WHERE wedkarz.id_wedkarz=zlowienie_ryby.wedkarz_id_wedkarz 
AND  zlowienie_ryby.RYBA_ID_RYBY=ryba.ID_RYBY 
AND gatunek='Szczupak'
GROUP BY imie,nazwisko HAVING count(gatunek) >=2;

SELECT * FROM szczupakowy_mistrz;


-- Pokazuje jeziora i rzeki na kt�rych zosta�o z�apane najwiecej ryb.
CREATE VIEW najlowniejsza_woda AS
SELECT typ,nazwa, count(nazwa) AS Ilosc_wypraw FROM miejsce,wyprawa,zlowienie_ryby,ryba
WHERE miejsce.id_miejsce=wyprawa.miejsce_id_miejsce 
AND wyprawa.id_wyprawa=zlowienie_ryby.wyprawa_id_wyprawa 
AND zlowienie_ryby.ryba_id_ryby=ryba.id_ryby
AND gatunek IN (SELECT ryba.gatunek FROM ryba WHERE gatunek='Szczupak'  OR gatunek='Oko�'  OR gatunek='Sum')
GROUP BY nazwa,typ HAVING count(nazwa) >=2;  
        
SELECT * FROM najlowniejsza_woda;  