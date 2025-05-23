SELECT * FROM categories;
SELECT * FROM products;

SELECT * FROM departments;
SELECT * FROM employees;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT *
FROM employees;

-- make last_name nullable + set some names to NULL
SELECT 
	department_id, 
    COUNT(*), -- most common, just count the rows in each group
    COUNT(1), -- just count the rows in each group
    COUNT(id), -- count in how many rows for each group id cell has data 
    COUNT(last_name) -- count in how many rows for each group last_name cell has data 
FROM employees
GROUP BY department_id;

SELECT 
	`department_id`,
    COUNT(`id`) AS 'Number of employees'
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

DESCRIBE employees;
SELECT COUNT(*) FROM employees;

SELECT department_id, MAX(salary) -- , MAX(first_name)
FROM employees
GROUP BY department_id;

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, AVG(salary) -- ignores the NULL + ignores the for the count
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary) / COUNT(id)
FROM employees
GROUP BY department_id;

SELECT 
	department_id,
    ROUND(AVG(salary), 2) AS 'Average Salary'
FROM employees
GROUP BY department_id;

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 800;

-- Produces error
SELECT department_id, SUM(salary)
FROM employees
WHERE SUM(salary) > 3000
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 3000;

SELECT 
	`department_id`, 
    SUM(`salary`) AS 'Total Salary'
FROM `employees`
GROUP BY `department_id`
HAVING `Total Salary` > 3000;

SELECT *
FROM categories;

SELECT *
FROM products;

SELECT COUNT(*)
FROM products
WHERE price > 8 AND category_id = 2;

SELECT 
	category_id,
    ROUND(AVG(price), 2) AS 'Average Price',
    MIN(price) AS 'Cheapest Product',
    MAX(price) AS 'Most Expensive Product'
FROM products
GROUP BY category_id;

SELECT last_name, department_id, COUNT(*)
FROM employees
GROUP BY last_name, department_id;
-- first  d_id count
-- Parker	2	2
-- NULL		1	1
-- Parker	1	1
-- Willis	2	1
-- McGee	1	1
-- Willis	3	1
-- Boren	3	2
-- Salary	4	2

SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50) AFTER first_name;

ALTER TABLE employees
ADD COLUMN last_one INT;