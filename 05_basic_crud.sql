SELECT * FROM employees;
SELECT * FROM departments;

SELECT id, first_name, last_name, job_title
FROM employees
ORDER BY id;

SELECT 
	id AS '#',
    first_name AS 'First Name',
    last_name AS "Last Name",
    job_title AS "Job Title"
FROM employees;

SELECT 
	e.id,
    e.first_name
FROM employees AS e;

SELECT 
	`id`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'Full Name'
FROM `employees`;

SELECT 
	`id`,
    CONCAT(`first_name`, ' ', `last_name`, ' ', `job_title`) AS 'Full Info'
FROM `employees`;

SELECT 
	id,
    CONCAT_WS(' -- ', first_name, last_name, job_title) AS 'Full Info WS'
FROM employees;

SELECT 
	`id`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'full_name',
    `job_title`,
    `salary`
FROM `employees`
WHERE `salary` > 1000;

SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT first_name
FROM employees;

SELECT *
FROM `employees`
WHERE `department_id` = 1;

SELECT *
FROM employees
WHERE first_name = 'John';

SELECT * 
FROM employees
WHERE salary > 1000 AND salary < 1500;

-- BETWEEN uses >= AND <=
SELECT *
FROM `employees`
WHERE `salary` BETWEEN 1000 AND 1500;

SELECT * 
FROM employees
WHERE department_id = 2 OR department_id = 3;

SELECT *
FROM employees
WHERE department_id IN (2, 3);

SELECT *
FROM employees
WHERE department_id <> 3;

SELECT *
FROM employees
WHERE NOT (department_id = 2 OR department_id = 3);

SELECT *
FROM `employees`
WHERE `department_id` = 4 AND `salary` >= 1000
ORDER BY `id`;

SELECT * 
FROM clients
WHERE last_name IS NOT NULL;

SELECT * 
FROM employees
ORDER BY department_id DESC;

SELECT *
FROM employees
ORDER BY department_id ASC, salary DESC;

DROP VIEW `v_hr_it_salary_threshold`;
CREATE VIEW `v_hr_it_salary_threshold` AS
	SELECT `id`, `first_name`, `last_name`
	FROM `employees`
	WHERE `department_id` = 4 AND `salary` >= 1000
	ORDER BY `id`;
    
SELECT *
FROM v_hr_it_salary_threshold;

SELECT id, first_name
FROM v_hr_it_salary_threshold
WHERE first_name = 'Smith';
    
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Implicit LIMIT by the IDE 
SELECT *
FROM employees;

CREATE VIEW v_top_paid_employee AS
	SELECT *
	FROM employees
	ORDER BY salary DESC
	LIMIT 1;
    
SELECT *
FROM v_top_paid_employee;

SELECT * FROM rooms;

INSERT INTO `rooms`(`type`) VALUES ('double room');

INSERT INTO clients(first_name, room_id)
VALUES 
	('Ivan', 3),
	('Alex', 1),
    ('Yana', 2);
    
CREATE TABLE employees_tmp AS
	SELECT id, first_name, salary
	FROM employees;
    
SELECT * FROM employees_tmp;

SELECT 
	id + 9,
    last_name,
    salary * 4.3
FROM employees;

INSERT INTO `employees_tmp`(`id`, `first_name`, `salary`)
	SELECT 
		`id` + 9,
		`last_name`,
		`salary` * 4.3
	FROM `employees`;
    
SELECT * FROM employees_tmp;

SELECT id, salary, salary * 1.1
FROM employees_tmp
WHERE id <= 10;

-- There is NO UNDO!!!
UPDATE `employees_tmp`
SET `salary` = `salary` * 1.10
WHERE id <= 10;



