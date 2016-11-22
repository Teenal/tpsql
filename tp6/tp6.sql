-- 2.2

-- 1
CREATE OR REPLACE missions_type AS TABLE OF mission_type;
\

-- 2
CREATE TABLE projet (
  nom VARCHAR2(200),
  dateDebut DATE,
  dateFin DATE,
  lesMissions missions_type
) NESTED TABLE lesMissions STORE AS missionsTable;

INSERT INTO projet VALUES ('CA1', '12/12/2009', '13/07/2011',
  missionsTable(
    mission_type('SFG', 'Spécifications générales', 30, REF TODO),
    mission_type('SFD', 'Spécifications détaillées', 60, REF TODO)
  )
)

SELECT nom, COLUMN_VALUE FROM projet P, TABLE(P.lesMissions) M;
