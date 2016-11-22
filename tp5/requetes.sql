DROP TABLE HMITO_Qualification;

-- 2.1.1
CREATE OR REPLACE TYPE qualif_type AS object (
        qualif VARCHAR(100),
        tarif  NUMBER
);
/

-- 2.1.2
CREATE TABLE HMITO_Qualification OF qualif_type;
INSERT INTO HMITO_Qualification VALUES (qualif_type('Développeur',  500));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Analyste',  700));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Chef de projet',  900));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Consultant', 1000));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Directeur commercial', 1300));

-- 2.1.3
DESC qualif_type;
DESC HMITO_qualification;
SELECT * FROM HMITO_qualification;

-- 2.1.4
SELECT * FROM HMITO_qualification ORDER BY qualif;

-- 2.1.5
SELECT AVG(tarif) FROM HMITO_qualification;

-- 2.1.6
UPDATE HMITO_qualification SET tarif = tarif * 1.025;
SELECT * FROM HMITO_qualification ORDER BY qualif;

-- 2.2.1
DROP TABLE HMITO_Qualification;
CREATE TABLE HMITO_Qualification (
        qualification qualif_type
);
INSERT INTO HMITO_Qualification VALUES (qualif_type('Développeur',  500));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Analyste',  700));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Chef de projet',  900));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Consultant', 1000));
INSERT INTO HMITO_Qualification VALUES (qualif_type('Directeur commercial', 1300));

-- 2.2.2
DESC qualif_type;
DESC HMITO_qualification;
SELECT * FROM HMITO_qualification;
SELECT MIN(q.qualification.tarif), MAX(q.qualification.tarif) FROM HMITO_qualification q;

-- 2.2.3
UPDATE HMITO_qualification q SET q.qualification.tarif = q.qualification.tarif * 1.1 WHERE q.qualification.qualif = 'Analyste';
SELECT * FROM HMITO_qualification;

-- 2.3.1
CREATE TABLE HMITO_Intervenant (
        matricule integer,
        nom VARCHAR(50),
        prenom VARCHAR(50),
        qualification qualif_type,
        CONSTRAINT pk_intervenant PRIMARY KEY (matricule)
);

-- 2.3.2
DESC HMITO_Intervenant;

-- 2.3.3
INSERT INTO HMITO_Intervenant VALUES (2516, 'Dupont', 'Pierre', qualif_type('Développeur', 550));
INSERT INTO HMITO_Intervenant VALUES (7655, 'Henri', 'Jacques', qualif_type('Consultant', 990.90));
INSERT INTO HMITO_Intervenant VALUES (7687, 'Triolet', 'Elsa', qualif_type('Consultant', 1029.00));

-- 2.3.4
SELECT nom, prenom, i.qualification.tarif FROM HMITO_Intervenant i;

-- 2.3.5
SELECT matricule, nom, prenom FROM HMITO_Intervenant i WHERE i.qualification.qualif = 'Consultant';

-- 2.3.6
SELECT * FROM HMITO_Intervenant i
WHERE i.qualification.qualif = 'Consultant'
AND i.qualification.tarif > (SELECT q.qualification.tarif FROM HMITO_qualification q
        WHERE q.qualification.qualif = 'Consultant');

-- 2.3.7
DROP TABLE HMITO_Qualification;
-- Il ne se passe rien de spécial

-- 2.3.8
SELECT * FROM HMITO_Intervenant;
-- Rien n'a changé car on se sert du type et non d'une clé étrangère
