DROP TABLE QUENTIN_Qualification;

-- 2.1.1
CREATE OR REPLACE TYPE qualif_type AS object (
        qualif VARCHAR(100),
        tarif  NUMBER
);
/

-- 2.1.2
CREATE TABLE QUENTIN_Qualification OF qualif_type;
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Développeur',  500));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Analyste',  700));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Chef de projet',  900));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Consultant', 1000));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Directeur commercial', 1300));

-- 2.1.3
DESC qualif_type;
DESC QUENTIN_qualification;
SELECT * FROM QUENTIN_qualification;

-- 2.1.4
SELECT * FROM QUENTIN_qualification ORDER BY qualif;

-- 2.1.5
SELECT AVG(tarif) FROM QUENTIN_qualification;

-- 2.1.6
UPDATE QUENTIN_qualification SET tarif = tarif * 1.025;
SELECT * FROM QUENTIN_qualification ORDER BY qualif;

-- 2.2.1
DROP TABLE QUENTIN_Qualification;
CREATE TABLE QUENTIN_Qualification (
        qualification qualif_type
);
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Développeur',  500));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Analyste',  700));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Chef de projet',  900));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Consultant', 1000));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Directeur commercial', 1300));

-- 2.2.2
DESC qualif_type;
DESC QUENTIN_qualification;
SELECT * FROM QUENTIN_qualification;
SELECT MIN(q.qualification.tarif), MAX(q.qualification.tarif) FROM QUENTIN_qualification q;

-- 2.2.3
UPDATE QUENTIN_qualification q SET q.qualification.tarif = q.qualification.tarif * 1.1 WHERE q.qualification.qualif = 'Analyste';
SELECT * FROM QUENTIN_qualification;

-- 2.3.1
CREATE TABLE QUENTIN_Intervenant (
        matricule integer,
        nom VARCHAR(50),
        prenom VARCHAR(50),
        qualification qualif_type,
        CONSTRAINT pk_intervenant PRIMARY KEY (matricule)
);

-- 2.3.2
DESC QUENTIN_Intervenant;

-- 2.3.3
INSERT INTO QUENTIN_Intervenant VALUES (2516, 'Dupont', 'Pierre', qualif_type('Développeur', 550));
INSERT INTO QUENTIN_Intervenant VALUES (7655, 'Henri', 'Jacques', qualif_type('Consultant', 990.90));
INSERT INTO QUENTIN_Intervenant VALUES (7687, 'Triolet', 'Elsa', qualif_type('Consultant', 1029.00));

-- 2.3.4
SELECT nom, prenom, i.qualification.tarif FROM QUENTIN_Intervenant i;

-- 2.3.5
SELECT matricule, nom, prenom FROM QUENTIN_Intervenant i WHERE i.qualification.qualif = 'Consultant';

-- 2.3.6
SELECT * FROM QUENTIN_Intervenant i
WHERE i.qualification.qualif = 'Consultant'
AND i.qualification.tarif > (SELECT q.qualification.tarif FROM QUENTIN_qualification q
        WHERE q.qualification.qualif = 'Consultant');

-- 2.3.7
DROP TABLE QUENTIN_Qualification;
-- Il ne se passe rien de spécial

-- 2.3.8
SELECT * FROM QUENTIN_Intervenant;
-- Rien n'a changé car on se sert du type et non d'une clé étrangère
