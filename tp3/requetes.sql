-- 1)
alter table quentin_medecin add salaire number;
update quentin_medecin set salaire = 2000;

-- 2)
begin
    delete from quentin_medecin where statut = 'PATTASS' and prof_serv = 'Florence ROUSSEAU';
    if sql%rowcount = 0 then
        DBMS_OUTPUT.PUT_LINE('Aucun médecin supprimé !');
    else
        DBMS_OUTPUT.PUT_LINE(TO_Char(SQL%ROWCOUNT)||' rows affected.');
    end if;
end;

-- 3)
select count(*) from quentin_consultation
where n_med = 5780
  and extract(month from date_consult) = '10'
  and extract(year from date_consult) = '2011';

CREATE OR REPLACE FUNCTION QUENTIN_nb_medecins
(nmed number, mois number, annee number)
RETURN number IS
    nb number := 0;
BEGIN
    select count(*) into nb from quentin_consultation
    where n_med = nmed
      and extract(month from date_consult) = mois
      and extract(year from date_consult) = annee;
    dbms_output.put_line(to_char(nmed));
    dbms_output.put_line(to_char(mois));
    dbms_output.put_line(to_char(annee));
    return nb;
END QUENTIN_nb_medecins;
/

begin
    dbms_output.put_line(to_char(quentin_nb_medecins(5780, 10, 2011)));
end;
/

CREATE OR REPLACE FUNCTION QUENTIN_ratio_salaire
(statut varchar)
RETURN float IS
    ratio float := 1.2;
BEGIN
    IF statut = 'PUPH' THEN ratio := 1.08;
    ELSE 
        IF statut = 'PATT' THEN ratio := 1.05;
        END IF;
    END IF;
    RETURN ratio;
END QUENTIN_ratio_salaire;
/

begin
    dbms_output.put_line(to_char(QUENTIN_ratio_salaire('PUPH')));
    dbms_output.put_line(to_char(QUENTIN_ratio_salaire('PATT')));
    dbms_output.put_line(to_char(QUENTIN_ratio_salaire('YOLO')));
end;
/

begin
    UPDATE QUENTIN_medecin
    SET salaire = QUENTIN_ratio_salaire(statut) * salaire;
end;
/

SELECT salaire, statut FROM QUENTIN_medecin;
