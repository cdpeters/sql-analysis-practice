-- 131. Count Basics --------------------------------
SELECT COUNT(*)
  FROM books;

-- counting all present values (non-null) in the author_fname column
SELECT COUNT(author_fname)
  FROM books;

SELECT COUNT(DISTINCT author_fname)
  FROM books;

SELECT COUNT(DISTINCT released_year)
  FROM books;
  
SELECT COUNT(*)
  FROM books
 WHERE title LIKE '%the%';
 

-- 133. GROUP BY -------------------------------------
SELECT author_lname
  FROM books
 GROUP BY author_lname;

SELECT author_lname,
       COUNT(*) AS books_written
  FROM books
 GROUP BY author_lname
 ORDER BY books_written DESC;

SELECT released_year,
       COUNT(*) AS books_written
  FROM books
 GROUP BY released_year
 ORDER BY books_written DESC;


-- 135. MIN and MAX Basics --------------------------------
SELECT MIN(released_year)
  FROM books;

SELECT MAX(pages)
  FROM books;

SELECT MIN(author_lname),
       MAX(author_lname)
  FROM books;


-- 137. Subqueries -----------------------------------------
-- finding the title of the book with the most pages: option 1
SELECT title,
       pages
  FROM books
 ORDER BY pages DESC
 LIMIT 1;
 
 
-- option 2
SELECT *
  FROM books
 WHERE pages = (
           SELECT MAX(pages)
             FROM books
       );

INSERT INTO books (title, pages)
VALUES ('My Life In Words', 634);

SELECT title,
       released_year
  FROM books
 WHERE released_year = (
           SELECT MIN(released_year)
             FROM books
       );


-- 139. Grouping By Multiple Columns -------------------------
SELECT author_fname,
       author_lname,
       COUNT(*)
  FROM books
 GROUP BY author_lname, author_fname;

-- 141. MIN and MAX with GROUP BY ----------------------------
SELECT author_fname,
       author_lname,
       MIN(released_year),
       MAX(released_year)
  FROM books
 GROUP BY author_fname, author_lname;

SELECT author_fname,
       author_lname,
       COUNT(*) AS books_written,
       MIN(released_year) AS earliest_release,
       MAX(released_year) AS latest_release,
       MAX(pages) AS longest_page_count
  FROM books
 GROUP BY author_fname, author_lname;
 
 
-- 143. SUM ----------------------------------------------
SELECT author_lname,
       SUM(pages)
  FROM books
 GROUP BY author_lname, author_fname;
 

-- 145. AVG ----------------------------------------------
SELECT AVG(released_year)
  FROM books;

SELECT released_year,
       COUNT(*) AS count,
       AVG(stock_quantity) AS avg_stock
  FROM books
 GROUP BY released_year;
 
 
-- 148. Agg Functions Exercise --------------------------
-- print the number of books in the database
SELECT COUNT(*) AS books_in_database
  FROM books;

-- print out how many books were released in each year
SELECT released_year,
       COUNT(*) AS count
  FROM books
 GROUP BY released_year;

-- print out the total number of books in stock
SELECT SUM(stock_quantity) AS total_in_stock
  FROM books;

-- find the average released_year for each author
SELECT author_fname,
       author_lname,
       AVG(released_year)
  FROM books
 GROUP BY author_fname, author_lname;

-- find the full name of the author who wrote the longest book
SELECT CONCAT(author_fname, ' ', author_lname) AS full_name,
       pages
  FROM books
 WHERE pages = (
           SELECT MAX(pages)
             FROM books
       );     

-- total number of books and avg pages, both per year. Select released_year,
-- # of books, and avg pages
SELECT released_year AS year,
       COUNT(*) AS '# books',
       AVG(pages) AS 'avg pages'
  FROM books
 GROUP BY released_year
 ORDER BY released_year;