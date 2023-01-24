CREATE TABLE students(
    id int NOT NULL PRIMARY KEY,
    full_name varchar NOT NULL,
    age int NOT NULL CHECK(age > 0 and age < 100),
    student_id int NOT NULL,
    birth_date date NOT NULL,
    gender varchar NOT NULL CHECK(gender = 'Male' or gender = 'Female'),
    avg_grade int NOT NULL,
    nation varchar NOT NULL,
    phone_numb int NOT NULL,
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
