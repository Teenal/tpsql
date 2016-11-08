CREATE TABLE QUENTIN_PILOTE (
        PLNUM number not null,
        PLNOM varchar(50) not null,
        PLPRENOM varchar(50) not null,
        VILLE varchar(30) ,
        SALAIRE number not null,
        CONSTRAINT pk_pilote PRIMARY KEY (PLNUM)
);

CREATE TABLE QUENTIN_AVION (
        AVNUM number not null,
        AVNOM varchar(10) not null,
        CAPACITE number not null,
        LOCALISATION varchar(30) not null,
        CONSTRAINT pk_avion PRIMARY KEY (AVNUM)
);

CREATE TABLE QUENTIN_VOL (
        VOLNUM number not null,
        PLNUM number not null,
        AVNUM number not null,
        VILLEDEP varchar(30) not null,
        VILLEARR varchar(30) not null,
        HEUREDEP number not null,
        HEUREARR number not null,
        CONSTRAINT pk_vol PRIMARY KEY (VOLNUM),
        FOREIGN KEY (PLNUM) references QUENTIN_PILOTE(PLNUM),
        FOREIGN KEY (AVNUM) references QUENTIN_AVION(AVNUM)
);
