-- 35. INSERT: The Basics ------------------------
USE pet_shop;
SHOW TABLES;

INSERT INTO cats (name, age)
VALUES ('Jetson', 7);

INSERT INTO cats (name, age)
VALUES ('Blue', 5);

INSERT INTO cats (name, age)
VALUES ('Jenkins', 7);


-- 37. A Quick Preview of SELECT -------------------
SELECT * FROM cats;


-- 39. Multi-inserts -------------------------------
INSERT INTO cats (name, age)
VALUES ('Meatball', 5),
       ('Turkey', 1),
       ('Potato Face', 15);
       
SELECT * FROM cats;


-- 41. INSERT Exercise -----------------------------
CREATE TABLE people (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);

INSERT INTO people (first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13);

INSERT INTO people (first_name, last_name, age)
VALUES ('Bob', 'Belcher', 42);

INSERT INTO people (first_name, last_name, age)
VALUES ('Linda', 'Belcher', 45),
       ('Phillip', 'Frond', 38),
       ('Calvin', 'Fischoeder', 70);

SELECT * FROM people;

DROP TABLE people;

SHOW TABLES;


-- 43. Working With NOT NULL ------------------------
CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- generates an error
INSERT INTO cats2 (name) VALUES ('Bilbo');

-- 46. Adding DEFAULT Values -------------------------
USE pet_shop;
SHOW TABLES;

CREATE TABLE cats3 (
    name VARCHAR(100) DEFAULT 'unnamed',
    age INT DEFAULT 99
);

DESC cats3;

INSERT INTO cats3(age)
VALUES (2);

SELECT * FROM cats3;

CREATE TABLE cats4 (
    name VARCHAR(100) NOT NULL DEFAULT 'unnamed',
    age INT DEFAULT 99
);

INSERT INTO cats3(name, age) VALUES (NULL, NULL);

SELECT * FROM cats3;

-- This will fail because the name column is a NOT NULL column
INSERT INTO cats4(name, age) VALUES (NULL, NULL);

INSERT INTO cats4() VALUES ();

SELECT * FROM cats4;


-- 48. Introducing Primary Keys -------------------------
CREATE TABLE unique_cats (
    cat_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

DESC unique_cats;


-- 50. Working With AUTO_INCREMENT -----------------------
DROP TABLE unique_cats;

CREATE TABLE unique_cats (
    cat_id INT,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
);

DESC unique_cats;

-- AUTO_INCREMENT
CREATE TABLE unique_cats2 (
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
);

DESC unique_cats2;

INSERT INTO unique_cats2(name, age)
VALUES ('Boingo', 3),
       ('Frank', 9),
       ('Bubs', 1); 
       
SELECT * FROM unique_cats2;




-- 52. Create Table/Insert Exercise
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    age INT NOT NULL,
    current_status VARCHAR(50) NOT NULL DEFAULT 'employed'
);

DESC employees;

INSERT INTO employees (first_name, last_name, age)
VALUES ('Thomas', 'Chickenman', 78);

SELECT * FROM employees;