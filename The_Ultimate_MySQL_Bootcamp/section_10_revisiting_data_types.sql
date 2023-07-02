-- 153. CHAR vs. VARCHAR --------------------------------
USE book_shop;

CREATE TABLE friends (
    name VARCHAR(10)
);

INSERT INTO friends (name)
VALUES ('tom'),
       ('juan pablo'),
       ('james');

SELECT * FROM friends;

CREATE TABLE states (
    abbr CHAR(2)
);

INSERT INTO states (abbr)
VALUES ('CA'),
       ('NY');

SELECT * FROM states;


-- 156. FLOAT & DOUBLE -------------------------------------
USE book_shop;

CREATE TABLE numbers (
    x FLOAT,
    y DOUBLE
);

INSERT INTO numbers (x, y)
VALUES (1.23, 1.23),
       (1.23456789, 1.23456789);

-- notice the rounding for the variable of type FLOAT
SELECT * FROM numbers;


-- 158. Working with Dates ---------------------------------
CREATE TABLE people (
    name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);

DESC people;

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10'),
       ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT * FROM people;


-- 160. CURDATE, CURTIME, & NOW ----------------------------
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

SELECT * FROM people;


-- 162. Date Functions --------------------------------------
SELECT birthdate FROM people;

SELECT birthdate,
       DAY(birthdate)
  FROM people;

SELECT name,
       birthdate,
       DAY(birthdate),
       DAYOFWEEK(birthdate)
  FROM people;

SELECT birthdate,
       DAYOFYEAR(birthdate) AS day_of_year
  FROM people;

SELECT birthdate,
       MONTHNAME(birthdate)
  FROM people;

-- this produces incorrect results for what we are expecting. This is because
-- the birthtime does not contain any date information (so SQL defaults to the
-- current month when it has no date information)
SELECT birthtime,
       MONTHNAME(birthtime)
  FROM people;


-- 164 Time Functions ---------------------------------
SELECT name,
       birthtime,
       HOUR(birthtime)
  FROM people;

SELECT name,
       birthtime,
       HOUR(birthtime),
       MINUTE(birthtime),
       SECOND(birthtime)
  FROM people;

SELECT name,
       birthdt,
       DATE(birthdt),
       TIME(birthdt)
  FROM people;


-- 166. Formatting Dates -----------------------------
-- one way of formatting a date with what we already know (CONCAT)
SELECT birthdate,
       CONCAT(
           MONTHNAME(birthdate),
           ' ',
           DAY(birthdate),
           ', ',
           YEAR(birthdate)
       ) AS birth_date_long
  FROM people;

SELECT birthdate,
       DATE_FORMAT(birthdate, '%M %e, %Y') AS birth_date_long
  FROM people;
  
SELECT birthdt,
       DATE_FORMAT(birthdt, '%r') birth_time
  FROM people;


-- 168. Date Math ------------------------------------
SELECT birthdate,
       DATEDIFF(CURDATE(), birthdate) AS difference
  FROM people;

SELECT CURDATE(), 
       DATE_ADD(CURDATE(), INTERVAL 1 YEAR) AS cur_date_add_year;

SELECT CURDATE(), 
       DATE_SUB(CURDATE(), INTERVAL 2 MONTH) AS cur_date_sub_months;

SELECT birthdate,
       DATE_ADD(birthdate, INTERVAL 18 YEAR) AS age_18
  FROM people;
  
SELECT TIMEDIFF(CURTIME(), '06:00:00');

SELECT name,
       birthdate,
       YEAR(birthdate + INTERVAL 21 YEAR) AS age_21
  FROM people;


-- 170. DEFAULT & ON UPDATE TIMESTAMPS ---------------------------
CREATE TABLE captions (
    text VARCHAR(150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP
);

INSERT INTO captions (text)
VALUES ('best day ever');

INSERT INTO captions (text)
VALUES ('beautiful sunset');

SELECT * FROM captions;

CREATE TABLE captions2 (
    text VARCHAR(150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions2 (text)
VALUES ('beautiful sunset');

SELECT * FROM captions2;

UPDATE captions2 SET text = 'beautiful sunset (nevermind, cloudy)';

SELECT * FROM captions2;


-- 172. Data Types Exercise ------------------------------------
-- what is good use case for CHAR?
    -- football positions CHAR(2)

-- item_name is text, price is always less than 1E6 and only ever have 2 decimals,
-- quantity is a whole number
CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8, 2),
    quantity SMALLINT UNSIGNED
);

-- what is the difference between DATETIME and TIMESTAMP?
    -- DATETIME is larger in memory and covers a greater range than TIMESTAMP

SELECT CURTIME();

SELECT CURDATE();

SELECT DAYOFWEEK(CURDATE()) AS day_of_week;

SELECT DAYNAME(CURDATE()) AS day_name;

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') AS date;

SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i') AS date;

CREATE TABLE tweets (
    tweet VARCHAR(180),
    username VARCHAR(100),
    created_at TIMESTAMP default CURRENT_TIMESTAMP
);
DESC tweets;