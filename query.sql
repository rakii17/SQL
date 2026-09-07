-- Create Database
CREATE DATABASE sales;

SHOW DATABASES;

-- Create Table
CREATE TABLE stores
(
	store_id INT,
    store_name VARCHAR(200)
);

-- Insert Records
INSERT INTO stores_new VALUES
(1,"store1"),
(2,"store2");

INSERT INTO stores(store_id) VALUES
(3);

-- Create Table 2
CREATE TABLE stores_new
(
	store_id INT UNIQUE,
    store_name VARCHAR(200) NOT NULL
);

DROP TABLE stores;

TRUNCATE TABLE stores_new;

-- Alter Table
ALTER TABLE stores_new
ADD COLUMN store_city VARCHAR(200);

-- USE DATABASE ecom
-- FIRST SELECT
SELECT
	*
FROM
	dim_customer
LIMIT 3;

-- FIRST SELECT & LIMIT
SELECT
	customer_id,
    email
FROM
	dim_customer
LIMIT 3;

-- WHERE
SELECT
	*
FROM
	dim_customer
WHERE
	(gender = 'F') AND (country = 'Qatar'); 
    
-- LIKE
SELECT
	*
FROM
	dim_customer
WHERE
	first_name LIKE 'R%h';
    
SELECT
	*
FROM
	dim_customer
WHERE
	first_name LIKE 'R_be%'
LIMIT 2;

-- Sorting
SELECT
	*
FROM
	dim_product
ORDER BY
	unit_price DESC
LIMIT 2;

-- Grouping
SELECT
	category,
    avg(unit_price) as avg_price,
    sum(unit_price) as total_price
FROM
	dim_product
GROUP BY
	category
HAVING
	avg_price > 500;
    
-- USE DATABASE sales | JOINS
CREATE TABLE orders
(
	o_id INT,
    cust_id INT,
    price INT
);

INSERT INTO orders VALUES
(1,101,1000), 
(2,202,1100), 
(3,501,1200);

CREATE TABLE customer
(
	id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customer VALUES
(101,'abc','aa'), 
(201,'xyz','zz'), 
(301,'pqr','rr');

