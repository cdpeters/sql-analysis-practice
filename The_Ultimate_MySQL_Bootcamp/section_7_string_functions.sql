-- 90. Loading Our Books Data --------------------------
CREATE DATABASE book_shop;

USE book_shop;

SELECT * FROM books;
DESC books;


-- 92. CONCAT ------------------------------------------
SELECT CONCAT('he', 'll', 'o');

SELECT CONCAT(author_fname, ' ', author_lname) AS author_name
  FROM books;
  
SELECT CONCAT_WS('-', author_fname, author_lname) AS author_name
  FROM books;
  

-- 94. SUBSTRING ---------------------------------------
SELECT SUBSTRING('Hello World', 1, 5);
SELECT SUBSTRING('Hello World', 2, 4);

SELECT SUBSTRING(title, 1, 15)
  FROM books;

SELECT SUBSTRING(author_lname, 1, 1) AS initial,
       author_lname
  FROM books;

-- 96. Combining String Functions ----------------------
USE book_shop;

-- abbreviated title
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS abbrev_title
  FROM books;

-- author's initials  
SELECT CONCAT(
           SUBSTRING(author_fname, 1, 1),
           '.',
           SUBSTRING(author_lname, 1, 1),
           '.'
       ) AS author_intials
  FROM books;


-- 99. REPLACE -----------------------------------------
SELECT REPLACE('Hello World', 'Hell', '%$#@') AS example;

SELECT REPLACE('cheese bread coffee milk', ' ', ' and ') AS example; 

SELECT REPLACE(title, ' ', '-')
  FROM books;
  

-- 101. REVERSE -----------------------------------------
SELECT REVERSE('chicken nuggets');

SELECT REVERSE(author_fname)
  FROM books;

SELECT CONCAT(author_fname, REVERSE(author_fname)) AS palindrome
  FROM books;


-- 103. CHAR_LENGTH -------------------------------------
SELECT CHAR_LENGTH('Hey!');

SELECT CHAR_LENGTH(title) AS char_length,
       title
  FROM books;


-- 105. UPPER & LOWER -----------------------------------
SELECT UPPER(title)
  FROM books;
  
SELECT CONCAT('I LOVE ', UPPER(title), ' !!!')
  FROM books;
  

-- 107. Other String Functions ---------------------------
SELECT INSERT('Hello Bobby', 6, 0, ' There');

SELECT LEFT(author_lname, 1)
  FROM books;

SELECT REPEAT('ha', 4);

SELECT TRIM('    san diego ');


-- 109. String Functions Exercise ------------------------
SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?')) AS exercise_1;

-- exercise 2
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ',  '-');
-- result: 'I-like-cats'

SELECT REPLACE(title, ' ', '->') AS title
  FROM books;

SELECT author_lname AS forwards,
       REVERSE(author_lname) AS backwards
  FROM books;

SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
  FROM books;

SELECT * from books; 
  
SELECT CONCAT(title, ' was released in ', released_year) AS blurb
  FROM books;

SELECT title,
       CHAR_LENGTH(title) AS 'character count'
  FROM books;
  
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title',
       CONCAT(author_lname, ',', author_fname) AS author,
       CONCAT(stock_quantity, ' in stock') AS quantity
  FROM books; 


