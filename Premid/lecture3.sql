CREATE DATABASE preendterm;

Create table department (
    id serial primary key,
    name varchar (100),
    building varchar(100)
);
insert into department (name, building)
values ('FIT', 'KBTU');

select * from department;

create table department_copy
(
    like department including all
);
create table department_child
(
    budget integer
)
    inherits (department);
delete
from department;
select *
from department;
insert into department_child (name, building, budget)
VALUES ('FIT', 'KBTU', 100000);

insert into department (name, building)
VALUES ('BS', 'KBTU');
select *
from department_child;

select *
from department_copy;
insert into department_child (name, building, budget)
VALUES ('FEOGI', 'KBTU', 100000);
select *
from department;
create tablespace lecture_tablespace2
    location 'C:\Users\Manarbek\Desktop\DATABASES\LECTURE\3';
create table instructor
(
    id     serial
        constraint instructor_pk primary key,
    name   varchar(100),
    salary integer default 0
)
    tablespace lecture_tablespace2;
create table instructor
(
    id     serial
        constraint instructor_pk primary key,
    name   varchar(100),
    salary integer default 0
);
insert into instructor (name, salary)
VALUES ('John', 100000);

select *
from instructor;
alter table instructor
    alter column name type varchar(200);
alter table instructor
    alter column salary set default 1000;
alter table instructor
    add column department_id integer references department (id);
alter sequence instructor_id_seq restart with 5;
alter sequence instructor_id_seq increment by 3;

drop table test_char;
create table test_char
(
    first  varchar(5),
    second char(5),
    third  text,
    fourth bytea
);

insert into test_char (first, second, third, fourth)
VALUES ('abc', 'abc', 'asdfjaskjdfalskdfhaskjhfasjdhf', 'hello world');

insert into test_char (first, second, third, fourth)
VALUES ('abc', 'abc', 'asdfjaskjdfalskdfhaskjhfasjdhf', '\000'::bytea);
select *
from test_char;


create table test_date
(
    first  timestamp without time zone,
    second timestamp with time zone,
    third  date,
    fourth time without time zone,
    fifth  time with time zone,
    sixth  interval hour to minute
);

insert into test_date (first, second, third, fourth, fifth, sixth)
VALUES ('2004-10-19 10:23:54+02', '2004-10-19 10:23:54+02', now(), now(), now(), '3 days 4 hours 5 minutes 6 seconds');
select * from test_date;