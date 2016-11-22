-- Partie 1
-- Création des tables et remplissage
DROP TABLE QUENTIN_Qualification CASCADE CONSTRAINTS;
DROP TABLE QUENTIN_Intervenant CASCADE CONSTRAINTS;
DROP TABLE QUENTIN_Mission CASCADE CONSTRAINTS;
DROP TYPE  mission_type FORCE;
DROP TYPE  intervenant_type FORCE;
DROP TYPE  qualif_type FORCE;

CREATE OR REPLACE TYPE qualif_type AS object (
        qualif VARCHAR(100),
        tarif  NUMBER
);
/

CREATE TABLE QUENTIN_Qualification OF qualif_type;
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Développeur',  500));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Analyste',  700));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Chef de QUENTIN_Projet',  900));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Consultant', 1000));
INSERT INTO QUENTIN_Qualification VALUES (qualif_type('Directeur commercial', 1300));

-- Q1
CREATE OR REPLACE TYPE intervenant_type AS object (
        matricule integer,
        nom VARCHAR(50),
        prenom VARCHAR(50),
        qualification qualif_type
);
/

CREATE OR REPLACE TYPE mission_type AS object (
        code VARCHAR(15),
        intitule VARCHAR(50),
        nb_jours INTEGER,
        intervenant REF intervenant_type 
);
/

-- Q2
CREATE TABLE QUENTIN_Intervenant of intervenant_type (
        CONSTRAINT PK_intervenant PRIMARY KEY(matricule)
);

CREATE TABLE QUENTIN_Mission of mission_type (
        CONSTRAINT PK_mission PRIMARY KEY(code)
);

-- Q3
INSERT INTO QUENTIN_Intervenant VALUES (2516, 'Dupont', 'Pierre', qualif_type('Développeur', 550));
INSERT INTO QUENTIN_Intervenant VALUES (7655, 'Henri', 'Jacques', qualif_type('Consultant', 990.90));
INSERT INTO QUENTIN_Intervenant VALUES (7687, 'Triolet', 'Elsa', qualif_type('Consultant', 1029.00));

-- Q4
INSERT INTO QUENTIN_Mission VALUES (mission_type('Varalpain033', 'Etude technique du passage de PEL en CEL', 54, 
           (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 7655)));

-- Q5
INSERT INTO QUENTIN_Intervenant VALUES (1000, 'Michelin', 'Philippe', qualif_type('Directeur', 3000));

-- Q6
SELECT REF(i) FROM QUENTIN_Intervenant i WHERE matricule = 1000;

-- Le message obtenu est une référence sous forme de texte et non pas un objet.


-- Q10
INSERT INTO QUENTIN_Mission VALUES (mission_type('Armoni002', 'Prise de contact avec le Directeur', 2, 
           (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 1000)));

-- Q11
DESC QUENTIN_Mission;
SELECT * FROM QUENTIN_Mission;

-- Q12
SELECT code, nb_jours*DEREF(intervenant).qualification.tarif AS "cout" FROM QUENTIN_Mission WHERE intervenant = (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 1000);

-- Q13
UPDATE QUENTIN_Mission SET nb_jours = nb_jours +1 WHERE intervenant = (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 1000);

-- Q14
UPDATE QUENTIN_Intervenant i SET i.qualification.tarif = 2800 WHERE nom = 'Michelin';
SELECT code, nb_jours*DEREF(intervenant).qualification.tarif AS "cout" FROM QUENTIN_Mission WHERE intervenant = (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 1000);

-- Q15
DELETE FROM QUENTIN_Intervenant WHERE nom = 'Michelin';
SELECT code, nb_jours*DEREF(intervenant).qualification.tarif AS "cout" FROM QUENTIN_Mission WHERE intervenant = (SELECT REF(i) from QUENTIN_Intervenant i where matricule = 1000);

-- Partie 2
DROP TABLE QUENTIN_Projet CASCADE CONSTRAINTS;
DROP TYPE  missions_type FORCE;

-- Q1
CREATE OR REPLACE TYPE missions_type AS TABLE OF mission_type;
/

-- Q2
CREATE TABLE QUENTIN_Projet (
  nom VARCHAR2(200),
  dateDebut DATE,
  dateFin DATE,
  lesMissions missions_type,
  CONSTRAINT PK_QUENTIN_Projet PRIMARY KEY(nom)
) NESTED TABLE lesMissions STORE AS missionsTable;

-- Q3
INSERT INTO QUENTIN_Projet VALUES ('CA1', '12/12/2009', '13/07/2011',
  missions_type(
    mission_type('SFG', 'Spécifications générales', 30,
        (SELECT REF(i) FROM QUENTIN_Intervenant i WHERE matricule = 7655)),
    mission_type('SFD', 'Spécifications détaillées', 60,
        (SELECT REF(i) FROM QUENTIN_Intervenant i WHERE matricule = 2516))
  )
);

-- Q4
DESC QUENTIN_Projet;
SELECT nom,dateDebut,dateFin FROM QUENTIN_Projet;

-- Q5
SELECT lesMissions FROM QUENTIN_Projet WHERE nom = 'CA1';

-- Q6
SELECT code, intitule, nb_jours, DEREF(intervenant).nom, DEREF(intervenant).prenom, DEREF(intervenant).qualification
FROM QUENTIN_Projet P, TABLE(P.lesMissions) M;

-- Q7
SELECT nom, dateFin, code, nb_jours, DEREF(intervenant).nom, DEREF(intervenant).qualification
FROM QUENTIN_Projet P, TABLE(P.lesMissions) M;
