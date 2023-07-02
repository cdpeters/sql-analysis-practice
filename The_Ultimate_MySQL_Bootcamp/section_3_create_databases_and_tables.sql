-- 17. Creating Databases ------------------------
CREATE DATABASE pet_shop;
CREATE DATABASE SlimeStore;


-- 19. Dropping and Using Databases --------------
DROP DATABASE slimestore;
SHOW DATABASES;

use pet_shop;
select database();


-- 25. Creating Tables ---------------------------
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);

SELECT * FROM cats;

CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);

SELECT * FROM dogs;


-- 27. How Do We Know It Worked? -----------------
USE pet_shop;
SHOW TABLES;

SHOW COLUMNS FROM cats;
DESC dogs;


-- 29. Dropping Tables ---------------------------
DROP TABLE cats;
SHOW TABLES;

-- 31. Tables Basics Activity --------------------
CREATE TABLE pastries (
    name VARCHAR(50),
    quantity INT
);

SHOW TABLES;

DESC pastries;

DROP TABLE pastries;

SHOW TABLES;






