CREATE DATABASE ASSIGNMENT;
USE ASSIGNMENT;

-- Assignment 1

CREATE TABLE Emp
(
	Act_No INT PRIMARY KEY,
    name VARCHAR(30),
    DOB DATE,
    Phone_no BIGINT
);

DESC Emp;

INSERT INTO Emp(Act_NO, name, DOB, Phone_no) VALUES
(1, 'Suyog Magar', '2001-01-14', 9771723849),
(2, 'Bedraj Khadka', '2000-03-23', 982482404),
(3, 'Prayas Baral', '2001-02-02', 9712394736);

SELECT * FROM Emp;

-- Assignment 2

CREATE TABLE dept(
dept_no INT PRIMARY KEY,
dname VARCHAR(30),
loc VARCHAR(30)
);

DESC dept;

ALTER TABLE dept RENAME TO department;
DESC department;

ALTER TABLE department RENAME COLUMN dname TO dept_name;
DESC department;

ALTER TABLE department MODIFY loc CHAR(10);
DESC department;

DROP TABLE department;
DESC department;

-- Assignment 3

CREATE DATABASE company;
use company;

SHOW DATABASES;

SHOW TABLES;

CREATE TABLE company(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(200),
gender CHAR(1)
);

DESC company;

CREATE TABLE dept(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100)
);

DESC dept;

CREATE TABLE pay(
emp_id INT,
dept_id INT,
salary INT,
PRIMARY KEY(emp_id, dept_id),
FOREIGN KEY(emp_id) REFERENCES company(emp_id),
FOREIGN KEY(dept_id) REFERENCES dept(dept_id)
);

DESC pay;

INSERT INTO company VALUES
(1,'John Doe','M'),
(2,'Jane Smith','F');

INSERT INTO dept VALUES 
(1,'HR'),
(2,'Finace');

INSERT INTO pay VALUES
(1,1,5000),
(2,2,6000);

SELECT * FROM company,dept,pay;

UPDATE company SET emp_name = 'Suyog RM' WHERE emp_id = 1;
COMMIT;
SELECT * FROM company;

ROLLBACK;

SELECT * FROM company,dept,pay;

UPDATE company SET emp_name = 'Hari' WHERE emp_id = 2;
SELECT * FROM company,dept,pay;
ROLLBACK;

-- Assignment 4 --

CREATE TABLE employee(
    fname VARCHAR(50), 
    minit CHAR(1),
    lname VARCHAR(50), 
    ssn CHAR(9) PRIMARY KEY,
    bdate DATE, 
    address VARCHAR(100),
    sex CHAR(1), 
    salary DECIMAL(10,2),
    superssn CHAR(9), 
    dno INT
);

DESC employee;

CREATE TABLE department(
    dname VARCHAR(50),
    dnumber INT PRIMARY KEY,
    mgrssn CHAR(9),
    msrStartDate DATE
);

DESC department;

CREATE TABLE dept_location(
    dnumber INT,
    dlocation VARCHAR(100),
    PRIMARY KEY (dnumber, dlocation)
);

DESC dept_location;

CREATE TABLE project (
    pname VARCHAR(50),
    pnumber INT PRIMARY KEY,
    plocation VARCHAR(100),
    dnum INT
);

DESC project;

CREATE TABLE works_on(
    essn CHAR(9),
    pno INT,
    hours DECIMAL(5,2),
    PRIMARY KEY(essn, pno)
);

DESC works_on;

CREATE TABLE dependent(
    essn CHAR(9),
    dependent_name VARCHAR(50),
    sex CHAR(1),
    bdate DATE,
    relationship VARCHAR(20),
    PRIMARY KEY(essn, dependent_name)
);

DESC dependent;

INSERT INTO employee VALUES 
('John', 'D', 'Doe', '1234567', '1990-05-01', '123 Main St', 'M', 50000, '98543222', 1),
('Jane', 'M', 'Smith', '9834567', '1985-08-15', '456 Elm St', 'F', 60000, '33443222', 2),
('David', 'S', 'Johnson', '5544567', '1992-12-10', '789 Oak St', 'M', 55000, '9876432', 1),
('Sarah', 'K', 'Brown', '222333444', '1991-03-25', '321 Maple St', 'F', 45000, '33325522', 2),
('Michael', 'R', 'Davies', '44455556', '1998-11-18', '987 Fine St', 'M', 70000, '5546733', 3);

SELECT * FROM employee;

INSERT INTO department VALUES
('Account', 1, '987664321', '2010-01-01'),
('Marketing', 2, '33344555', '2008-05-15'),
('IT', 3, '987664321', '2005-09-20');

SELECT * FROM department;

INSERT INTO dept_location VALUES
(1, 'Building A'),
(2, 'Building B'),
(3, 'Building C');

SELECT * FROM dept_location;

INSERT INTO project VALUES 
('Project 1', 1, 'Location 1', 1),
('Project 2', 2, 'Location 2', 2),
('Project 3', 3, 'Location 3', 3);

SELECT * FROM project;

INSERT INTO works_on VALUES
('1234567', 1, 40),
('22234423', 1, 35),
('455334', 2, 30),
('2222332', 2, 25),
('5556667', 3, 20);

SELECT * FROM works_on;

INSERT INTO dependent VALUES
('1234567', 'Child 1', 'M', '2010-02-14', 'Son'),
('22234423', 'Child 2', 'F', '2012-06-25', 'Daughter'),
('455334', 'Child 1', 'M', '2015-09-30', 'Son'),
('2222332', 'Child 1', 'F', '2017-03-10', 'Daughter'),
('5556667', 'Child 1', 'M', '2019-07-05', 'Son');

SELECT * FROM dependent;

SELECT 
    SUM(salary) AS total_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    AVG(salary) AS avg_salary
FROM
    employee 
WHERE 
    dno = (SELECT dnumber FROM department WHERE dname = 'Account');

SELECT 
    pnumber, pname,
    COUNT(essn) AS num_employees
FROM
    project 
JOIN 
    works_on ON project.pnumber = works_on.pno
GROUP BY
    pnumber, pname;

SELECT fname, lname
FROM employee
WHERE bdate BETWEEN '1990-01-01' AND '1999-12-31';

SELECT fname, lname
FROM employee
WHERE ssn IN (SELECT mgrssn FROM department WHERE dnumber = 1);

SELECT d.dname, COUNT(e.ssn) AS num_employees
FROM 
    department d
LEFT JOIN 
    employee e ON d.dnumber = e.dno
GROUP BY
    d.dname;

SELECT dno, COUNT(*) AS num_employees
FROM employee
WHERE salary > 40000
GROUP BY dno;

SELECT pno AS pnumber, COUNT(*) AS num_employees
FROM works_on
GROUP BY pno;


-- Assignment 5 --

CREATE DATABASE complex;
USE complex;

CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

DESC employee;

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id)
    REFERENCES employee(emp_id) ON
    DELETE SET NULL
);

CREATE TABLE client(
    client_id INT PRIMARY KEY,	
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY (branch_id)
    REFERENCES branch(branch_id)
    ON DELETE SET NULL
);

DESC client;

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,	
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id)
    REFERENCES employee(emp_id)
    ON DELETE CASCADE,
    FOREIGN KEY(client_id)
    REFERENCES client(client_id) 
    ON DELETE CASCADE
);

DESC works_with;

CREATE TABLE branch_suppliers(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

DESC branch_suppliers;

ALTER TABLE employee 
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)	
ON DELETE SET NULL;

DESC employee;

ALTER TABLE employee 
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

INSERT INTO employee VALUES
(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL),
(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1),
(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL),
(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2),
(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2),
(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2),
(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL),
(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3),
(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch VALUES
(1, 'Corporate', 100, '2006-02-09'),
(2, 'Scranton', 102, '1992-04-06'),
(3, 'Stamford', 106, '1998-02-13');

INSERT INTO branch_suppliers VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Writing Utensils'),
(3, 'Patriot Paper', 'Paper'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Uni-ball', 'Writing Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Lables', 'Custom Forms');

SELECT * FROM branch_suppliers;

INSERT INTO client VALUES
(400, 'Dunmore Highschool', 2),
(401, 'Lackawana Country', 2),
(402, 'FedEx', 3),
(403, 'John Daly Law, LLC', 3),
(404, 'Scranton Whitepages', 2),
(405, 'Times Newspaper', 3),
(406, 'FedEx', 2);

SELECT * FROM client;

INSERT INTO works_with VALUES
(105, 400, 55000),
(102, 401, 267000),
(108, 402, 22500),
(107, 403, 5000),
(108, 403, 12000),
(105, 404, 33000),
(107, 405, 26000),
(102, 406, 15000),
(105, 406, 130000);

SELECT * FROM works_with;

SELECT * FROM employee
ORDER BY sex, first_name, last_name;

SELECT first_name, last_name
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex='F' AND birth_day > '1971-01-01';

SELECT * FROM employee
LIMIT 5;

SELECT first_name AS forename, last_name AS surname
FROM employee;

SELECT COUNT(emp_id)
FROM employee;

SELECT AVG(salary)
FROM employee
WHERE sex='M';

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- Assignment 6 --

-- Step 1: Find any client’s who are an LLC.
SELECT * FROM client WHERE client_name LIKE '%LLC';

-- Step 2: Find any employee born in October.
SELECT * FROM employee WHERE birth_day LIKE '____-10%';

-- Step 3: Find a list of employee and branch names
SELECT first_name FROM employee
UNION
SELECT branch_name FROM branch
UNION
SELECT client_name FROM client;

-- Step 4: Find all the list of all clients & branch suppliers names.
SELECT client_name, branch_id FROM client
UNION
SELECT supplier_name, branch_id FROM branch_suppliers;

-- Step 5: Find a list of all money spent or earned by the company.
SELECT salary FROM employee
UNION
SELECT total_sales FROM works_with;

-- Step 6: Find names of all employees who have sold over 30,000 to a single client.
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
   SELECT works_with.emp_id
   FROM works_with
   WHERE works_with.total_sales > 30000
);

-- Lab - 7 Title : View
-- Introduction: Create a view table with emp_id, firstname,lastname,salary,department:

-- Create table employees
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    firstname VARCHAR(200),
    lastname VARCHAR(200),
    salary INT,
    department VARCHAR(200)
);

-- Insert values into the underlying table
INSERT INTO employees (emp_id, firstname, lastname, salary, department) VALUES
(1, 'John', 'Doe', 50000, 'IT'),
(2, 'Jane', 'Smith', 60000, 'Sales'),
(3, 'Alice', 'Johnson', 55000, 'Marketing');

SELECT * FROM employees;

-- Create the view
CREATE VIEW employe_view AS
SELECT emp_id, firstname, lastname, salary
FROM employees
WHERE department = 'IT';

SELECT * FROM employe_view;

-- Update view
CREATE OR REPLACE VIEW employe_view AS
SELECT emp_id, firstname, lastname, salary
FROM employees
WHERE department = 'IT';

SELECT * FROM employe_view;

-- Drop the view
DROP VIEW employe_view;


-- Assignment 7 --

-- Create table employees
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    firstname VARCHAR(200),
    lastname VARCHAR(200),
    salary INT,
    department VARCHAR(200)
);

-- Insert values into the underlying table
INSERT INTO employees (emp_id, firstname, lastname, salary, department) VALUES
(1, 'John', 'Doe', 50000, 'IT'),
(2, 'Jane', 'Smith', 60000, 'Sales'),
(3, 'Alice', 'Johnson', 55000, 'Marketing');

-- Select all records from employees table
SELECT * FROM employees;

-- Create the view
CREATE VIEW employe_view AS
SELECT emp_id, firstname, lastname, salary
FROM employees
WHERE department = 'IT';

-- Select all records from the view
SELECT * FROM employe_view;

-- Update the view
CREATE OR REPLACE VIEW employe_view AS
SELECT emp_id, firstname, lastname, salary
FROM employees
WHERE department = 'IT';

-- Select all records from the updated view
SELECT * FROM employe_view;

-- Drop the view
DROP VIEW employe_view;


-- Assignment 8 -- 

-- Create the trigger_test table
CREATE TABLE trigger_test (
    message VARCHAR(100)
);

-- Changing delimiter to allow for trigger definition
DELIMITER $$

-- Create the first trigger that inserts a fixed message into trigger_test
CREATE TRIGGER my_trigger BEFORE INSERT
ON employee
FOR EACH ROW
BEGIN
    INSERT INTO trigger_test VALUES ('added new employee');
END$$

-- Revert delimiter back to default
DELIMITER ;

-- Insert a new employee to trigger the first trigger
INSERT INTO employee
VALUES (109, 'Oscar', 'Martinez', '1979-02-27', 'M', 69000, NULL, NULL);

-- Select from trigger_test to see the result of the trigger
SELECT * FROM trigger_test;

-- Select from employee to see the new employee record
SELECT * FROM employee;

-- Changing delimiter to allow for trigger definition
DELIMITER $$

-- Create a second trigger that inserts the first name of the new employee into trigger_test
CREATE TRIGGER my_trigger1 BEFORE INSERT
ON employee
FOR EACH ROW
BEGIN
    INSERT INTO trigger_test VALUES (NEW.first_name);
END$$

-- Revert delimiter back to default
DELIMITER ;

-- Select from trigger_test to see the result of both triggers
SELECT * FROM trigger_test;

-- Insert another new employee to trigger both triggers
INSERT INTO employee
VALUES (110, 'Kevin', 'Malone', '1968-06-01', 'M', 69000, NULL, NULL);

-- Select from employee to see the new employee record
SELECT * FROM employee;

