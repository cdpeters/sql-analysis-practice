-- 275. Using OVER() --------------------------------------
USE shop;

CREATE TABLE employees (
    PRIMARY KEY (emp_no),
    emp_no     INT          AUTO_INCREMENT,
    department VARCHAR(20),
    salary     INT
);
 
INSERT INTO employees (department, salary)
VALUES ('engineering', 80000),
       ('engineering', 69000),
       ('engineering', 70000),
       ('engineering', 103000),
       ('engineering', 67000),
       ('engineering', 89000),
       ('engineering', 91000),
       ('sales', 59000),
       ('sales', 70000),
       ('sales', 159000),
       ('sales', 72000),
       ('sales', 60000),
       ('sales', 61000),
       ('sales', 61000),
       ('customer service', 38000),
       ('customer service', 45000),
       ('customer service', 61000),
       ('customer service', 40000),
       ('customer service', 31000),
       ('customer service', 56000),
       ('customer service', 55000);

SELECT *
  FROM employees;

SELECT department,
       AVG(salary)
  FROM employees
 GROUP BY department;
 
 SELECT AVG(salary)
   FROM employees;

SELECT department,
       AVG(salary) OVER()
  FROM employees;

SELECT emp_no,
       department,
       salary,
       AVG(salary) OVER() AS avg_salary
  FROM employees;


-- 277. PARTITION BY --------------------------------------
SELECT emp_no,
       department,
       salary,
       AVG(salary) OVER(PARTITION BY department) AS dept_avg_salary,
       AVG(salary) OVER() AS company_avg_salary
  FROM employees;

SELECT emp_no,
       department,
       salary,
       COUNT(*) OVER(PARTITION BY department) AS dept_count
  FROM employees;

SELECT emp_no,
       department,
       salary,
       SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
       SUM(salary) OVER() AS total_payroll
  FROM employees;


-- 279. ORDER BY with Windows --------------------------------------
SELECT emp_no,
       department,
       salary,
       SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_dept_salary,
       SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
  FROM employees;

SELECT emp_no,
       department,
       salary,
       MIN(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_min
  FROM employees;


-- 281. RANK() --------------------------------------
SELECT emp_no,
       department,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS overal_salary_rank
  FROM employees;

SELECT emp_no,
       department,
       salary,
       RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
       RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank
  FROM employees
 ORDER BY department;


-- 282. DENSE_RANK & ROW_NUMBER() --------------------------------------
SELECT emp_no,
       department,
       salary,
       ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_row,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS overall_salary_row
  FROM employees;
  
SELECT emp_no,
       department,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS overall_rank,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS overall_dense_rank
  FROM employees;


-- 284. NTILE() --------------------------------------
SELECT emp_no,
       department,
       salary,
       NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
       NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
  FROM employees;


-- 286. FIRST_VALUE --------------------------------------
SELECT emp_no,
       department,
       salary,
       FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC)
  FROM employees;

SELECT emp_no,
       department,
       salary,
       FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS highest_paid_dept,
       FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS highest_paid_overall
  FROM employees;
  


-- 288. LEAD and LAG --------------------------------------
SELECT emp_no,
       department,
       salary,
       LAG(salary) OVER(ORDER BY salary DESC)
  FROM employees;

SELECT emp_no,
       department,
       salary,
       salary - LAG(salary) OVER(ORDER BY salary DESC) AS salary_diff
  FROM employees;

SELECT emp_no,
       department,
       salary,
       salary - LEAD(salary) OVER(ORDER BY salary DESC) AS salary_diff
  FROM employees;

SELECT emp_no,
       department,
       salary,
       salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff
  FROM employees;

