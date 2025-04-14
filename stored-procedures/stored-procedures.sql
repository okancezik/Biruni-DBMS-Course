-- Author: Okan Çezik
-- Date: 14.04.2025

-- STEP 1 CREATE TABLE

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    HireDate DATE
);


--STEP 2 CREATE STORED PROCEDURE
CREATE PROCEDURE uspInsertEmployee
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Department NVARCHAR(50),
    @HireDate DATE
AS
BEGIN
    INSERT INTO Employee (FirstName, LastName, Department, HireDate)
    VALUES (@FirstName, @LastName, @Department, @HireDate);
END;


--STEP 3 CALL STORED PROCEDURE
EXEC uspInsertEmployee 
    @FirstName = 'Okan', 
    @LastName = 'Cezik', 
    @Department = 'Software Engineering', 
    @HireDate = '2024-07-22';


-- STEP 4 NEW STORED PROCEDURE (SELECT)
CREATE PROCEDURE uspGetAllEmployees
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, Department, HireDate
    FROM Employee;
END;

-- STEP 5 EXEC STORED PROCEDURE

EXEC uspGetAllEmployees


--STEP 6 UPDATE Stored Procedure with Error Handling

CREATE PROCEDURE uspUpdateEmployeeDepartment
    @EmployeeID INT,
    @NewDepartment NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        UPDATE Employee
        SET Department = @NewDepartment
        WHERE EmployeeID = @EmployeeID;
    END TRY
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;


--STEP 7 DELETE Stored Procedure with Transaction Management

CREATE PROCEDURE uspDeleteEmployee
    @EmployeeID INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        DELETE FROM Employee
        WHERE EmployeeID = @EmployeeID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;


--STEP 8 EXEC uspUpdateEmployeeDepartment

EXEC uspUpdateEmployeeDepartment
    @EmployeeID = 101,          
    @NewDepartment = 'Sales';   


--STEP 9 OUTPUT

CREATE PROCEDURE uspGetEmployeeDepartment
    @EmployeeID INT,             
    @Department NVARCHAR(50) OUTPUT 
AS
BEGIN
    SELECT @Department = Department
    FROM Employee
    WHERE EmployeeID = @EmployeeID;
END;

--STEP 10
DECLARE @Dept NVARCHAR(50); 

EXEC uspGetEmployeeDepartment 
    @EmployeeID = 2,      
    @Department = @Dept OUTPUT;

SELECT @Dept AS Department;
