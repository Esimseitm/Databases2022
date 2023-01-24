CREATE DATABASE lab7;

create table locations
(
    location_id    serial primary key,
    street_address varchar(25),
    postal_code    varchar(12),
    city           varchar(30),
    state_province varchar(12)
);
create table departments
(
    department_id   serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id     integer references locations
);

create table employees
(
    employee_id    serial primary key,
    first_name     varchar(50),
    last_name      varchar(50),
    email          varchar(50),
    phone_number   varchar(20),
    salary         integer,
    department_id  integer references departments
);
--3 Enter 5 values rows to each table locations, department
--employees. The values of column department id should be: 40, 50, 60,
--70, 80
INSERT INTO locations(street_address, postal_code, city, state_province)
VALUES ('221b Baker Street', 'BS01', 'London', 'Gr London'),
       ('20 W 34th St.', 'empstbl02', 'New-York', 'New-York'),
       ('1 Apple Park Way', 'apple03', 'Cupertino', 'California'),
       ('1-7-1 Konan', 'sony04', 'Tokyo', 'Tokyo'),
       ('Tole bi 59', 'kbtu05', 'Almaty', 'Almaty');

INSERT INTO departments(department_id, department_name, budget, location_id)
VALUES (30, 'Sherlock Holmes office', 500000, 1),
       (50, 'Empire State Building', 600000, 2),
       (60, 'Apple', 700000, 3),
       (70, 'Sony', 800000, 4),
       (80, 'KBTU', 900000, 5);

INSERT INTO employees(first_name, last_name, email, phone_number, salary, department_id)
VALUES ('Makoto', 'Sinkai', 'makotosinkay@gmail.com', '87772821101', 200000, 70),
       ('Sherlock', 'Holmes', 'sherLock@gmail.com', '87772821102', 120000, 30),
       ('Elliot', 'Anderson', 'fsociety@gmail.com', '87772821103', 130000, 50),
       ('Tim', 'Cook', 'makeMoney@gmail.com', '87772821104', 1000000, 60),
       ('Manarbek', 'Yessimseit', 'manarbekyessimseit@gmail.com', '87772821105', 200000, 80);

--4  Select the first name, last name, department id, and department name for each employee.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees as e
          NATURAL JOIN departments as d;

--5  Select the first name, last name, department id and department name, for all employees for departments 80 or 30.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees AS e
         JOIN departments AS d ON e.department_id = d.department_id AND (d.department_id = 80 OR d.department_id = 30);

--6  Select the first and last name, department, city, and state  province for each employee.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees AS e
         JOIN departments AS d ON e.department_id = d.department_id
         JOIN locations AS l ON d.location_id = l.location_id;


INSERT INTO locations(street_address, postal_code, city, state_province)
VALUES  ('Arbat 15', 'mosque', 'Moscow', 'Moscow');

INSERT INTO departments(department_id, department_name, budget, location_id)
VALUES  (90, 'ROSCOSMOS', 10000000, 6 );

INSERT INTO employees(first_name, last_name, email, phone_number, salary)
VALUES   ('Ronaldo', 'Cristiano', 'nomerodinfoot@gmail.com', '8777775616', 2000000);

INSERT INTO employees(first_name, last_name, email, phone_number, salary, department_id)
VALUES   ('Vladimir', 'Putin', 'president01@gmail.com', '8777775616', 2000000, 90);
--7  Select all departments including those where does not have  any employee.
SELECT *
FROM departments AS d
         LEFT JOIN employees AS e ON d.department_id = e.department_id;

--8  Select the first name, last name, department id and name, for  all employees who have or have not any department.
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees AS e
          LEFT OUTER JOIN departments AS d ON e.department_id = d.department_id;

--9 Select the employee last name, first name , who works in Moscow city
SELECT e.last_name, e.first_name, l.city
FROM employees AS e
         JOIN departments AS d ON e.department_id = d.department_id
         JOIN locations AS l ON d.location_id = l.location_id
WHERE l.city = 'Moscow';

