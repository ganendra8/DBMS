CREATE DATABASE student;
use student;

CREATE TABLE students(
std_id INT PRIMARY KEY,
std_name VARCHAR(20),
std_address VARCHAR(20),
dept_id INT,
age INT
);

INSERT INTO students VALUES
(10, 'Maya', 'Palpa', 1, 21),
(11, 'Hari', 'ktm', 2, 22),
(12, 'Ram', 'ktm', 1, 19),
(13, 'Sira', 'ktm', 3, 33),
(14, 'Pinky', 'Palpa', 4, 23),
(15, 'Gita', 'Pokhara', 2, 22),
(16, 'Rita', 'ktm', 1, 49);

SELECT std_name, std_address FROM students;

SELECT std_name, std_address FROM students WHERE dept_id = 1;

SELECT std_name, std_address FROM students WHERE std_address = 'ktm';

SELECT std_name, std_address FROM students WHERE std_address != 'ktm';

SELECT std_name, dept_id FROM students WHERE (dept_id > 2);

SELECT std_name, dept_id FROM students WHERE (dept_id >= 2);


-- Logical AND operator
SELECT std_name, dept_id From students WHERE std_address = 'ktm' AND dept_id <> 1; -- <> not equal sign
SELECT std_id, std_name, dept_id FROM students WHERE stD_address = 'ktm' ORDER BY std_name ASC;
SELECT std_id, std_name, dept_id FROM students WHERE stD_address = 'ktm' ORDER BY std_name DESC;


CREATE TABLE Department(
dept_id INT,
dept_name VARCHAR(255),
dept_block_no INT
);

INSERT INTO Department VALUES
(1,'Computer', 100),
(2,'Mahematics', 200),
(3,'Economics', 300),
(4,'Account', 400),
(5,'Phycics', 500);

SELECT dept_id AS id, dept_block_no AS "block_no" FROM Department;

-- Find the maximum and minimum of dept_id

SELECT MAX(dept_id), MIN(dept_id) FROM Department;

-- Find average of department_block whose id is less than 3

SELECT AVG(dept_block_no) AS 'block_average' From Department WHERE dept_id > 3;

-- Find total no of department and alias the column as Tot_depart

SELECT COUNT(*) AS Tot_depart FROM Department;

SELECT COUNT(dept_id) AS 'No of Department' FROM Department WHERE dept_name LIKE "%S";
