
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



