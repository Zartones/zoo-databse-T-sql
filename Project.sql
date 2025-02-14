create table JOB
(
    idJob int PRIMARY KEY,
    JType varchar(50)
);

create table DEPARTMENT
(
    idDep    int PRIMARY KEY,
    DName    varchar(50),
    DAddress varchar(50)
);

create table STAFF
(
    idStaff    int PRIMARY KEY,
    idDep      int,
    StName     varchar(50),
    salary     number(7, 2),
    salaryEuro number(7, 2),
    StAddress  varchar(50),
    idJob      int,
    FOREIGN KEY (idDep) REFERENCES department (idDep),
    FOREIGN KEY (idJob) REFERENCES job (idJob)
);

create table SUPPLIER
(
    idSup int PRIMARY KEY,
    Sname varchar(50),
    SDate DATE
);

create table FOOD
(
    idFood int PRIMARY KEY,
    FType  varchar(20),
    FOREIGN KEY (idFood) REFERENCES supplier (idSup)
);

create table ANIMALS
(
    idAnimal        int PRIMARY KEY,
    idStaff         int,
    AName           varchar(50),
    ArrDate         DATE,
    DepDate         DATE,
    BirthDate       DATE,
    VaccinationDate DATE,
    FOREIGN KEY (idStaff) REFERENCES staff (idStaff)
);

create table VACCINATION
(
    idAnimal        int PRIMARY KEY,
    VaccinationDate DATE,
    FOREIGN KEY (idAnimal) REFERENCES ANIMALS (idAnimal)
);

create table DIET
(
    idDiet   int PRIMARY KEY,
    idFood   int,
    idAnimal int,
    FOREIGN KEY (idAnimal) REFERENCES animals (idAnimal),
    FOREIGN KEY (idFood) REFERENCES food (idFood)
);

insert into job
values (1, 'GUARD');

insert into job
values (2, 'VET');

insert into job
values (3, 'CLEANER');

insert into job
values (4, 'GUIDE');

insert into job
values (5, 'CARETAKER');

insert into department
values (1, 'SECURITY', 'THE ORCHARDS');

insert into department
values (2, 'VETERINARY CARE', 'RIVER STREET');

insert into department
values (3, 'TOURISM', 'BELGRAVE ROAD');

insert into department
values (4, 'ANIMAL PROGRAMS', 'WOODSTOCK ROAD');

insert into department
values (5, 'SANITARY CONTROL', 'BARBARA STREET');

insert into staff
values (1, 3, 'MIKE', 5000, 4200, 'GRANGE DRIVE', 4);

insert into staff
values (2, 1, 'JONY', 3000, 2700, 'WOODSIDE', 1);

insert into staff
values (3, 2, 'MARY', 6000, 5300, 'ORCHARD AVENUE', 2);

insert into staff
values (4, 4, 'RON', 5500, 5100, 'GLOUCESTER ROAD', 5);

insert into staff
values (5, 5, 'SHONA', 3500, 3200, 'COBBEN STREET', 3);

insert into supplier
values (1, 'GREAT DIXTER', TO_DATE('16/7/2020', 'DD/MM/YYYY'));

insert into supplier
values (2, 'ELSAADA', TO_DATE('29/6/2020', 'DD/MM/YYYY'));

insert into supplier
values (3, 'WFRUIT', TO_DATE('24/7/2020', 'DD/MM/YYYY'));

insert into supplier
values (4, 'CREED', TO_DATE('7/7/2020', 'DD/MM/YYYY'));

insert into supplier
values (5, 'AQUA', TO_DATE('4/8/2020', 'DD/MM/YYYY'));

insert into food
values (1, 'SEED');

insert into food
values (2, 'VEGETABLES');

insert into food
values (3, 'Fruit');

insert into food
values (4, 'MEAT');

insert into food
values (5, 'FISH FOOD');

insert into animals
values (1, 4, 'LION', TO_DATE('14/3/2020', 'DD/MM/YYYY'), TO_DATE('1/8/2020', 'DD/MM/YYYY'),
        TO_DATE('12/4/2015', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into animals
values (2, 5, 'STRINGRAY', TO_DATE('27/3/2019', 'DD/MM/YYYY'), TO_DATE('20/1/2020', 'DD/MM/YYYY'),
        TO_DATE('27/11/2016', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into animals
values (3, 4, 'BEAR', TO_DATE('6/9/2019', 'DD/MM/YYYY'), TO_DATE('19/11/2020', 'DD/MM/YYYY'),
        TO_DATE('25/2/2017', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into animals
values (4, 1, 'PEACOCK', TO_DATE('13/5/2020', 'DD/MM/YYYY'), TO_DATE('11/2/2021', 'DD/MM/YYYY'),
        TO_DATE('13/5/2020', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into animals
values (5, 3, 'ZEBRA', TO_DATE('12/4/2019', 'DD/MM/YYYY'), TO_DATE('16/8/2022', 'DD/MM/YYYY'),
        TO_DATE('29/3/2016', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into VACCINATION
values (1, TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into VACCINATION
values (2, TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into VACCINATION
values (3, TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into VACCINATION
values (4, TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into VACCINATION
values (5, TO_DATE('22/6/2020', 'DD/MM/YYYY'));

insert into diet
values (1, 1, 4);

insert into diet
values (2, 2, 5);

insert into diet
values (3, 3, 3);

insert into diet
values (4, 4, 1);

insert into diet
values (5, 5, 2);

set serveroutput on;

create or replace procedure p1 (id_job int)
as
cursor people is
    select StName,idStaff
    from STAFF
    where idJob = id_job;
id_staff int;
st_name varchar2(20);
c_ount int;
nojob exception;
begin
select count(idStaff) into c_ount
from staff
where idJob = id_job;
if c_ount = 0 then raise nojob;
end if;
open people ;
loop
    fetch people into st_name, id_staff;
    exit when people%notfound;
	 dbms_output.put_line('Name of the staff member: ' || st_name || ', and his id: ' || id_staff);
end loop;	
close people;
exception when nojob then dbms_output.put_line('No job ');
end;


exec p1 (3);

create or replace procedure p2 (Sdate date) 
as 
cursor people1 is 
    select idSup,SDate
    from supplier ; 
id_sup int; 
s_date date; 
baddate exception; 
begin 
if sdate > to_date('29/9/2020', 'DD/MM/YYYY') then raise baddate; 
end if;
open people1; 
loop 
    fetch people1 into id_sup,s_date; 
    exit when people1%notfound; 
		if (s_date > sdate) then 
				dbms_output.put_line(id_sup || ' was late'); 
			end if; 
end loop; 
close people1; 
exception when baddate then dbms_output.put_line('Wrong date'); 
end;




exec p2 (to_date('16/7/2020','DD/MM/YYYY'));





create or replace procedure p3 (mon int)
as
cursor people2 is
    select  salary 
    from STAFF 
    where salary < mon;
s_count int := 0;
sal int;
lowmon exception;
begin
if mon < 1000 then raise lowmon;
end if;
open people2;
loop
    fetch people2 into sal;
    exit when people2%notfound;
		if (sal< mon) then
		s_count := s_count + 1;
		end if;
		end loop;
    close people2;

if (s_count = 0) then
		dbms_output.put_line('Everybody`s salary is correct');
else
		dbms_output.put_line('There are underpaid employees!');
	end if;
	
exception when lowmon then dbms_output.put_line('Too low salary');	
end;


exec p3 (5000);


create or replace trigger t1 
before insert 
on animals 
for each row
declare
cursor person is
    select Aname
    from animals;
a_name varchar2(20);
animalexist exception;
begin 
    open person;
    loop
        fetch person into a_name;
        exit when person%notfound;
        if a_name = :new.Aname then raise animalexist;
        end if;
    end loop;
    close person;
    dbms_output.put_line('New kind of animal has arrived');
    exception when animalexist then dbms_output.put_line('We already have this kind of animal');
end;


create or replace trigger t2 
after insert 
on animals 
declare 
cursor person1 is 
    select salary 
    from staff; 
sal int; 
c_ount int; 
anim int; 
noanim exception; 
BEGIN 
select count(*) into anim from ANIMALS; 
select count(idAnimal) into c_ount from animals; 
if c_ount= 0 then raise noanim; 
else 
open person1; 
loop 
    fetch person1 into sal; 
    exit when person1%notfound; 
    sal := 1000 * anim; 
    update STAFF set SALARY = sal; 
end loop; 
close person1; 
end if; 
    exception when noanim then dbms_output.put_line('No animals'); 
end;

insert into animals
values (6, 3, 'ZEB', TO_DATE('12/4/2019', 'DD/MM/YYYY'), TO_DATE('16/8/2022', 'DD/MM/YYYY'),
        TO_DATE('29/3/2016', 'DD/MM/YYYY'), TO_DATE('22/6/2020', 'DD/MM/YYYY'));
        
delete from animals where idAnimal = 6;        
        
select  salary from staff;       

create or replace trigger t3 
before insert
on staff
for each row
declare
nsal int;
average int;
smallsal exception;
begin
nsal := :new.salary;
select avg(salary) into average from staff;
if nsal < average then raise smallsal;
end if;
exception when smallsal then dbms_output.put_line('Small salary');
end;

insert into staff
values (6, 1, 'JON', 3000, 2700, 'WOODSIDE', 1);
