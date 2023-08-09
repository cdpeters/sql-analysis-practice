-- 222. Working with FOREIGN KEY ---------------------------------
CREATE DATABASE shop;
USE shop;

CREATE TABLE customers (
    PRIMARY KEY (id),
    id         INT          AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    email      VARCHAR(50)
);

CREATE TABLE orders (
    PRIMARY KEY (id),
    id          INT AUTO_INCREMENT,
    order_date  DATE,
    amount      DECIMAL(8, 2),
    customer_id INT,
                FOREIGN KEY (customer_id) REFERENCES customers (id)
                ON DELETE CASCADE
);

DROP TABLE customers;
DROP TABLE orders;

SHOW TABLES;

INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

SELECT *
  FROM customers;

SELECT *
  FROM orders;

DESC orders;

-- this will fail because the id 54 doesn't exist in the customers table
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2022-11-11', 85.99, 54);


-- 224. Cross Joins ----------------------------------------------
-- naive approach (find the customer id using the first query)
SELECT id
  FROM customers
 WHERE last_name = 'George';

-- hard code in the customer id in the next query
SELECT *
  FROM orders
 WHERE customer_id = 1;

-- a better approach
SELECT *
  FROM orders
 WHERE customer_id =
       (SELECT id
          FROM customers
         WHERE last_name = 'George');

-- a cross join (cartesian product of all rows from both tables)
SELECT * FROM customers, orders;


-- 226. Inner Joins ----------------------------------------------
SELECT customers.first_name,
       customers.last_name,
       orders.order_date,
       orders.amount
  FROM customers
       INNER JOIN orders
       ON customers.id = orders.customer_id;


-- 228. Inner Joins With Group By --------------------------------
SELECT customers.first_name,
       customers.last_name,
       SUM(orders.amount) AS total
  FROM customers
       INNER JOIN orders
       ON customers.id = orders.customer_id
 GROUP BY customers.first_name,
          customers.last_name
 ORDER BY total;


-- 230. Left Join ------------------------------------------------
SELECT customers.first_name,
       customers.last_name,
       orders.order_date,
       orders.amount
  FROM customers
       LEFT JOIN orders
       ON customers.id = orders.customer_id;


-- 232. Left Join With Group By ----------------------------------
SELECT customers.first_name,
       customers.last_name,
       IFNULL(SUM(orders.amount), 0) AS amount_spent
  FROM customers
       LEFT JOIN orders
       ON customers.id = orders.customer_id
 GROUP BY customers.first_name,
          customers.last_name
 ORDER BY amount_spent;


-- 236. On Delete Cascade ----------------------------------------
DELETE FROM customers
 WHERE last_name = 'George';

SELECT *
  FROM orders;


-- 238. Joins Exercise -------------------------------------------
CREATE TABLE students (
    PRIMARY KEY (id),
    id         INT         AUTO_INCREMENT,
    first_name VARCHAR(50)
);

CREATE TABLE papers (
    title      VARCHAR(100),
    grade      INT,
    student_id INT,
               FOREIGN KEY (student_id) REFERENCES students (id)
);

INSERT INTO students (first_name)
VALUES ('Caleb'),
       ('Samantha'),
       ('Raj'),
       ('Carlos'),
       ('Lisa');

INSERT INTO papers (student_id, title, grade)
VALUES (1, 'My First Book Report', 60),
       (1, 'My Second Book Report', 75),
       (2, 'Russian Lit Through The Ages', 94),
       (2, 'De Montaigne and The Art of The Essay', 98),
       (4, 'Borges and Magical Realism', 89);

SELECT *
  FROM students;

SELECT *
  FROM papers;

SELECT students.first_name,
       papers.title,
       papers.grade
  FROM students
       INNER JOIN papers
       ON papers.student_id = students.id
 ORDER BY papers.grade DESC;

SELECT students.first_name,
       papers.title,
       papers.grade
  FROM students
       LEFT JOIN papers
       ON papers.student_id = students.id;

SELECT students.first_name,
       IFNULL(papers.title, 'MISSING') AS title,
       IFNULL(papers.grade, 0) AS grade
  FROM students
       LEFT JOIN papers
       ON papers.student_id = students.id;

SELECT students.first_name,
       IFNULL(AVG(papers.grade), 0) AS average
  FROM students
       LEFT JOIN papers
       ON papers.student_id = students.id
 GROUP BY students.first_name
 ORDER BY average DESC;

SELECT students.first_name,
       IFNULL(AVG(papers.grade), 0) AS average,
       CASE
       WHEN IFNULL(AVG(papers.grade), 0) >= 75.0 THEN 'PASSING'
       ELSE 'FAILING'
       END AS passing_status
  FROM students
       LEFT JOIN papers
       ON papers.student_id = students.id
 GROUP BY students.first_name
 ORDER BY average DESC;
