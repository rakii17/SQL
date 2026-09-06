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
INSERT INTO stores VALUES
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