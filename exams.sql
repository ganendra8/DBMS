/*
Consider a banking database with three labels and primary key underlined as given
below:
 Customer (CustomerID, CustomerName, Address, Phone, Email)
 Borrows (CustomerID, LoanNumber)
 Loan (LoanNumber, LoanType, Amount)
Write both relational algebra and SQL queries:
-To display name of all customers who live in “Lalitpur” in ascending order of name.
-To count total number of customers having loan at the bank.
-To find name of those customers who have loan amount greater than or equal to 500000.
-To find average loan amount of each account type. 
*/


CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Address VARCHAR(255),
    Phone VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE Loan(
	LoanNumber INT PRIMARY KEY,
    LoanType VARCHAR(50),
    Amount INT
);

CREATE TABLE Borrows(
	CustomerID INT,
    LoanNumber INT,
    PRIMARY KEY(CustomerID, LoanNumber),
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY(LoanNumber) REFERENCES Loan(LoanNUmber)
);


-- Relational Algebra

-- τ_CustomerName(π_CustomerName(σ_Address = 'Lalitpur' (Customer))


SELECT CustomerName FROM Customer WHERE Address = 'Lalitpur' ORDER BY CustomerName ASC;


-- COUNT(π_CustomerID (Borrows))

SELECT COUNT(DISTINCT CustomerID) FROM Borrows;


-- π CustomerName (σ Amount ≥ 500000 (Customer ⨝ Borrows ⨝ Loan))

SELECT DISTINCT CustomerName FROM Customer JOIN Borrows on Customer.CustomerID
= Borrows.CustomerID JOIN Loan on Borrows.LoanNumber = Loan.LoanNumber 
WHERE Loan.Amount >= 50000;

-- γ LoanType, AVG(Amount) (Loan)

SELECT LoanType, AVG(Amount) AS AverageAmount 
FROM Loan 
GROUP BY LoanType;

