CREATE DATABASE gamebar;

USE gamebar;
CREATE TABLE `employees` (
	`id` INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE `categories` (
	id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE `products` (
	`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL
);
    
create table something (
	id int auto_increment not null primary key
);

INSERT INTO employees
	(first_name, last_name)
VALUES 
	('Pesho', 'Last1'),
	('Gosho', 'Last2'),
    ('Penka', 'Last3');
    
SELECT * FROM employees;

ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(50);

ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);

ALTER TABLE `products`
ADD CONSTRAINT `fk_category_id_categories_id`
	FOREIGN KEY (`category_id`)
	REFERENCES `categories`(`id`);
    
-- produces error
ALTER TABLE `categories`
ADD CONSTRAINT `fk_id_producsts_category_id`
	FOREIGN KEY (`id`)
    REFERENCES `products`(`category_id`);

