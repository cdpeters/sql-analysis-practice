-- 56. Getting Our New "Dataset" ---------------------
USE pet_shop;
DROP TABLE cats;

CREATE TABLE cats (
 PRIMARY KEY (cat_id),
 cat_id INT           AUTO_INCREMENT,
 name   VARCHAR(100),
 breed  VARCHAR(100),
 age    INT
);

INSERT INTO cats (name, breed, age)
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

SELECT *
  FROM cats;


-- 58. Officially INTroducing SELECT -------------------
SELECT name
  FROM cats;

SELECT age
  FROM cats;

SELECT name,
       breed
  FROM cats;


-- 60. The WHERE ClaUSE --------------------------------
SELECT *
  FROM cats
 WHERE age=4;

SELECT name,
       age
  FROM cats
 WHERE age=4;

SELECT name,
       age
  FROM cats
 WHERE name = 'Egg';


-- 62. Rapid Fire Exercises ------------------------------
SELECT cat_id
  FROM cats;

SELECT name,
       breed
  FROM cats;

SELECT name,
       age
  FROM cats
 WHERE breed = 'Tabby';

SELECT cat_id,
       age
  FROM cats
 WHERE cat_id = age;


-- 65. Aliases -------------------------------------
SELECT cat_id AS id,
       name
  FROM cats;


-- 67. Using UPDATE --------------------------------
-- This updates last_name for every record in the table.
-- Here safe mode prevents this.
UPDATE employees
   SET last_name = 'Rooster';

UPDATE cats
   SET age = 14
 WHERE name = 'Misty';

UPDATE cats
   SET breed = 'Shorthair'
 WHERE breed = 'Tabby';

SELECT *
  FROM cats;


-- 70. UPDATE Exercise ----------------------------
UPDATE cats
   SET name = 'Jack'
 WHERE name = 'Jackson';

UPDATE cats
   SET breed = 'British Shorthair'
 WHERE name = 'Ringo';

UPDATE cats
   SET age = 12
 WHERE breed = 'Maine Coon';

SELECT *
  FROM cats;


-- 73. Introducing DELETE ------------------------
DELETE FROM cats
 WHERE name = 'Egg';

SELECT *
  FROM cats;

SELECT *
  FROM employees;

DELETE FROM employees;

SELECT *
  FROM employees;


-- 75. DELETE Exercise ----------------------------
DELETE FROM cats
 WHERE age = 4;

SELECT *
  FROM cats;

DELETE FROM cats
 WHERE cat_id = age;

SELECT *
  FROM cats;

DELETE FROM cats;

SELECT *
  FROM cats;
