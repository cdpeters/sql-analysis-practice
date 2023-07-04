-- 200. UNIQUE Constraint ---------------------------------
CREATE DATABASE constraints;
USE constraints;
SELECT database();

CREATE TABLE contacts (
    name  VARCHAR(100) NOT NULL,
    phone VARCHAR(15)  NOT NULL UNIQUE
);

DESC contacts;

INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

SELECT *
  FROM contacts;

-- will produce error because phone is a duplicate
INSERT INTO contacts (name, phone)
VALUES ('timmytimtim', '8781213455');

-- ok because there is no constraint on name being unique
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8784551213');


-- 202. CHECK Constraints ---------------------------------
CREATE TABLE partiers (
    name VARCHAR(50),
    age  INT,
         CHECK (age > 18)
);

INSERT INTO partiers (name, age)
VALUES ('billybob', 20);

-- will fail because of the check constraint on age
INSERT INTO partiers (name, age)
VALUES ('phil', 16);

CREATE TABLE palindromes (
    word VARCHAR(100),
         CHECK(REVERSE(word) = word)
);

INSERT INTO palindromes (word)
VALUES ('racecar');

-- will fail
INSERT INTO palindromes (word)
VALUES ('hat');


-- 204. Named Constraints ---------------------------------
DROP TABLE partiers;

CREATE TABLE partiers (
    name VARCHAR(50),
    age  INT,
         CONSTRAINT age_over_18
         CHECK (age > 18)
);

INSERT INTO partiers (name, age)
VALUES ('Al', 17);

CREATE TABLE users (
    username VARCHAR(20) NOT NULL,
    age      INT,
             CONSTRAINT age_not_negative
             CHECK (age > 0)
);

INSERT INTO users (username, age)
VALUES ('Laura', -3);

DROP TABLE palindromes;

CREATE TABLE palindromes (
    word VARCHAR(100),
         CONSTRAINT is_palindrome
         CHECK(REVERSE(word) = word)
);


-- 206. Multiple Column Constraints ---------------------------------
CREATE TABLE companies (
    supplier_id INT          PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    phone       VARCHAR(15)  NOT NULL UNIQUE,
    address     VARCHAR(255) NOT NULL,
                CONSTRAINT name_address
                UNIQUE (name, address)
);

DESC companies;

INSERT INTO companies (name, phone, address)
VALUES ('blackbird auto', '8781213455', '7777 long st');

INSERT INTO companies (name, phone, address)
VALUES ('luigi\'s pies', '8784551213', '7777 long st');

SELECT *
  FROM companies;

-- this will error because this name address combo already exists in the table
INSERT INTO companies (name, phone, address)
VALUES ('blackbird auto', '1111213455', '7777 long st');

CREATE TABLE houses (
    purchase_price INT NOT NULL,
    sale_price     INT NOT NULL,
                   CONSTRAINT sprice_gt_pprice
                   CHECK (sale_price >= purchase_price)
);

INSERT INTO houses (purchase_price, sale_price)
VALUES (100, 200);

-- will error
INSERT INTO houses (purchase_price, sale_price)
VALUES (300, 250);


-- 208. ALTER TABLE: Adding Columns ---------------------------------
DESC companies;

ALTER TABLE companies
  ADD COLUMN city VARCHAR(15);

SELECT *
  FROM companies;
  
ALTER TABLE companies
  ADD COLUMN employee_count INT NOT NULL;

SELECT *
  FROM companies;

ALTER TABLE companies
  ADD COLUMN salary FLOAT NOT NULL DEFAULT 0.0;
  
SELECT *
  FROM companies;


-- 210. ALTER TABLE: Dropping Columns ---------------------------------
ALTER TABLE companies
 DROP COLUMN phone;

DESC companies;

ALTER TABLE companies
 DROP COLUMN employee_count;

DESC companies;
 

-- 212. ALTER TABLE: Renaming ---------------------------------
-- rename a table
RENAME TABLE companies TO suppliers;

SELECT *
  FROM companies;

SELECT *
  FROM suppliers;

 ALTER TABLE suppliers
RENAME TO companies;

DESC companies;

-- rename a column
 ALTER TABLE companies
RENAME COLUMN name TO company_name;

DESC companies;


-- 214. ALTER TABLE: Modifying Columns ---------------------------------
DESC companies;

 ALTER TABLE companies
MODIFY company_name VARCHAR(100) DEFAULT 'unknown';

DESC companies;

 ALTER TABLE companies
CHANGE city location VARCHAR(100);

DESC companies;


-- 216. ALTER TABLE: Constraints ---------------------------------
DESC houses;

ALTER TABLE houses
  ADD CONSTRAINT positive_price 
      CHECK (purchase_price >= 0);

DESC houses;

-- this will fail
INSERT INTO houses (purchase_price, sale_price)
VALUES (-1, 4);

ALTER TABLE houses
 DROP CONSTRAINT positive_price;

-- this will now not fail
INSERT INTO houses (purchase_price, sale_price)
VALUES (-1, 4);

