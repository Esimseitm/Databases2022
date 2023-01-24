DROP TABLE Packs;
DROP TABLE warehouses;
CREATE TABLE Warehouses
(
    code     SERIAL PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);

CREATE TABLE Packs
(
    code      CHAR(4),
    contents  VARCHAR(255),
    value     REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES Warehouses (code)
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

-- Step 4. Select all packs with all columns.
SELECT *
FROM Packs;
SELECT *
FROM warehouses;

-- Step 5. Select all packs with a value larger than $190.
SELECT *
FROM Packs
WHERE value > 190;

-- Step 6. Select all the packs distinct by contents.
SELECT DISTINCT(contents)
FROM Packs;

-- Step 7. Select the warehouse code and the number of the packs in
-- each warehouse.
SELECT warehouse, count(*)
FROM Packs
GROUP BY warehouse;

-- Step 8. Same as previous exercise,
-- but select only those warehouses where the number of the packs is greater than 2.Д
SELECT warehouse, count(*)
FROM Packs
GROUP BY warehouse
HAVING count(*) > 2;

-- Step 9. Create a new warehouse in Texas with a capacity for 5
-- packs.
INSERT INTO Warehouses(code, location, capacity)
VALUES (6, 'Texas', 5);

-- Step 10. Create a new pack, with code "H5RT",
-- containing "Papers" with a value of $150, and located in warehouse 2.
INSERT INTO Packs
VALUES ('H5RT', 'Papers', 150, 2);

-- Step 11. Reduce the value of the third largest pack by 18%.\
SELECT *
FROM Packs;
UPDATE Packs
SET value=value * 0.82
WHERE value = (SELECT value
               FROM Packs
               ORDER BY value
                DESC NULLS LAST OFFSET 2 LIMIT 1 );

-- Step 12. Remove all packs with a value lower than $150.
DELETE
FROM Packs
WHERE value < 150;

-- 13. Remove all packs which is located in Chicago. Statement
-- should return all deleted data.
DELETE
FROM Packs
    USING Warehouses
WHERE Packs.warehouse = Warehouses.code
  AND Warehouses.location = 'Chicago'
RETURNING *;
