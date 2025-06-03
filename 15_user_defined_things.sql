SELECT *
FROM towns t
JOIN addresses a ON a.town_id = t.town_id
JOIN employees e ON e.address_id = a.address_id
WHERE name = 'Sofia';

SELECT *
FROM addresses 
WHERE town_id = 32;

SELECT * 
FROM employees
WHERE address_id = 291;

DROP FUNCTION ufn_count_employees_by_town;

DELIMITER $$

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE result INT;
    
	SET result := (SELECT COUNT(e.employee_id)
		FROM towns t
		JOIN addresses a ON a.town_id = t.town_id
		JOIN employees e ON e.address_id = a.address_id
		WHERE name = town_name);
    
    RETURN result;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN    
	RETURN (SELECT COUNT(e.employee_id)
		FROM towns t
		JOIN addresses a ON a.town_id = t.town_id
		JOIN employees e ON e.address_id = a.address_id
		WHERE name = town_name);
END$$

DELIMITER ;

SELECT ufn_count_employees_by_town('Sofia');

SELECT * FROM addresses;
SELECT * FROM towns WHERE town_id = 5;

-- SELECT *
-- FROM ...
-- WHERE ufn_count_employees_by_town('Sofia') = 10;

-- SELECT FLOOR(ufn_count_employees_by_town('Sofia'));

SELECT *
FROM employees
WHERE first_name = 'John' AND last_name = 'Chen';

SELECT * FROM departments;

DROP PROCEDURE usp_create_department;

DELIMITER $$

CREATE PROCEDURE usp_create_department(
	department_name VARCHAR(50), 
    manager_first_name VARCHAR(50),
    manager_last_name VARCHAR(50),
    OUT new_department_id INT)
BEGIN
	DECLARE manager_id INT;
    
    SET manager_id := (
		SELECT employee_id
		FROM employees
		WHERE first_name = manager_first_name AND 
			last_name = manager_last_name
    );
    
    INSERT INTO departments(name, manager_id)
		VALUES(department_name, manager_id);
        
	SET new_department_id := (SELECT department_id 
		FROM departments
        ORDER BY department_id DESC
        LIMIT 1
	);
END$$

DELIMITER ;

SET @new_id = 0;
CALL usp_create_department('New ID Dept', 'John', 'Chen', @new_id);

SELECT @new_id;
SELECT * FROM departments WHERE department_id = @new_id;

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(dept_name VARCHAR(50))
BEGIN
	UPDATE employees 
    SET salary = salary * 1.05
    WHERE department_id = (
		SELECT department_id FROM departments WHERE name = dept_name
	);
END$$

DELIMITER ;

SELECT * FROM departments;
SELECT * FROM employees WHERE department_id = 10;

CALL usp_raise_salaries('Finance');

UPDATE employees AS e 
JOIN departments AS d 
ON e.department_id = d.department_id 
SET salary = salary * 1.05
WHERE d.name = 'Finance';

DROP PROCEDURE usp_select_result;
DELIMITER $$

CREATE PROCEDURE usp_select_result(dept_name VARCHAR(50))
BEGIN
	IF dept_name IS NOT NULL THEN
		SELECT * 
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        WHERE d.name = dept_name;
    END IF;
END$$

DELIMITER ;

CALL usp_select_result(NULL);
CALL usp_select_result('Sales');

DROP PROCEDURE usp_raise_salary_by_id;

DELIMITER $$

CREATE PROCEDURE usp_raise_salary_by_id(e_id INT)
BEGIN
	DECLARE e_count INT;
    
    START TRANSACTION;
    
    SET e_count := (SELECT COUNT(*) FROM employees WHERE employee_id = e_id);
    
    UPDATE employees 
    SET salary = salary * 1.05
    WHERE employee_id = e_id;
    
    IF e_count = 0 THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END$$

DELIMITER ;

SELECT * FROM employees WHERE employee_id = 7777;

CALL usp_raise_salary_by_id(17);

CREATE TABLE `tmp_towns`(
	`id` INT, 
	`count` INT DEFAULT 0,
    `names` VARCHAR(200)
);

INSERT INTO tmp_towns VALUES (1, 0, '');
SELECT * FROM tmp_towns;

DROP TRIGGER trg_copy_to_tmp;

DELIMITER $$

CREATE TRIGGER trg_copy_to_tmp
AFTER INSERT
ON towns
FOR EACH ROW
BEGIN
	UPDATE tmp_towns 
    SET `count` = `count` + 1,
		names = CONCAT(names, ',', NEW.name)
    WHERE id = 1;
END$$

DELIMITER ;

INSERT INTO towns(name) VALUES ('Data Town'), ('Data Town2'), ('Data Town 3');
SELECT * FROM tmp_towns;

CREATE TABLE deleted_employees_2 AS 
	SELECT 
		employee_id, 
		first_name, 
        last_name, 
        middle_name, 
        job_title, 
        department_id, 
        salary
	FROM employees
    WHERE 0 = 1;
    
TRUNCATE deleted_employees;
SELECT * FROM deleted_employees;

DELIMITER $$

CREATE TRIGGER trg_copy_deleted_employee
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name, last_name, middle_name,
		job_title, department_id, salary)
    VALUES (OLD.first_name, OLD.last_name, OLD.middle_name,
			OLD.job_title, OLD.department_id, OLD.salary);
END $$

DELIMITER ;

DELETE FROM employees WHERE employee_id = 2;
SELECT * FROM deleted_employees;

SELECT *
FROM employees e
LEFT JOIN employees_projects ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL
LIMIT 1000;

SELECT COUNT(*) FROM employees_projects;

SELECT department_id FROM departments WHERE name = 'Sales';

UPDATE employees 
SET salary = salary * 1.05
WHERE department_id = (
	SELECT department_id FROM departments WHERE name = 'Sales'
);

SET @dept_id := (SELECT department_id FROM departments WHERE name = 'Sales');
SELECT @dept_id;

UPDATE employees 
SET salary = salary * 1.05
WHERE department_id = @dept_id;