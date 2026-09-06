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