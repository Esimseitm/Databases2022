-- SOLUTIONS ASSIGNMENT 8 YESSIMSEIT MANARBEK

-- 1 a . Increments given values by 1 and returns it
CREATE or REPLACE FUNCTION a(x integer)
RETURNS integer AS
    $$
        begin
        return x+1;
        end;
    $$
language 'plpgsql';

select a(5);
drop function a;
-- 1 b b. Returns cube of number
CREATE or REPLACE FUNCTION b(INOUT a NUMERIC)
AS
    $$
        BEGIN
            a := a*a*a;
        end;
    $$
language 'plpgsql';
select b(5);
drop function b;
-- 1 c Returns sum of 2 numbers.
CREATE or REPLACE FUNCTION c(a integer,b integer)
returns integer as
    $$
        begin
            return a+b;
        end
    $$
language 'plpgsql';

select c(1,2);
drop function b;
-- 1 d d. Returns true or false if numbers are divisible by 2
CREATE or replace FUNCTION d(x integer)
returns boolean AS
    $$
        begin
            return x % 2 = 0;
        end;
    $$
language 'plpgsql';

select d(4);
drop function d;
-- 1 e Average sum of numbers
CREATE or REPLACE FUNCTION e(VARIADIC list NUMERIC[], OUT total NUMERIC, OUT average NUMERIC)
AS
    $$
        begin
            SELECT INTO total SUM(list[i])
            FROM generate_subscripts(list,1) g(i);

            SELECT INTO average AVG(list[i])
            FROM generate_subscripts(list, 1) g(i);
        end;
    $$
language 'plpgsql';
SELECT * FROM e(10,20,30);
drop function e;
-- f Returns count of numbers
CREATE or REPLACE FUNCTION f(VARIADIC list NUMERIC[], OUT count NUMERIC)
AS
    $$
        begin
            SELECT INTO count count(list[i])
            FROM generate_subscripts(list, 1) g(i);
        end;
    $$
language 'plpgsql';
SELECT * FROM f(10,20,30);
drop function f;


-- 1 g Checks some password for validity
CREATE or replace FUNCTION g(x text)
returns boolean as
    $$
        begin
            return exists(select REGEXP_MATCHES(x,'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'));
        end;
    $$
language 'plpgsql';
select * FROM g('masmasm51651');
select g('masmasm516515FFFF=98067856465/][/.,F1');
drop function g;
--1 h Returns two outputs, but has one input
create function h(a integer,out b varchar,out c varchar)
AS
    $$
    begin
        b=a+5;
        c=a*2;
    end;
    $$
language  'plpgsql';
select * from h(1);
drop function h;


-- 2 task Create a trigger that:
CREATE table people(
    id integer primary key,
    name varchar,
    date_of_birth date,
    age int,
    time timestamp
);

--2a
CREATE or replace FUNCTION ins_time()
returns trigger AS
    $$
        begin
            new.time = now();
            return new;
        end;
    $$
language 'plpgsql';

create trigger calc_time before insert or update on people
    for each row execute procedure ins_time();

insert into people(id, name) values (1, 'Manarbek');
update people set name = 'Make' where name = 'Manarbek';

drop trigger calc_time on people;
--2b
create or replace FUNCTION age()
returns trigger AS
    $$
        begin
            new.age = date_part('year', age(new.date_of_birth));
            return new;
        end;
    $$
language 'plpgsql';
create trigger calc_age before insert on people
    for each row execute procedure age();
insert into people(id, name, date_of_birth)  values (11, 'Manarbek', '04-04-2004');

drop trigger calc_age on people;
-- 2c
CREATE table product(
    id integer primary key,
    name varchar,
    price integer
);

create or replace FUNCTION price()
returns trigger as
    $$
        begin
            update product
            set price=price+0.12*price
            where id = new.id;
            return new;
        end;
    $$
language 'plpgsql';

create trigger calc_price after insert on product
    for each row execute procedure price();

insert into product(id, name,price) values (1, 'orange', 200);

insert into product(id,name,price) values (3, 'banana', 223);

drop trigger calc_price on product;

-- 2d
create or replace function stop_del() returns trigger
    as $$
    begin
        insert into product(id,name,price) values(old.id,old.name,old.price);
        return old;
    end;
    $$
language 'plpgsql';

create trigger del_changes after delete on product
    for each row execute procedure stop_del();

delete from product where id=1;
select * from product;

drop trigger del_changes on product;
-- 2e
drop table test;
create table test(
    test1 integer,
    test2 NUMERIC[],
    valid1 boolean,
    test3 integer
);

create or replace function test_e() returns trigger
    as $$
    begin
        new.valid1 = d(new.test1);
        new.test3 = e(new.test2);
        return new;
    end;
    $$
language 'plpgsql';

create or replace trigger test1 before insert or update on test
    for each row execute procedure test_e();

insert into test (test1, test2)
values (4 ,'{10, 20, 40}');
drop trigger test1 on test;


--  3task
create table employee(
    id int primary key,
    name varchar,
    date_of_birth date,
    age int,
    salary int,
    workexperience int,
    discount int
);
insert into employee values (1,'Manarbek','23-05-2004',18,10000,5,1);
--3a
CREATE or replace procedure function1() as
$$
    begin
        update employee
        set salary = (workexperience/2)*1.1*salary,
            discount = (workexperience/2)*10 + employee.discount;
        update employee set discount = (workexperience/5) + employee.discount;
        commit;
    end;
    $$
language 'plpgsql';

call function1();
-- 3b
create or replace procedure function2() as
    $$
        begin
            update employee
            set salary = salary*1.15
            where age >= 40;
            update employee
            set salary = salary*1.15*(workexperience/8);
            update employee
            set discount = 20 where workexperience >= 8;
            commit;
        end;
    $$
language 'plpgsql';
call function2();
