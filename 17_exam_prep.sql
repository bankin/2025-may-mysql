CREATE DATABASE summer_olympics;
USE summer_olympics;

CREATE TABLE countries (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE sports(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE disciplines(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE,
    sport_id INT NOT NULL,
    CONSTRAINT fk_disciplines_sports
		FOREIGN KEY (sport_id) REFERENCES sports(id) 
);

CREATE TABLE athletes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    age INT NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT fk_athletes_countries
		FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE `medals`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `type` VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE disciplines_athletes_medals(
	discipline_id INT NOT NULL,
    athlete_id INT NOT NULL,
    medal_id INT NOT NULL,
	CONSTRAINT pk_discipline_athlete
		PRIMARY KEY (discipline_id, athlete_id),
    CONSTRAINT fk_disciplines_athletes_medals_disciplines 
		FOREIGN KEY (discipline_id) REFERENCES disciplines(id),
	CONSTRAINT fk_disciplines_athletes_medals_athletes
		FOREIGN KEY (athlete_id) REFERENCES athletes(id),
	CONSTRAINT fk_disciplines_athletes_medals_medals
		FOREIGN KEY (medal_id) REFERENCES medals(id),
	CONSTRAINT uq_discipline_medal
		UNIQUE (discipline_id, medal_id)
);

SELECT 
	UPPER(a.first_name),
    CONCAT(a.last_name, ' comes from ', c.name),
    a.age + a.country_id,
    c.id
FROM athletes a
JOIN countries c ON a.country_id = c.id
WHERE c.name LIKE 'a%';

SELECT COUNT(*) FROM athletes;

INSERT INTO athletes (first_name, last_name, age, country_id)
SELECT 
	UPPER(a.first_name),
    CONCAT(a.last_name, ' comes from ', c.name),
    a.age + a.country_id,
    c.id
FROM athletes a
JOIN countries c ON a.country_id = c.id
WHERE c.name LIKE 'a%';

SELECT * FROM athletes;

SELECT id, name, REPLACE(name, 'weight', '')
FROM disciplines
WHERE name LIKE '%weight%';

UPDATE disciplines
SET name = REPLACE(name, 'weight', '')
WHERE name LIKE '%weight%';

SELECT *
FROM athletes
WHERE age > 35;

DELETE FROM athletes 
WHERE age > 35;

SELECT *
FROM disciplines_athletes_medals
WHERE athlete_id IN (29, 43);

SELECT c.id, c.name
FROM countries c
LEFT JOIN athletes a ON a.country_id = c.id
WHERE a.id IS NULL
ORDER BY name DESC
LIMIT 15;

SELECT MIN(age) FROM athletes;

SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS 'full_name',
    a.age
FROM athletes a
JOIN disciplines_athletes_medals dam ON dam.athlete_id = a.id
ORDER BY age, id
LIMIT 2;

SELECT a.id, a.first_name, a.last_name
FROM athletes a
LEFT JOIN disciplines_athletes_medals dam ON dam.athlete_id = a.id
WHERE dam.athlete_id IS NULL
ORDER BY id;

SELECT 
	a.id, 
    a.first_name, 
    a.last_name, 
    COUNT(a.id) AS 'medals_count', 
    s.name AS 'sport'
FROM athletes a
JOIN disciplines_athletes_medals dam ON dam.athlete_id = a.id
JOIN disciplines d ON dam.discipline_id = d.id
JOIN sports s ON d.sport_id = s.id
GROUP BY a.id, s.name
ORDER BY `medals_count` DESC, a.first_name ASC
LIMIT 10;

SELECT 
	CONCAT(first_name, ' ', last_name) AS 'full_name',
    CASE
		WHEN age <= 18 THEN 'Teenager'
        WHEN age > 18 AND age <= 25 THEN 'Young adult'
        ELSE 'Adult'
	END AS 'age_group'
FROM athletes
ORDER BY age DESC, first_name;

SELECT COUNT(dam.medal_id)
FROM countries c
JOIN athletes a ON a.country_id = c.id
JOIN disciplines_athletes_medals dam ON dam.athlete_id = a.id
WHERE c.name = 'Bahamas';

DELIMITER $$

CREATE FUNCTION udf_total_medals_count_by_country(country_name VARCHAR(40))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	RETURN (SELECT COUNT(dam.medal_id)
		FROM countries c
		JOIN athletes a ON a.country_id = c.id
		JOIN disciplines_athletes_medals dam ON dam.athlete_id = a.id
		WHERE c.name = country_name
	);
END$$

DELIMITER ;

SELECT c.name, udf_total_medals_count_by_country (name) as count_of_medals
FROM countries c;

SELECT id, first_name, UPPER(first_name)
FROM athletes
WHERE SUBSTRING(first_name, -1) = 'a';

UPDATE athletes
SET first_name = UPPER(first_name)
WHERE SUBSTRING(first_name, -1) = 's';

DROP PROCEDURE udp_first_name_to_upper_case;
DELIMITER $$

CREATE PROCEDURE udp_first_name_to_upper_case(letter CHAR(1))
MODIFIES SQL DATA
BEGIN
	UPDATE athletes
	SET first_name = UPPER(first_name)
	WHERE SUBSTRING(first_name, -1) = letter;
END$$

DELIMITER ;

CALL udp_first_name_to_upper_case ('a');
