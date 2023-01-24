CREATE TABLE book
(
    book_id integer,
    title    varchar(50),
    author  varchar(50),
    price   decimal(8, 2),
    amount  integer
);

ALTER TABLE
book

ADD PRIMARY KEY (book_id);

TRUNCATE TABLE book;

DROP TABLE book;

INSERT INTO book VALUES ('1', 'Database introduction', 'Abraham Silberschatz', '455.22', '3');

DELETE FROM book WHERE title = 'Database introduction';

UPDATE book SET book_id = '1' WHERE book_id = '2';

SELECT title FROM book WHERE book_id = '1';

-- TASK 2

CREATE TABLE students(
    id int NOT NULL PRIMARY KEY,
    full_name varchar NOT NULL,
    age int NOT NULL CHECK(age > 0 and age < 100),
    student_id int NOT NULL,
    birth_date date NOT NULL,
    gender varchar NOT NULL CHECK(gender = 'Male' or gender = 'Female'),
    avg_grade int NOT NULL,
    nation varchar NOT NULL,
    phone_numb varchar NOT NULL,
    soc_categ varchar NOT NULL
);
CREATE TABLE instructors(
    id int NOT NULL PRIMARY KEY,
    full_name varchar NOT NULL,
    speak_lang  varchar NOT NULL,
    work_experience  varchar NOT NULL,
    remote_lessons boolean NOT NULL
);

CREATE TABLE relatives(
    student_id int REFERENCES students(id) PRIMARY KEY,
    full_name varchar NOT NULL,
    addres    varchar NOT NULL,
    phone_numb  varchar NOT NULL,
    posit  varchar NOT NULL
);

CREATE TABLE cos_students(
    student_id int NOT NULL  REFERENCES students(id) PRIMARY KEY,
    school varchar NOT NULL,
    graduation date NOT NULL,
    addres  varchar NOT NULL,
    region  varchar NOT NULL,
    country varchar NOT NULL,
    gpa numeric(2, 1) NOT NULL CHECK (gpa < 4.01),
    honors text
);

INSERT INTO students(id, full_name, age, student_id, birth_date, gender, avg_grade, nation, phone_numb, soc_categ) VALUES (405, 'MANARBEK', 51, 406, '2000-01-01', 'Male', 2005, 'kaz', '87777595111', 'no');
INSERT INTO cos_students(student_id, school, graduation, addres, region, country, gpa, honors) VALUES (405, 'USH', '2006-02-02', 'TOLE BI 59', 'ALMATY', 'KZ',  4.00, 'fddfdffd');
SELECT * FROM cos_students;
-- TASK 3 and 4
CREATE TABLE employees
(
    emp_no     INTEGER PRIMARY KEY,
    birth_date date,
    first_name VARCHAR(14),
    last_name  VARCHAR(16),
    gender     varchar CHECK (gender = 'Male' or gender = 'Female'),
    hire_date  date
);
CREATE TABLE salaries(
    emp_no INTEGER REFERENCES employees(emp_no),
    salary INTEGER ,
    from_date DATE,
    to_date DATE ,
    PRIMARY KEY(emp_no, from_date)
);

CREATE TABLE titles(
    emp_no INTEGER REFERENCES employees(emp_no),
    title VARCHAR(50),
    from_date DATE,
    to_date date,
    PRIMARY KEY (emp_no, title, from_date)
);


CREATE TABLE departments (
    dept_no CHAR(4) ,
    dept_name VARCHAR(40) ,
    PRIMARY KEY (dept_no)
);
CREATE TABLE dept_manager(
    dept_no CHAR(4) REFERENCES departments(dept_no),
    emp_no INTEGER REFERENCES employees(emp_no),
    from_date DATE ,
    to_date DATE ,
    PRIMARY KEY(dept_no, emp_no)
);

CREATE TABLE dept_emp (
    emp_no INTEGER REFERENCES employees(emp_no),
    dept_no CHAR(4) REFERENCES departments(dept_no),
    from_date DATE ,
    to_date DATE ,
    PRIMARY KEY (emp_no, dept_no)
);

INSERT INTO employees VALUES(1,'24.01.2000','sdfsdfsdf','sdfsdfsd', 'Male', '01.01.2000');
INSERT INTO salaries VALUES(1, 200, '01.01.2000', '01.01.2000');
INSERT INTO titles VALUES (1,'cucumber','01.01.2000', '01.01.2000');
INSERT INTO departments VALUES('d', 'dsfdfsd');
INSERT INTO dept_manager VALUES ('d', 1, '01.01.0202', '01.02.0202');
INSERT INTO dept_emp VALUES (1, 'd', '01.01.0202', '01.01.0101');

UPDATE employees SET first_name='Yerbolov Aidyn' WHERE first_name='sdfsdfsdf';
UPDATE salaries SET salary =300 WHERE salary = 200;
UPDATE titles SET title='pomidor' WHERE title = 'cucumber';
UPDATE departments SET dept_name = 'axaxaaxax' WHERE dept_name = 'dsfdfsd';
UPDATE dept_manager SET to_date ='19.01.1999' WHERE from_date = '01.01.0202';
UPDATE dept_emp SET from_date = '10.01.1001' WHERE to_date = '01.01.0101';

DELETE FROM employees WHERE first_name='Yerbolov Aidyn';
DELETE FROM salaries WHERE salary =300;
DELETE FROM titles WHERE title = 'pomidor';
DELETE FROM departments WHERE dept_name='axaxaaxax';
DELETE FROM dept_manager WHERE to_date = '19.01.1999';
DELETE FROM dept_emp WHERE from_date='10.01.1001';
