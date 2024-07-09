CREATE DATABASE student;
USE student;

CREATE TABLE Author
(
    Aid INT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Age INT CHECK (Age > 10),
    Gender VARCHAR(7) DEFAULT 'UNKNOWN',
    Address VARCHAR(50)
);

INSERT INTO Author (Aid, Name, Age, Gender, Address)
VALUES
    (1001, 'John Smith', 45, 'Male', '123 Elm St'),
    (1002, 'Jane Doe', 38, 'Female', '456 Maple Ave'),
    (1003, 'Sam Brown', 55, 'Male', '789 Oak Blvd'),
    (1004, 'Lisa White', 29, 'Female', '321 Pine Rd');



DROP TABLE Author;

CREATE TABLE Writes
(
    Aid INT,
    Bid INT PRIMARY KEY,
    Publishdate DATE,
    Age INT CHECK (Age > 10),
    Gender VARCHAR(7) DEFAULT 'UNKNOWN',
    Bookname VARCHAR(20),
    ISBN VARCHAR(20) NOT NULL,
    FOREIGN KEY (Aid) REFERENCES Author (Aid)
);

INSERT INTO Writes (Aid, Bid, Publishdate, Age, Gender, Bookname, ISBN)
VALUES
    (1001, 2001, '2023-01-15', 45, 'Male', 'The Great Adventure', '1234567890123'),
    (1002, 2002, '2022-07-23', 38, 'Female', 'Mystery of the Night', '2345678901234'),
    (1003, 2003, '2021-11-30', 55, 'Male', 'History Unveiled', '3456789012345'),
    (1004, 2004, '2020-05-20', 29, 'Female', 'Romance in Paris', '4567890123456');



SELECT * FROM Author;
SELECT * FROM Writes;

