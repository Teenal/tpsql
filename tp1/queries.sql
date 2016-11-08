1)
select * from quentin_pilote;

2)
select plnom,ville from quentin_pilote;

3)
select plnum,plnom from quentin_pilote;

4)
select villedep from quentin_vol;

5)
select nom from quentin_pilote where ville = 'PARIS';

6)
select nom from quentin_pilote where salaire > 2500;

7)
select nom from quentin_pilote where ville is null;

8)
select avnum from quentin_avion where avnom in ('A310', 'A320', 'A330', 'A340');

9)
select nom from quentin_pilote where salaire between 2000 and 2500

10)
select capacite from quentin_avion where having avnom like "A3%";

11)
select avnom from quentin_avion where having avnom not like "A3%";

12)
select volnum from quentin_vol where villedep = 'Nice' and villearr = 'Paris';

13)

14)
select avg(salaire) from quentin_pilote;

15)
select count(*) from quentin_vol where villedep = 'Paris';

16)
select plnom from quentin_pilote inner join quentin_vol on quentin_pilote.plnum = quentin_vol.plnum inner join quentin_avion on quentin_avion.avnum = quentin_vol.avnum where villedep = 'Paris' and avnom like 'A3%';

17)
select avnum from quentin_avion where  localisation in  (select localisation from quentin_avion where avnum = 3);

18)
select plnom from quentin_pilote where salaire > (select avg(salaire) from quentin_pilote);

19)
select plnom from quentin_pilote join quentin_vol on quentin_pilote.plnum = quentin_vol.plnum join quentin_avion on quentin_vol.avnum = quentin_avion.avnum where villedep='Paris';

20)

21)

22)
select * from quentin_pilote where (ville,salaire) in (select ville,salaire from quentin_pilote where plnom = 'MIRANDA');

23)
select plnom from quentin_pilote order by salaire;

24)
select plnum,count(plnum) from quentin_vol group by plnum;

25)

26)
select plnum,count(plnum) from quentin_vol group by plnum having count(plnum) > 5;

27)
select plnom from quentin_pilote where plnum in (select plnum from quentin_vol group by plnum having count(plnum) >= 5);

28)
select avnom from quentin_avion where capacite > 250 or localisation = 'paris';

29)

30)

31)

32)

33) 

