CREATE DATABASE mountains;
USE mountains;

CREATE TABLE `mountains`(
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountain_id_mountains_id
    FOREIGN KEY (mountain_id)
    REFERENCES mountains(id)
);

DESCRIBE peaks;
SHOW CREATE TABLE peaks;

INSERT INTO mountains(name)
VALUES('Rodopi');

INSERT INTO peaks(name, mountain_id)
VALUES ('Musala', 2);

SELECT *
FROM peaks
JOIN mountains ON peaks.mountain_id = mountains.id;

SELECT p.id, p.name, m.name
FROM peaks AS p
JOIN mountains AS m ON p.mountain_id = m.id;

SELECT p.id, p.name, m.name
FROM peaks p
JOIN mountains m ON p.mountain_id = m.id;

SELECT * FROM mountains;
DELETE FROM mountains WHERE id = 1;

USE camp; 
SELECT * FROM vehicles;
SELECT * FROM campers;

SELECT 
	v.driver_id, 
    v.vehicle_type,
    CONCAT(c.first_name, ' ', c.last_name) AS 'driver_name'
FROM vehicles v
JOIN campers c ON v.driver_id = c.id;

SELECT 
	r.starting_point, 
    r.end_point, 
    r.leader_id,
    CONCAT(c.first_name, ' ', c.last_name) AS 'leader_name'
FROM routes r
JOIN campers c ON r.leader_id = c.id;

CREATE TABLE `mountains`(
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountain_id_mountains_id
    FOREIGN KEY (mountain_id)
    REFERENCES mountains(id)
    ON DELETE CASCADE
);

SELECT * FROM peaks;
SELECT * FROM mountains;

SELECT *
FROM peaks p
JOIN mountains m ON p.mountain_id = m.id;

INSERT INTO mountains(name)
VALUES ('Pirin');

INSERT INTO peaks(name, mountain_id)
VALUES ('Vihren', 1),
	('Bezbog', 1);
    
SELECT * FROM peaks;
DELETE FROM mountains WHERE id = 1;

CREATE DATABASE clients;
USE clients;

CREATE TABLE clients(
	id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100)
);

CREATE TABLE projects(
	id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    project_lead_id INT,
	CONSTRAINT fk_projects_clients
    FOREIGN KEY (client_id)
    REFERENCES clients(id)
);

CREATE TABLE employees(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    project_id INT,
    CONSTRAINT fk_employees_project_id_projects_id
    FOREIGN KEY (project_id)
    REFERENCES projects(id)
);

ALTER TABLE projects
ADD CONSTRAINT fk_projects_employees
	FOREIGN KEY (project_lead_id)
    REFERENCES employees(id);


    