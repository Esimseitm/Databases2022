DROP TABLE instructor;
CREATE TABLE instructor (
    id int,
    name varchar(50),
    salary int,
    department_id int
);
DROP TABLE "Department";
create table "Department" (
    id serial primary key,
    "Name" varchar(30)
);
/* comment
SELECT * FROM "Department";
SELECT "Name" FROM "Department";
*/
-- DML INSERT , UPDATE,  DELETE
-- INSERT - create new rows in a table

INSERT INTO instructor (id, name, salary, department_id) VALUES (5, 'john', 1000,5  );

INSERT INTO instructor default values ;

select * from instructor;


INSERT INTO instructor (id, name_, salary, department_id)
VALUES (default, 'BADANAME',   select salary from instructor id = 1, 1 );



INSERT INTO instructor default values ;

select * from instructor;
