SELECT * FROM books;

SELECT 5 + 5;

SELECT SUBSTRING('Some Text', 3);
SELECT SUBSTRING('Some Text', 3, 4);

SELECT SUBSTRING(title, 1, 20)
FROM books;

SELECT SUBSTRING(title, author_id, 20)
FROM books;

-- Produces error, missing second argument
-- SELECT SUBSTRING('Something'); 

SELECT title, SUBSTRING(title, 1, 3)
FROM books;

SELECT title
FROM books
WHERE SUBSTRING(title, 1, 3) = 'The'
ORDER BY id ASC;

SELECT REPLACE('Some text', 'Some', 'Other');
SELECT REPLACE('Some text', 'some', 'Other');

SELECT REPLACE('Blood blood something else', 'Blood', '*****');
SELECT REPLACE('Blood blood something else', 'blood', '*****');

SELECT 
	REPLACE(
		REPLACE('Blood blood something else', 'Blood', '*****'), -- ***** blood something else
        'blood', 
        '*****'
	);
    
SELECT REPLACE('some text some more', 'some', 'xxxx');
    
SELECT CONCAT('***', SUBSTRING(title, 4))
FROM books
WHERE 'The' = SUBSTRING(title, 1, 3)
ORDER BY id ASC;

SELECT '      2 spaces', LTRIM('      2 spaces');
SELECT '2 spaces      ', RTRIM('2 spaces      ');
SELECT LTRIM(RTRIM('   spaces    '));

SELECT CHAR_LENGTH('some'), LENGTH('some');
SELECT CHAR_LENGTH('соме'), LENGTH('соме');

SELECT id, CHAR_LENGTH(first_name), LENGTH(first_name)
FROM authors;

SELECT id, first_name
FROM authors;

UPDATE authors
SET first_name = 'Лъв'
WHERE id = 5;

SELECT LEFT('some text', 3), SUBSTRING('some text', 1, 3);
SELECT 
	RIGHT('some text', 2), 
    SUBSTRING('some text', -2), 
    SUBSTRING('some text', 8);

SELECT LEFT('אה', 1);

SELECT LOWER('SoMe'), UPPER('SoMe');

SELECT REVERSE('Some');
SELECT REPEAT('Some', 4);

SELECT LOCATE('Text', 'some text');
SELECT INSERT('some text', 2, 0, 'add'); -- insert
SELECT INSERT('some text', 2, 6, 'add'); -- replace

-- 'The title to The replaced'

SELECT INSERT(
	'The title to The replaced', 
	LOCATE('The', 'The title to The replaced'), 
    3, 
    '***'
); 

SELECT 
	INSERT(
		title, 
		LOCATE('The', title), 
		3, 
		'***'
	) 
FROM books;

SELECT 11 / 3, 11 DIV 3, 11 MOD 3;
SELECT -(11 / 5); 

SELECT PI();
SELECT PI() + 0.00000000;

SELECT ABS(5), ABS(-5);
SELECT SQRT(2);
SELECT POW(2, 5);

SELECT ROUND(POW(2, 5.4), 4);

SELECT ROUND(2.234, 1), FLOOR(2.234), CEILING(2.234);
SELECT ROUND(-2.234, 1), FLOOR(-2.234), CEILING(-2.234);

SELECT CONV(13, 10, 2);
SELECT CONV(1101, 2, 10);
SELECT CONV(13, 10, 16);
SELECT CONV('D', 16, 10);
SELECT CONV(232, 10, 16);
SELECT CONV(232, 10, 2);

SELECT SIGN(-4), SIGN(4);

SELECT RAND(); -- [0; 1) -> [5; 16)
			   -- * 11 [0; 11)
               -- + 5 [5; 16)
               -- FLOOR [5; 15]
SELECT FLOOR(5 + RAND() * 11);


SELECT EXTRACT(DAY_SECOND FROM '2025-05-20 11:45:24');

SELECT TIMESTAMPDIFF(MONTH, '2022-05-20', '2025-05-18');

SELECT
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
	TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

SELECT
    CONCAT_WS(' ', first_name, middle_name, last_name) AS 'Full Name',
	TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

SELECT DATE_FORMAT('2025-05-20 11:45:24', '%D of %b %Y');

SELECT NOW();

SELECT * FROM books;

SELECT * FROM books WHERE title LIKE '%night%';
SELECT * FROM books WHERE title LIKE 'the%';

SELECT title
FROM books 
WHERE title LIKE 'Harry Potter%'
ORDER BY id ASC;

SELECT * 
FROM books;

SELECT ROUND(SUM(cost), 2)
FROM books;