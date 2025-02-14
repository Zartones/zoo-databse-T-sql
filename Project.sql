go
create procedure p1 @id_job integer
as
declare 
people cursor
for
select StName,idStaff from STAFF where idJob = @id_job;
declare
@id_staff integer,
@st_name varchar(20);
open people 
fetch next from people into @st_name, @id_staff
while @@FETCH_STATUS = 0
	begin
		print 'Name of the staff member: ' + @st_name +', and his id: ' + cast(@id_staff as varchar);
		fetch next from people into @st_name, @id_staff
	end;
close people;
deallocate people;


exec p1 3;

go
create procedure p2 @date date, @output varchar(60) output
as
declare
people1 cursor
for
select idSup,SDate from supplier where SDate = @date;
declare
@id_sup integer,
@s_date date,
@flag integer = 0;
open people1
fetch next from people1 into @id_sup,@s_date;
while @@FETCH_STATUS = 0
	begin
		if @s_date != @date
			begin
				set @flag = 1;
			end;

		if @flag=1
			begin
				select @output = 'Not all suppliers arrived in time' ;
				break;
			end;
		else
			begin
				select @output ='All suppliers arrived in time';
			end;

		fetch next from people1 into @id_sup,@s_date;
	end;
close people1;
deallocate people1;


declare @out_put varchar(60);
exec p2 '2020-8-5', @out_put output;
print @out_put;




go
create procedure p3 @mon integer
as
declare
people2 cursor
for
select  salary from STAFF where salary < @mon;
declare
@count integer = 0,
@sal integer;

open people2;
fetch next from people2 into @sal;
while @@FETCH_STATUS = 0
	begin
		if @sal< @mon
		set @count = @count + 1;
		fetch next from people2 into @sal;
	end;
close people2;
deallocate people2;

if @count = 0
	begin
		print 'Everybody`s salary is correct';
		return 
	end;
else
	begin
		print 'There are underpaid employees!'
		return
	end;


exec p3 5000;

go
create trigger t1 on staff after insert
as
begin
declare person cursor
for
select Stname ,jtype from jobs,staff where jobs.idJob = STAFF.idJob;
declare
@name varchar(20),
@job varchar(20);
open person
fetch next from person into @name,@job;
while @@FETCH_STATUS = 0
	begin
		print 'Staff member ' + @name + ' is a ' + @job;
		fetch next from person into @name,@job;
	end;
close person;
deallocate person;
end;

insert into staff values(6, 3, 'DEN', 4000, 3700, 'GREEN STREET', 3);
delete from staff where StName = 'DEN';



go
create trigger t2 on animals after delete
as
begin
declare person1 cursor
for
select Aname,DepDate from deleted;
declare 
@name varchar(30),
@date date;
open person1
fetch next from person1 into @name,@date;
while @@FETCH_STATUS = 0
	begin
		print 'Animal ' + @name + ' was departed on ' + cast(@date as varchar);
		fetch next from person1 into  @name,@date;
	end;
close person1;
deallocate person1;
end;

delete from animals where AName = 'BEAR';
delete from VACCINATION where idAnimal =3;
delete from DIET where idAnimal =3;

go
create trigger t3 on animals after insert
as
begin 
declare person2 cursor
for
select AName, VaccinationDate,ArrDate from inserted;
declare
@name varchar(20),
@vac date,
@arr date;
open person2
fetch next from person2 into @name,@vac,@arr;
while @@FETCH_STATUS = 0
	begin
		if @arr < @vac
			begin
				print 'Arrived animal ' + @name + ' should be vaccinated!';
			end;
			fetch next from person2 into @name,@vac,@arr;
	end;
close person2;
deallocate person2;
end;

insert into ANIMALS values(6, 3, 'CAT', '2019-4-14','2022-8-16','2016-3-29','2020-6-22');
delete from ANIMALS where AName='CAT';
