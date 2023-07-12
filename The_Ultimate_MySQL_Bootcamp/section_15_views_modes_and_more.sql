-- 260. Introducing Views --------------------------------------
USE tv_db;

-- here is a possible "jumping off" point for other future queries
SELECT series.title,
       series.released_year,
       series.genre,
       reviews.rating,
       reviewers.first_name,
       reviewers.last_name
  FROM series
       INNER JOIN reviews
       ON series.id = reviews.series_id
       INNER JOIN reviewers
       ON reviews.reviewer_id = reviewers.id;

CREATE VIEW full_reviews AS
SELECT series.title,
       series.released_year,
       series.genre,
       reviews.rating,
       reviewers.first_name,
       reviewers.last_name
  FROM series
       INNER JOIN reviews
       ON series.id = reviews.series_id
       INNER JOIN reviewers
       ON reviews.reviewer_id = reviewers.id;

SELECT *
  FROM full_reviews;
       
SELECT *
  FROM full_reviews
 WHERE genre = 'Animation';

SELECT genre,
       AVG(rating) AS avg_rating
  FROM full_reviews
 GROUP BY genre; 


-- 262. Updateable Views --------------------------------------
-- this fails because full_reviews is not an actual table and it contains joins
DELETE FROM full_reviews WHERE released_year = 2010;


-- 263. Replacing/Altering Views --------------------------------------
CREATE VIEW ordered_series AS
SELECT *
  FROM series
 ORDER BY released_year;

SELECT *
  FROM ordered_series;

-- replace a view
CREATE OR REPLACE VIEW ordered_series AS
SELECT *
  FROM series
 ORDER BY released_year DESC;
 
 SELECT *
  FROM ordered_series;

-- alter a view
ALTER VIEW ordered_series AS
SELECT *
  FROM series
 ORDER BY released_year;

SELECT *
  FROM ordered_series;

-- drop a view
DROP VIEW ordered_series;

-- will fail
SELECT *
  FROM ordered_series;


-- 265. HAVING clause --------------------------------------
SELECT *
  FROM full_reviews;

SELECT title,
       AVG(rating) AS avg_rating,
       COUNT(rating) AS review_count
  FROM full_reviews
 GROUP BY title
HAVING COUNT(rating) > 3;


-- 267. WITH ROLLUP --------------------------------------
SELECT *
  FROM full_reviews;

SELECT AVG(rating) AS avg_rating
  FROM full_reviews;

SELECT title,
       AVG(rating) AS avg_rating
  FROM full_reviews
 GROUP BY title;

SELECT title,
       AVG(rating) AS avg_rating
  FROM full_reviews
 GROUP BY title WITH ROLLUP;

SELECT title,
       COUNT(rating) AS review_count
  FROM full_reviews
 GROUP BY title WITH ROLLUP;

-- another example
SELECT released_year,
       AVG(rating)
  FROM full_reviews
 GROUP BY released_year WITH ROLLUP;

SELECT released_year,
       genre,
       AVG(rating)
  FROM full_reviews
 GROUP BY released_year, genre
 ORDER BY released_year;
 
SELECT released_year,
       genre,
       AVG(rating)
  FROM full_reviews
 GROUP BY released_year, genre WITH ROLLUP
 ORDER BY released_year;


-- 269. SQL Modes Basics --------------------------------------
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;

SHOW WARNINGS;


-- 272. More Modes --------------------------------------
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

SELECT @@GLOBAL.sql_mode;

