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
(2,202,1100), -- (2,201,1100)
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

UPDATE orders
SET cust_id = 201
WHERE o_id = 2;

-- INNER JOIN
SELECT 
	*
FROM
	orders o
INNER JOIN
	customer c
	ON
		o.cust_id = c.id;
        
-- LEFT JOIN
SELECT 
	*
FROM
	orders o
LEFT JOIN
	customer c
	ON
		o.cust_id = c.id;
        
-- RIGHT JOIN
SELECT 
	*
FROM
	orders o
RIGHT JOIN
	customer c
	ON
		o.cust_id = c.id;
        
-- FULL JOIN (won't support directly. Have to use UNION)
SELECT 
	*
FROM
	orders o
LEFT JOIN
	customer c
	ON
		o.cust_id = c.id

UNION
        
SELECT 
	*
FROM
	orders o
RIGHT JOIN
	customer c
	ON
		o.cust_id = c.id;

-- UPDATE
UPDATE 
	customer
SET 
	name = 'mno'
WHERE 
	id = 201;
    
-- DELETE
DELETE FROM customer
WHERE 
	email = 'rr';

-- USE DATABASE ecom | TRANSORMATIONS
-- Numeric Transformations
SELECT 
	unit_price,
	unit_price * 0.85 as discounted_price,
    unit_price + 10 as tariffed_price,
    ROUND(unit_price,1) as rounded_price
FROM
	dim_product
LIMIT 3;

-- DATE Transformations
SELECT
	date,
    YEAR(date),
    MONTH(date),
    DAY(date),
    WEEKDAY(date),
    DAYNAME(date),
    DATE(utc_timestamp()),
    DATEDIFF(DATE(utc_timestamp()),date) total_days,
    ADDDATE(date,3),
    SUBDATE(date,3),
    CAST('2026-09-06' AS DATETIME)
FROM
	dim_date
LIMIT 4;

SELECT 
	date,
    date_format(date, "%W %M %e %Y") as converted_date
FROM
	dim_date
LIMIT 3;

-- TYPE CASTING
SELECT
	customer_key,
    CAST(customer_key AS CHAR(100)) AS cust_str,
    first_name,
    last_name,
    CONCAT(first_name,' ',last_name) AS full_name,
    CONCAT_WS(' ',first_name, last_name,country) AS concat_ws,
    LENGTH(country) AS country_len,
    LOWER(city),
    SUBSTRING(email,1,5),
    REPLACE(email,'@','#'),
    LEFT(state,5),
    REVERSE(join_date),
    REPEAT(first_name,2)
FROM
	dim_customer
LIMIT 3;

-- CONDITIONALS
-- CASE WHEN
SELECT
	*,
    CASE
		WHEN unit_price <= 400 THEN 'affordable'
		WHEN unit_price <= 600 THEN 'normal'
		ELSE 'expensive (but not for you!!)'
    END AS price_category
FROM
	dim_product
LIMIT 5;

SELECT
	*,
    CASE
		WHEN unit_price <= 400 AND category = 'clothing' THEN 'affordable'
		WHEN unit_price <= 600 AND category = 'clothing' THEN 'normal'
        WHEN unit_price > 600 AND category = 'clothing' THEN 'expensive (but not for you!!)'
		ELSE CONCAT('Not for ',category)
    END AS price_category
FROM
	dim_product
LIMIT 7;

SELECT
	*,
    CASE
		WHEN launch_date BETWEEN '2020-01-01' AND '2022-12-31' THEN 'oldest launch'
        WHEN launch_date BETWEEN '2023-01-01' AND '2024-12-31' THEN 'old launch'
        ELSE 'recent launch'
	END AS launch_time
FROM
	dim_product
LIMIT 5;


-- WINDOW FUNCTIONS | RUNNING TOTAL
SELECT
	*,
    SUM(unit_price) OVER(ORDER BY unit_price)
FROM
	dim_product
LIMIT 4;

-- MOVING AVERAGE
SELECT
	*,
    AVG(unit_price) OVER(ORDER BY launch_date)
FROM
	dim_product
LIMIT 4;

-- FRAMES
SELECT
	*,
    SUM(unit_price) OVER(ORDER BY launch_date ROWS BETWEEN unbounded preceding AND current row)
FROM
	dim_product
LIMIT 4;

SELECT
	*,
    SUM(unit_price) OVER(ORDER BY launch_date ROWS BETWEEN unbounded preceding AND unbounded following)
FROM
	dim_product
LIMIT 4;

-- RANKING
SELECT
	unit_price,
    ROW_NUMBER() OVER(ORDER BY unit_price) AS 'row_number',
    RANK() OVER(ORDER BY unit_price) AS 'rank',
	DENSE_RANK() OVER(ORDER BY unit_price) AS 'dense_rank'
FROM
	dim_product
LIMIT 5 OFFSET 454;

SELECT
	unit_price,
    category,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY unit_price) AS 'row_number',
    RANK() OVER(PARTITION BY category ORDER BY unit_price) AS 'rank',
	DENSE_RANK() OVER(PARTITION BY category ORDER BY unit_price) AS 'dense_rank'
FROM
	dim_product
LIMIT 4 OFFSET 85;

-- SUBQUERIES
SELECT
	*
FROM
	dim_product
WHERE
	unit_price > (SELECT AVG(unit_price) 
					FROM dim_product)
LIMIT 5;

SELECT
	*
FROM (
	SELECT
		*
	FROM
		dim_product
	WHERE
		unit_price > (SELECT AVG(unit_price) 
						FROM dim_product)
	LIMIT 6
) as subquery_table
WHERE
	category = 'Clothing';
    
-- CTEs
WITH cte_table AS
(
SELECT
	*
FROM
	dim_product
WHERE
	unit_price > (SELECT AVG(unit_price) 
					FROM dim_product)
LIMIT 5
)
SELECT * FROM cte_table
WHERE
	category IN ('Sports', 'Books');

-- CTEs 2
WITH cte_table AS
(
SELECT
	*
FROM
	dim_product
WHERE
	unit_price > (SELECT AVG(unit_price) 
					FROM dim_product)
LIMIT 5
),
cte_table2 AS
(
	SELECT * FROM cte_table
	WHERE category NOT IN ('Sports', 'Books')
)
SELECT * FROM cte_table2
WHERE
	product_name LIKE 'F%';
	
-- REAL TIME SCENARIOS
-- Finding the nth value
SELECT
	subquery.*
FROM
(
SELECT
	*,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY unit_price DESC) AS ranking
FROM
	dim_product
) AS subquery
WHERE
	ranking = 2;
    
-- Removing Duplicates | USE DATABASE sales
INSERT INTO customer VALUES
('301', 'ijk','ii'),
('101','abc','aa');

-- Removing Duplicates | USE DATABASE sales
SELECT
	subquery.*
FROM
(
SELECT
	*,
    ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
FROM
	customer
) as subquery
WHERE
	row_num = 1;
    
-- Lag and Lead | USE DATABASE sales
CREATE TABLE weather
(
	id INT,
    temp FLOAT
);

INSERT INTO weather VALUES
(1,10),
(2,12),
(3,9),
(4,15),
(5,20),
(6,17),
(7,14);

-- Lag and Lead
SELECT
	*,
    LAG(temp,1,'not available') OVER(ORDER BY id ASC) AS prev_day_temp,
    LAG(temp,2,'not available') OVER(ORDER BY id ASC) AS prev_2days_temp,
    LEAD(temp,1,'not available') OVER(ORDER BY id ASC) AS next_day_temp,
    LEAD(temp,2,'not available') OVER(ORDER BY id ASC) AS next_2days_temp
FROM
	weather;