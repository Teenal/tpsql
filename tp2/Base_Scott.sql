CREATE TABLE quentin_DEPT
   (DEPTNO NUMBER(2) PRIMARY KEY,
     DNAME VARCHAR2(25),
     DLOC  VARCHAR2(15)
   );
                                       
INSERT INTO quentin_DEPT VALUES (10 , 'ACCOUNTING' , 'NEW YORK');                                              
INSERT INTO quentin_DEPT VALUES (20 , 'RESEARCH'   , 'DALLAS'   );                                             
INSERT INTO quentin_DEPT VALUES (30 , 'SALES'      , 'CHICAGO'   );                                            
INSERT INTO quentin_DEPT VALUES (40 , 'OPERATIONS' , 'BOSTON'     );   

CREATE TABLE quentin_EMP
   ( EMPNO NUMBER(4) CONSTRAINT quentin_EMP_PK PRIMARY KEY,
     ENAME VARCHAR2(25),
     JOB   VARCHAR2(15),
     MGR   NUMBER(4),
     HIREDATE DATE,
     SAL   NUMBER(7),
     COMM  NUMBER(6,2),
     DEPTNO NUMBER(2)
   );

INSERT INTO quentin_EMP VALUES (  7369 ,'SMITH'  ,'CLERK'    , 7902 ,'17/12/80' , 800 , NULL,20);  
INSERT INTO quentin_EMP VALUES (  7499 ,'ALLEN'  ,'SALESMAN' , 7698 ,'20/02/81' ,1600 , 300 ,30);  
INSERT INTO quentin_EMP VALUES (  7521 ,'WARD'   ,'SALESMAN' , 7698 ,'22/02/81' ,1250 , 500 ,30);  
INSERT INTO quentin_EMP VALUES (  7566 ,'JONES'  ,'MANAGER'  , 7839 ,'02/04/81' ,2975 , NULL,20);  
INSERT INTO quentin_EMP VALUES (  7654 ,'MARTIN' ,'SALESMAN' , 7698 ,'28/09/81' ,1250 ,1400 ,30);  
INSERT INTO quentin_EMP VALUES (  7698 ,'BLAKE'  ,'MANAGER'  , 7839 ,'01/05/81' ,2850 , NULL,30);  
INSERT INTO quentin_EMP VALUES (  7782 ,'CLARK'  ,'MANAGER'  , 7839 ,'09/06/81' ,2450 , NULL,10);  
INSERT INTO quentin_EMP VALUES (  7788 ,'SCOTT'  ,'ANALYST'  , 7566 ,'19/04/87' ,3000 , NULL,20);  
INSERT INTO quentin_EMP VALUES (  7839 ,'KING'   ,'PRESIDENT', NULL ,'17/11/81' ,5000 , NULL,10);  
INSERT INTO quentin_EMP VALUES (  7844 ,'TURNER' ,'SALESMAN' , 7698 ,'08/09/81' ,1500 , 0   ,30);  
INSERT INTO quentin_EMP VALUES (  7876 ,'ADAMS'  ,'CLERK'    , 7788 ,'23/05/87' ,1100 , NULL,20);  
INSERT INTO quentin_EMP VALUES (  7900 ,'JAMES'  ,'CLERK'    , 7698 ,'03/12/81' , 950 , NULL,30);  
INSERT INTO quentin_EMP VALUES (  7902 ,'FORD'   ,'ANALYST'  , 7566 ,'03/12/81' ,3000 , NULL,20);  
INSERT INTO quentin_EMP VALUES (  7934 ,'MILLER' ,'CLERK'    , 7782 ,'23/01/82' ,1300 , NULL,10);  

ALTER TABLE quentin_EMP ADD CONSTRAINT quentin_EMP_MGR_FK FOREIGN KEY(MGR) REFERENCES quentin_EMP(EMPNO) ON DELETE SET NULL;
ALTER TABLE quentin_EMP ADD CONSTRAINT quentin_EMP_quentin_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES quentin_DEPT(DEPTNO) ON DELETE CASCADE;