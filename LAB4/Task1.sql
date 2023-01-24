-- 1 Create database called «lab4»
--CREATE DATABASE lab4;

-- Create following tables «Warehouses» and «Packs»:
DROP TABLE Packs;
DROP TABLE Warehouses;
CREATE TABLE Warehouses (
    code SERIAL NOT NULL,
    location CHARACTER VARYING(255) NOT NULL,
    capacity INTEGER NOT NULL
);

CREATE TABLE Packs (
    code CHARACTER(4)  NOT NULL,
    contents CHARACTER VARYING(255) NOT  NULL,
    value REAL NOT NULL,
    warehouse INTEGER NOT NULL
);


INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouse) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouse) VALUES ('TUSS', 'Papers', 90, 5);

-- check
SELECT *
FROM Warehouses;
SELECT *
FROM Packs;

--4 Select all packs with all columns.
SELECT *
FROM Packs;

-- 5 Select all packs with a value larger than $190.
SELECT *
FROM Packs
WHERE VALUE > 190;

-- 6 elect all the packs distinct by contents.
SELECT DISTINCT ON (contents) *
FROM Packs;

-- 7 Select the warehouse code and the number of the packs in each warehouse
SELECT warehouse,count(*)
FROM  Packs
GROUP BY warehouse;

-- 8 Same as previous exercise, but select only those warehouses where the number of the packs is greater than 2.
SELECT warehouse,  count(*)
FROM Packs
GROUP BY warehouse
HAVING count(*) > 2;

-- 9Create a new warehouse in Texas with a capacity for 5 packs.
INSERT INTO Warehouses (location, capacity)
values ('Texas', 5);
SELECT *
FROM Packs;

-- 10 Create a new pack, with code "H5RT", containing "Papers" with a value of $150, and located in warehouse 2
INSERT INTO Packs(code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 150, 2);

-- 11 Reduce the value of the third largest pack by 18%
UPDATE Packs
SET value = value * 0.82
WHERE code = (
    SELECT code
    FROM Packs
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
    )
SELECT *
FROM Packs;

-- 12 Remove all packs with a value lower than $150
DELETE
FROM Packs
WHERE value < 150;
SELECT *
FROM Packs;


-- 13  Remove all packs which is located in Chicago. Statement should
-- return all deleted data.

DELETE
FROM Packs
WHERE warehouse IN (
    SELECT code
    FROM Warehouses
    WHERE location = 'Chicago'
    )
RETURNING*;