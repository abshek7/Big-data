CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(50),
    month VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO sales (product, month, amount) VALUES
('Laptop', 'January', 1000),
('Laptop', 'February', 1200),
('Laptop', 'March', 900),
('Phone', 'January', 500),
('Phone', 'February', 700),
('Phone', 'March', 600),
('Tablet', 'January', 300),
('Tablet', 'February', 400),
('Tablet', 'March', 350);

SELECT * FROM sales;

SELECT
product,
SUM(CASE WHEN month='January' THEN amount ELSE 0 END) As January,
SUM(CASE WHEN month='February' THEN amount ELSE 0 END) As February,
SUM(CASE WHEN month='March' THEN amount ELSE 0 END) As March
FROM sales
GROUP BY product;