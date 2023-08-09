-- section 3. create databases and tables -----------------------

-- DATABASES --------------------------
-- create a database
CREATE DATABASE baseball;

-- select the database to use
USE baseball;

-- show a list of all databases
SHOW DATABASES;

-- show the current database in use
SELECT DATABASE();

-- delete a database
DROP DATABASE baseball;

SHOW DATABASES;


-- TABLES -----------------------------
-- create a table
CREATE TABLE batters (
    PRIMARY KEY (name),
    name    VARCHAR(50),
    average FLOAT
);

-- show a list of all the tables in a database
SHOW TABLES;

-- describe a particular table
DESC batters;
-- or
-- SHOW COLUMNS FROM batters;

-- delete a table
DROP TABLE batters;


-- section 4. inserting data ------------------------------------

-- Inserts
INSERT INTO batters (name, average)
VALUES ('Ken Griffey Jr.', .294),
       ('Tony Gwynn', .339);

SELECT *
  FROM batters;


-- section 5. CRUD basics ---------------------------------------

-- Create (Insert)
INSERT INTO batters (name, average)
VALUES ('Fernando Tatis Jr.', .270);

-- Read
SELECT *
  FROM batters;

SELECT *
  FROM batters
 WHERE average > .280;

-- Update
UPDATE batters
   SET average = .273
 WHERE name = 'Fernando Tatis Jr.';

SELECT *
  FROM batters;

-- Delete
DELETE FROM batters
 WHERE name = 'Ken Griffey Jr.';

SELECT *
  FROM batters;


-- section 7. string functions ----------------------------------

-- concatenation with word separator
SELECT CONCAT_WS(' ', 'Hello,', 'how', 'are', 'you', 'doing?');

-- substring(string, start, length), indexed from 1
SELECT SUBSTRING(name, 1, 7)
  FROM batters;

SELECT SUBSTRING(name, -3, 7)
  FROM batters;

-- replace(string, target_substring, replacement_substring)
SELECT REPLACE(name, ' Jr.', '')
  FROM batters;

-- reverse(string)
SELECT REVERSE(name)
  FROM batters;

-- char_length - length of string, length - length in bytes
SELECT CHAR_LENGTH(name)
  FROM batters;


-- section 8. refining selections -------------------------------
SHOW DATABASES;

USE book_shop;

SELECT *
  FROM books;

-- distinct
SELECT DISTINCT author_fname, author_lname
  FROM books;

-- order by
USE baseball;

SELECT *
  FROM batters
 ORDER BY average;

-- limit
USE book_shop;

SELECT *
  FROM books;

SELECT title,
       pages
  FROM books
 ORDER BY pages DESC
 LIMIT 5;

-- like
USE book_shop;

SELECT author_fname
  FROM books
 WHERE author_fname LIKE '%n';

-- escaping wildcards
SELECT author_fname
  FROM books
 WHERE author_fname LIKE '%\%%';


-- section 9 aggregate functions --------------------------------

-- count
SELECT COUNT(DISTINCT author_fname)
  FROM books;

-- subqueries (find title(s) with min stock quantity for resupply)
SELECT title,
       stock_quantity
  FROM books
 WHERE stock_quantity = (
           SELECT MIN(stock_quantity)
             FROM books
       );

SELECT author_fname,
       author_lname,
       COUNT(*) AS books_written
  FROM books
 GROUP BY author_fname, author_lname
 ORDER BY books_written DESC;


-- section 10. revisiting data types ----------------------------

SELECT NOW();

-- formatting dates
-- the harder way
SELECT birthdate,
       CONCAT(
           MONTHNAME(birthdate),
           ' ',
           DAY(birthdate),
           ', ',
           YEAR(birthdate)
       ) AS birth_date_long
  FROM people;

-- the easier way
SELECT birthdate,
       DATE_FORMAT(birthdate, '%M %e, %Y') AS birth_date_long
  FROM people;

SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i') AS date;

-- date math
SELECT CURDATE(),
       DATE_SUB(CURDATE(), INTERVAL 2 MONTH) AS cur_date_sub_months;

SELECT CURDATE() + INTERVAL 2 MONTH;

SELECT TIMEDIFF(CURTIME(), '06:00:00');


-- section 11. comparison and logical operators -----------------

USE book_shop;

-- between
SELECT title,
       pages
  FROM books
 WHERE pages BETWEEN 300 AND 450
 ORDER BY pages DESC;

SELECT title,
       pages
  FROM books
 WHERE pages NOT BETWEEN 300 AND 450
 ORDER BY pages DESC;

-- case
SELECT title,
       released_year,
       CASE
       WHEN released_year >= 2000 THEN 'modern lit'
       ELSE '20th century lit'
       END AS genre
  FROM books;

SELECT author_fname,
       author_lname,
       CASE
       WHEN COUNT(*) = 1 THEN '1 book'
       ELSE CONCAT(COUNT(*), ' books')
       END AS count
  FROM books
 WHERE author_lname IS NOT NULL
 GROUP BY author_fname, author_lname;


-- section 13. one to many and joins ----------------------------

USE shop;

-- inner join
SELECT *
  FROM customers
       INNER JOIN orders
       ON customers.id = orders.customer_id;

SELECT *
  FROM customers
       LEFT JOIN orders
       ON customers.id = orders.customer_id;


-- section 14. many to many
