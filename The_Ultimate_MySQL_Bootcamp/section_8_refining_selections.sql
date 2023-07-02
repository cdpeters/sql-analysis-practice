-- 113. Adding Some New Books -------------------------
INSERT INTO books (title,
                   author_fname,
                   author_lname,
                   released_year,
                   stock_quantity,
                   pages)
VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
       ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
       ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
       
SELECT * FROM books;


-- 115. DISTINCT --------------------------------------
SELECT DISTINCT author_lname
  FROM books;
  
SELECT DISTINCT released_year
  FROM books;
  
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) AS distinct_authors
  FROM books;
  
-- another way to do the query above without CONCAT
SELECT DISTINCT author_fname, author_lname
  FROM books;


-- 117. ORDER BY -------------------------------------
SELECT book_id, 
       title,
       author_lname
  FROM books;

SELECT book_id, author_fname, author_lname
  FROM books
 ORDER BY author_lname;
 
SELECT book_id, author_fname, author_lname
  FROM books
 ORDER BY author_fname DESC;
 

-- 119. More On ORDER BY ------------------------------
USE book_shop;

SELECT title,
       book_id
  FROM books
 ORDER BY 2 DESC;

SELECT author_lname,
       released_year,
       title
  FROM books
 ORDER BY author_lname DESC, released_year DESC;

SELECT CONCAT(author_fname, ' ',author_lname) AS author
  FROM books
 ORDER BY author;
 

-- 121. LIMIT -----------------------------------------
SELECT book_id,
       title,
       released_year
  FROM books
 ORDER BY released_year
 LIMIT 5;
 
 SELECT book_id,
       title,
       released_year
  FROM books
 ORDER BY released_year
 LIMIT 2, 3;


-- 123. LIKE ----------------------------------------
SELECT title,
       author_fname,
       author_lname
  FROM books
 WHERE author_fname LIKE '%da%';
 
SELECT title
  FROM books
 WHERE title LIKE '%:%';
 
-- 4 character author names
SELECT author_fname
  FROM books
 WHERE author_fname LIKE '____';

SELECT author_fname
  FROM books
 WHERE author_fname LIKE '_a_';
 
SELECT author_fname
  FROM books
 WHERE author_fname LIKE '%n';


-- 125. Escaping Wildcards -----------------------------
SELECT title
  FROM books
 WHERE title LIKE '%\%%';


-- 127. Refining Selections Exercise -------------------
-- titles that contain 'stories'
SELECT title
  FROM books
 WHERE title LIKE '%stories%';

-- for the longest book, print out the title and page count
SELECT title,
       pages
  FROM books
 ORDER BY pages DESC LIMIT 1;

-- print summary as '<title> - <released_year>' containing title and year
-- for 3 most recent books
SELECT CONCAT(title, ' - ', released_year) AS summary
  FROM books
 ORDER BY released_year DESC LIMIT 3;

-- find all books with an author_lname that contains a space
SELECT title,
       author_lname
  FROM books
 WHERE author_lname like '% %';
 
-- find the 3 books with the lowest stock
-- select title, year and stock
SELECT title,
       released_year,
       stock_quantity
  FROM books
 ORDER BY stock_quantity, released_year DESC LIMIT 3;
 
-- print title and author_lname, sorted first by author_lname
-- and then by title
SELECT title,
       author_lname
  FROM books
 ORDER BY author_lname, title;

-- sort by last name
SELECT CONCAT(
           'MY FAVORITE AUTHOR IS ',
           UPPER(author_fname),
           ' ',
           UPPER(author_lname),
           '!'
       ) AS yell
  FROM books
 ORDER BY author_lname;






