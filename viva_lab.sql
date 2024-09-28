CREATE DATABASE Employees;
USE Employees;

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

INSERT INTO employee VALUES
(100, 'Suyog', 'Wallace', '1966-01-18', 'M', 250000, NULL, NULL),
(101, 'Rita', 'Levinson', '1962-08-21', 'F', 110000, 100, 1),
(102, 'Michael', 'Scott', '1963-11-25', 'M', 75000, 100, NULL),
(103, 'Prakati', 'Martin', '1972-06-25', 'F', 63000, 102, 2),
(104, 'Samjhana', 'Kapoor', '1981-02-05', 'F', 55000, 102, 2),
(105, 'Pras', 'Hudson', '1959-04-19', 'M', 69000, 102, 2),
(106, 'OP', 'Porter', '1969-10-05', 'M', 78000, 100, NULL),
(107, 'Saurav', 'Bernard', '1971-07-22', 'M', 65000, 106, 3),
(108, 'Hari', 'Halpert', '1977-10-01', 'M', 71000, 106, 3);


CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE

);

INSERT INTO branch VALUES
(1, 'Corporate', 100, '2006-02-09'),
(2, 'Scranton', 102, '1992-04-06'),
(3, 'Stamford', 106, '1998-02-13');

SELECT * FROM branch;

CREATE TABLE client(
    client_id INT PRIMARY KEY,    
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY (branch_id)
    REFERENCES branch(branch_id)
    ON DELETE SET NULL
);

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


CREATE TABLE branch_suppliers(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE CASCADE
);

INSERT INTO client VALUES
(400, 'Dunmore Highschool', 2),
(401, 'Lackawana County', 2),
(402, 'FedEx', 2),
(403, 'John Daly Law, LLC', 3),
(404, 'Scranton Whitepages', 2),
(405, 'Times Newspaper', 3),
(406, 'FedEx', 2);


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

INSERT INTO branch_suppliers VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Writing Utensils'),
(3, 'Patriot Paper', 'Paper'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Uni-ball', 'Writing Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Labels', 'Custom Forms');

-- i. Find the average of all male employees' salary

SELECT AVG(salary) AS avg_male_salary FROM employee;

-- ii. Find all clients who are handled by the branch that Michael Scott manages

SELECT client.client_name 
FROM client JOIN branch 
ON client.branch_id = branch.branch_id WHERE branch.mgr_id = 102;


-- i. Find the number of female employees born after 1970

SELECT COUNT(*) AS female_count
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

-- ii. Find the names of all employees who have sold over 30,000 to a single client

SELECT employee.first_name, employee.last_name
FROM employee
JOIN works_with ON employee.emp_id = works_with.emp_id
WHERE works_with.total_sales > 30000;


