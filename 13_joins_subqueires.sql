SELECT * FROM employees;
SELECT * FROM departments;

SELECT e.first_name, e.last_name, e.department_id, d.department_id, d.name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
ORDER BY e.last_name
LIMIT 5;

SELECT * FROM employees WHERE department_id IS NULL;

SELECT * FROM addresses WHERE town_id IS NULL;
SELECT * FROM employees WHERE address_id IS NULL;

INSERT INTO addresses(address_text)
VALUES ('u nas'), ('u vas');

SELECT *
FROM addresses a
INNER JOIN towns t ON a.town_id = t.town_id;

SELECT *
FROM addresses a
LEFT JOIN towns t ON a.town_id = t.town_id;

INSERT INTO towns(name)
VALUES('timbuktu');

SELECT *
FROM addresses a
RIGHT JOIN towns t ON a.town_id = t.town_id;

SELECT first_name, last_name FROM employees
UNION
SELECT name, manager_id FROM departments;

SELECT *
FROM addresses a
LEFT JOIN towns t ON a.town_id = t.town_id
UNION
SELECT *
FROM addresses a
RIGHT JOIN towns t ON a.town_id = t.town_id;

SELECT * FROM projects;

USE camp;
SELECT * FROM peaks;
SELECT * FROM rooms;

SELECT * FROM peaks, rooms;

SELECT *
FROM peaks
JOIN rooms;

SELECT *
FROM peaks
CROSS JOIN rooms;

SELECT p.id, p.name, COUNT(r.id) AS 'Available rooms in hut'
FROM peaks p
JOIN rooms r ON r.id MOD p.id = 0
GROUP BY p.id;

USE soft_uni;
SELECT *
FROM employees e
INNER JOIN departments d ON e.first_name = d.name;

SELECT 
	e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS 'full_name', 
    d.department_id, 
	d.name
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;

SELECT t.town_id, t.name, a.address_text 
FROM towns t
INNER JOIN addresses a ON t.town_id = a.town_id
WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id, a.address_id;

SELECT employee_id, first_name, last_name, department_id, salary 
FROM employees 
WHERE manager_id IS NULL;

SELECT e.employee_id, e.first_name, e.last_name, m.employee_id, m.first_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.employee_id;


SELECT t.town_id, t.name, a.address_text 
FROM addresses a
INNER JOIN towns t ON a.town_id = t.town_id
WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id, a.address_id;

SELECT AVG(e.salary)
FROM employees e;

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(e.salary) FROM employees e);

SELECT department_id 
FROM departments 
WHERE department_id < 5;

SELECT first_name
FROM employees
WHERE department_id IN (
	SELECT department_id 
    FROM departments 
    WHERE department_id < 5
);

SELECT town_id
FROM towns
WHERE name IN ('San Francisco', 'Sofia', 'Carnation');

SELECT *
FROM addresses
WHERE town_id IN (
	SELECT town_id
	FROM towns
	WHERE name IN ('San Francisco', 'Sofia', 'Carnation')
);

SELECT 
	e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS 'full_name', 
    d.department_id, 
	d.name
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
WHERE d.department_id IN (
	SELECT department_id
	FROM departments
	WHERE name LIKE '%u%'
)
ORDER BY e.employee_id;

SELECT department_id
FROM departments
WHERE name LIKE '%u%';

SELECT department_id
FROM departments
WHERE department_id = 3;

SELECT * 
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM departments
	WHERE department_id = 3
    LIMIT 1
);

SELECT e.employee_id, e.first_name, ep.project_id, p.name
FROM employees e
INNER JOIN employees_projects ep ON e.employee_id = ep.employee_id
INNER JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.employee_id;

-- Foreign key guarantees that all employee_id records are existing
SELECT p.project_id, p.name, COUNT(ep.employee_id)
FROM projects p
INNER JOIN employees_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id;

-- If there was no foreign key
SELECT p.project_id, p.name, COUNT(e.employee_id)
FROM projects p
INNER JOIN employees_projects ep ON p.project_id = ep.project_id
INNER JOIN employees e ON ep.employee_id = e.employee_id
GROUP BY p.project_id;

SELECT p.project_id, p.name, ep.employee_id, e.address_id, a.town_id, t.name
FROM projects p
INNER JOIN employees_projects ep ON p.project_id = ep.project_id 
INNER JOIN employees e ON ep.employee_id = e.employee_id
INNER JOIN addresses a ON e.address_id = a.address_id
INNER JOIN towns t ON a.town_id = t.town_id
ORDER BY p.project_id;

