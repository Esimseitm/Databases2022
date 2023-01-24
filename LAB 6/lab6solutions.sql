-- Решение 7 лабороторной Есимсеит Манарбек
-- JOINS
-- A  find those clients with a priority less than 300
selecT * FROM client WHERE client.priority<300;

-- B - combine each row of dealer table with each row of client table
SELECT * FROM dealer CROSS JOIN client;
-- C c. find all dealers along with client name, city, priority, sell number, date, and amount
SELECT dealer.name,client.name,client.city,sell.id,client.priority,sell.date,sell.amount
FROM sell LEFT JOIN
    dealer ON dealer.id = sell.dealer_id LEFT JOIN
        client ON client.id = sell.client_id;
-- D find the dealer and client who reside in the same city
SELECT dealer.name,client.name,client.city FROM dealer INNER JOIN client
    ON  dealer.location = client.city;
-- E find sell id, amount, client name, city those sells where sell amount exists between
-- 200 and 500
SELECT sell.id,sell.amount,client.name,client.city
FROM sell INNER JOIN client ON sell.client_id = client.id
    AND sell.amount BETWEEN 200 AND 500;
-- f. find dealers who works either for one or more client or not yet join under any of
-- the clients
SELECT dealer.name, client.name FROM client LEFT JOIN dealer
    ON dealer.id=client.dealer_id
    ORDER BY dealer.id;
--g. find the dealers and the clients he service, return client name, city, dealer name,
-- commission.
SELECT client.name,client.city,dealer.name,dealer.commission FROM client LEFT JOIN dealer
    ON dealer.id=client.dealer_id;
-- h. find client name, client city, dealer, commission those dealers who received a
-- commission from the sell more than 13%
SELECT client.name,client.city,dealer.name,dealer.commission FROM client INNER JOIN dealer
    ON dealer.id=client.dealer_id AND dealer.commission > 0.13;
-- i. make a report with client name, city, sell id, sell date, sell amount, dealer name
-- and commission to find that either any of the existing clients haven’t made a
-- purchase(sell) or made one or more purchase(sell) by their dealer or by own.
SELECT client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.commission FROM sell INNER JOIN
    client ON sell.client_id = client.id INNER JOIN dealer ON sell.dealer_id = dealer.id;
-- j. find dealers who either work for one or more clients. The client may have made,
-- either one or more purchases, or purchase amount above 2000 and must have a
-- priority, or he may not have made any purchase to the associated dealer. Print
-- client name, client priority, dealer name, sell id, sell amount

SELECT client.name,client.city,client.priority, dealer.name, sell.id, sell.date, sell.amount FROM client LEFT JOIN dealer
    ON dealer.id=client.dealer_id LEFT JOIN sell
    ON sell.client_id=client.id
    WHERE sell.amount>=2000
        AND client.priority IS NOT NULL;

-- Вьюшки
--A
-- подсчитайте количество уникальных клиентов, вычислите среднюю и общую покупку
-- количество клиентских заказов на каждую дату
CREATE VIEW A AS (SELECT date, COUNT(DISTINCT id), AVG(amount),SUM(amount) FROM sell GROUP BY date);
SELECT * FROM A;

--B найти 5 лучших дат с наибольшей общей суммой продаж
CREATE VIEW B AS (SELECT date, SUM(amount) FROM sell GROUP BY date ORDER BY 2 DESC LIMIT 5);
SELECT * FROM B;

--C подсчитайте количество продаж, вычислите среднюю и общую сумму всех продажи каждого дилера
CREATE VIEW C AS (SELECT dealer_id, COUNT(DISTINCT id), AVG(amount),SUM(amount) FROM sell GROUP BY dealer_id);
SELECT * FROM C;

--D подсчитайте, сколько все дилеры заработали на комиссионных (общая сумма продаж сумма * комиссия) в каждой локации
CREATE VIEW D AS (SELECT dealer.name, sell.dealer_id, COUNT(sell.dealer_id), SUM(sell.amount) * dealer.commission AS earned
FROM sell INNER JOIN dealer ON sell.dealer_id = dealer.id
GROUP BY dealer_id, dealer.commission,dealer.name);
SELECT * FROM D;

--E вычислить количество продаж, среднее и общее количество всех продаж дилеров, сделанных в каждом месте
CREATE VIEW E AS (SELECT dealer.location, COUNT(DISTINCT sell.id), AVG(sell.amount), SUM(sell.amount) as am FROM sell INNER JOIN
    dealer ON sell.dealer_id = dealer.id GROUP BY dealer.location ORDER BY 2 ASC);
SELECT * FROM E;

--F вычислить количество продаж, среднюю и общую сумму расходов в каждый город клиенты сделали
CREATE VIEW F AS (SELECT client.city, COUNT(client.city), SUM(sell.amount), AVG(sell.amount)
    FROM client INNER JOIN sell ON client.id = sell.client_id
    GROUP BY client.city);
SELECT * FROM F;

--G найти города, в которых общие расходы превышают общий объем продаж в локации
CREATE VIEW e AS
    SELECT location,COUNT(sell.id) as "number_of_sales1",AVG(amount) as "average1",SUM(amount) as total1
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;

SELECT * from e;
DROP VIEW e;

CREATE VIEW f AS
    SELECT city,COUNT(sell.id) as "number_of_sales2",AVG(amount) as "average2",SUM(amount) as total2
    FROM client INNER JOIN sell ON client.id=sell.client_id
    GROUP BY city;
SELECT * from f;
CREATE VIEW g AS
    SELECT *
    FROM e INNER JOIN f on e.location = f.city
    WHERE f.total2>e.total1;

SELECT * from g;
