-- 176. Not Equal ----------------------------------------------
USE book_shop;

SELECT title,
       author_lname
  FROM books
 WHERE author_lname != 'Gaiman';
 

-- 178. NOT LIKE -----------------------------------------------
SELECT title
  FROM books
 WHERE title LIKE '% %';

SELECT title
  FROM books
 WHERE title NOT LIKE '% %';

SELECT title,
       author_fname,
       author_lname
  FROM books
 WHERE author_fname LIKE 'da%';

SELECT title,
       author_fname,
       author_lname
  FROM books
 WHERE author_fname NOT LIKE 'da%';

SELECT title
  FROM books
 WHERE title NOT LIKE '%e%';


-- 180. Greater Than -------------------------------------------
SELECT *
  FROM books
 WHERE released_year > 2005;

SELECT 80 > 40;

SELECT 80 > 90;


-- 182. Less Than Or Equal To ----------------------------------
SELECT title,
       released_year
  FROM books
 WHERE released_year < 2000;

SELECT title,
       released_year
  FROM books
 WHERE released_year >= 2010;
 
 SELECT title,
       released_year
  FROM books
 WHERE released_year <= 2010;


-- 184. Logical AND --------------------------------------------
SELECT *
  FROM books
 WHERE author_lname = 'Eggers' 
       AND released_year > 2010;

SELECT *
  FROM books
 WHERE author_lname = 'Eggers' 
       AND released_year > 2010
       AND title LIKE '%novel%';

SELECT title,
       pages
  FROM books
 WHERE CHAR_LENGTH(title) > 30
       AND pages > 500;
       

-- 186. Logical OR ---------------------------------------------
SELECT title,
       author_lname,
       released_year
  FROM books
 WHERE author_lname = 'Eggers' 
       OR released_year > 2010;

SELECT title,
       pages
  FROM books
 WHERE pages < 200
       OR title LIKE '%stories%';


-- 188. Between ------------------------------------------------
-- without using BETWEEN
SELECT title,
       released_year
  FROM books
 WHERE released_year >= 2004
       AND released_year <= 2015;

-- with BETWEEN
SELECT title,
       released_year
  FROM books
 WHERE released_year BETWEEN 2004 AND 2015;

SELECT title,
       pages
  FROM books
 WHERE pages NOT BETWEEN 200 AND 300;
       

-- 190. Comparing Dates ----------------------------------------
SELECT *
  FROM people
 WHERE birthdate < '2005-01-01';

-- a better option
SELECT *
  FROM people
 WHERE YEAR(birthdate) < 2005;

-- another option
SELECT *
  FROM people
 WHERE birthdate < CAST('2005-01-01' AS DATE);
 
 -- not so great
 SELECT *
   FROM people
  WHERE birthtime BETWEEN '4:00:00'
        AND '10:00:00';

-- better
SELECT *
   FROM people
  WHERE birthtime BETWEEN CAST('4:00:00' AS TIME)
        AND CAST('10:00:00' AS TIME);

-- best
SELECT *
   FROM people
  WHERE HOUR(birthtime) BETWEEN 4
        AND 10;


-- 192. The IN Operator ----------------------------------------
USE book_shop;

SELECT title,
       author_lname 
  FROM books
 WHERE author_lname = 'Carver'
       OR author_lname = 'Lahiri'
       OR author_lname = 'Smith';

-- a better way
SELECT title,
       author_lname 
  FROM books
 WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT title,
       author_lname 
  FROM books
 WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');
 
SELECT title,
       released_year
  FROM books
 WHERE released_year >= 2000
       AND released_year NOT IN (
           2000,
           2002,
           2004,
           2006,
           2008,
           2010,
           2012,
           2014,
           2016
        );

-- better way
SELECT title,
       released_year
  FROM books
 WHERE released_year >= 2000
       AND released_year % 2 != 0;
       

-- 194. CASE ---------------------------------------------------
SELECT title,
       released_year,
       CASE
       WHEN released_year >= 2000 THEN 'modern lit'
       ELSE '20th century lit'
       END AS genre
  FROM books;       

SELECT title,
       stock_quantity,
       CASE
       WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
       WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
       WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
       WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
       ELSE '*****'
       END AS stock_rating
  FROM books;

-- a better way
SELECT title,
       stock_quantity,
       CASE
       WHEN stock_quantity <= 40 THEN '*'
       WHEN stock_quantity <= 70 THEN '**'
       WHEN stock_quantity <= 100 THEN '***'
       WHEN stock_quantity <= 140 THEN '****'
       ELSE '*****'
       END AS stock_rating
  FROM books;

       
-- 196. IS NULL ------------------------------------------------
SELECT *
  FROM books
 WHERE author_lname IS NULL;


-- 197. Exercise -----------------------------------------------
SELECT 10 != 10;
-- 0

SELECT 15 > 14 AND 99 - 5 <= 94;
-- 1

SELECT 1 IN (5,3) OR 9 BETWEEN 8 AND 10;
-- 1

SELECT *
  FROM books
 WHERE released_year < 1980;
 
SELECT *
  FROM books
 WHERE author_lname IN ('Eggers', 'Chabon');

SELECT *
  FROM books
 WHERE author_lname = 'Lahiri'
       AND released_year > 2000;

SELECT *
  FROM books
 WHERE pages BETWEEN 100 AND 200;

SELECT *
  FROM books
 WHERE author_lname LIKE 'C%'
       OR author_lname LIKE 'S%';

-- another way
SELECT title, author_lname
  FROM books
 WHERE SUBSTR(author_lname, 1, 1) IN ('C', 'S');

SELECT title,
       author_lname,
       CASE
       WHEN title LIKE '%stories%' THEN 'Short Stories'
       WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
       ELSE 'Novel'
       END AS 'TYPE'
  FROM books;

SELECT author_fname,
       author_lname,
       CASE
       WHEN COUNT(*) = 1 THEN '1 book'
       ELSE CONCAT(COUNT(*), ' books')
       END AS COUNT
  FROM books
 WHERE author_lname IS NOT NULL
 GROUP BY author_fname, author_lname;