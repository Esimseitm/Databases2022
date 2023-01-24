
DROP TABLE department;

CREATE TABLE department(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    building VARCHAR(100)
);



CREATE TABLE department_child (
    budget integer
)
    inherits (department)

Create table r(
    name varchar(20)
);
insert into r values ('b5'),
                     ('b____'),
                    ('ber'),
                    ('bere'),
                    ('berek')
                    ('bereke');

