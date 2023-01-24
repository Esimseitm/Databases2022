Create table Department (
    id serial primary key,
    name varchar(200)
);
select id, Name
from Department;
Create table instructor
(
    id     serial
        constraint instructor_pk primary key,
    name   varchar(100),
    salary integer default 0,
    department_id integer
);
select * from instructor;
insert into instructor (name, salary, department_id)
values ('John', 120000, 14);

insert into instructor (name, salary, department_id)
values ('Bob', default, 10 + 5);

insert into instructor (id, name, salary, department_id)
values (default, 'Bob2', default, 10 + 5);

select * from instructor;


insert into instructor default
values;

insert into instructor (name, salary, department_id)
values ('Instructor name', (select salary from instructor where id = 297), 17);


insert into instructor (name, salary, department_id)
select name, salary, department_id
from instructor
where id < 306;

insert into instructor (salary, name, department_id)
values (120000, 'John1', 14),
       (130000, 'John2', 14),
       (140000, 'John3', 14),
       (150000, 'John4', 14)
returning *;
update instructor
set salary=200000
where id = 306
returning id, name, salary;

create table mana(
    name varchar(10),
    surname varchar(10)
);
create table mana1(
    name varchar(10),
    surname varchar(10)
);
alter table mana
    alter column name type varchar(50),
    alter column surname type varchar(50);

insert into mana values ('mana1', 'mana1.2'),
                        ('mana2' , 'mana2.2');
select * from mana;
update mana set name = 'Maneka', surname = 'HAHAHAHAHAH' where name = 'manarbek' ;

update mana set  name = 'makeshka' from mana1 where mana1.name = 'mana1' and mana.surname = 'mana1.2';