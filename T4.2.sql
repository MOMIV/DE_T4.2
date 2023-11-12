CREATE TABLE if not exists sales (
id_sale serial, 
sale_date date, 
id_product int, 
amount int)
DISTRIBUTED BY (id_sale)
PARTITION BY RANGE (sale_date)
( START ('2023-01-01') INCLUSIVE
   END ('2023-02-01') EXCLUSIVE
   EVERY (INTERVAL '10 day') );

CREATE TABLE if not exists products (
id_product serial, 
prod_name text,
price numeric);

INSERT INTO sales (sale_date,id_product, amount) VALUES
('2023-01-01', 1, 5),
('2023-01-03', 3, 2),
('2023-01-04', 2, 1),
('2023-01-07', 1, 7),
('2023-01-10', 1, 5),
('2023-01-12', 2, 6),
('2023-01-14', 3, 10),
('2023-01-17', 1, 7),
('2023-01-18', 2, 3),
('2023-01-19', 1, 4),
('2023-01-21', 3, 2),
('2023-01-25', 1, 5),
('2023-01-26', 2, 6),
('2023-01-28', 3, 5),
('2023-01-30', 1, 2),
('2023-01-31', 3, 1);

INSERT INTO products (prod_name, price) VALUES
('Cheese', 9.99),
('Bread', 1.99),
('Milk', 2.99);

set optimizer = on;

EXPLAIN SELECT SUM(price*amount)
FROM sales_1_prt_2 AS s
JOIN products  AS p
ON s.id_product = p.id_product
WHERE s.id_product=3;  

SELECT SUM(price*amount)
FROM sales AS s
JOIN products  AS p
ON s.id_product = p.id_product
WHERE s.id_product=2 and  sale_date < '2023-01-15' ;