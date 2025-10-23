CREATE DATABASE practice_db;
USE practice_db;


-- Department table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Employee table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,  -- references another employee (self-join)
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);


-- Departments
INSERT INTO departments (dept_name) VALUES
('HR'), ('Sales'), ('Engineering'), ('Finance');

-- Employees
INSERT INTO employees (first_name, last_name, salary, dept_id, manager_id)
VALUES
('Alice', 'Johnson', 85000, 1, NULL),        -- HR Manager
('Bob', 'Smith', 55000, 1, 1),              -- HR Staff, manager Alice
('Charlie', 'Brown', 95000, 2, NULL),       -- Sales Manager
('Diana', 'Lopez', 60000, 2, 3),            -- Sales Staff, manager Charlie
('Eve', 'Miller', 120000, 3, NULL),         -- Eng Manager
('Frank', 'White', 90000, 3, 5),            -- Eng Staff
('Grace', 'Davis', 65000, 4, NULL);         -- Finance Manager


SELECT * FROM departments;
SELECT * FROM employees;


SELECT 
    e.first_name AS Employee,
    m.first_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;


DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;

CALL GetAllEmployees();

DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(50))
BEGIN
    SELECT e.emp_id ,e.first_name,e.last_name,d.dept_name,e.salary
    FROM employees e
    JOIN departments d ON e.dept_id=d.dept_id
    WHERE d.dept_name=dept_name;
    END//
DELIMITER ;

CALL GetEmployeesByDepartment('HR');



DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartments(IN dept_names VARCHAR(100))
BEGIN
    -- Use FIND_IN_SET to allow comma-separated department names
    SELECT e.emp_id, e.first_name, e.last_name, d.dept_name, e.salary
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE FIND_IN_SET(d.dept_name, dept_names) > 0;
END //
DELIMITER ;


CALL GetEmployeesByDepartments('Engineering,HR');


DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN f_name VARCHAR(50),
    IN l_name VARCHAR(50),
    IN sal DECIMAL(10,2),
    IN dept INT,
    IN mgr INT
)
BEGIN
    INSERT INTO employees (first_name, last_name, salary, dept_id, manager_id)
    VALUES (f_name, l_name, sal, dept, mgr);
END //
DELIMITER ;

CALL AddEmployee('Abhi', 'Santhu', 70000, 2, 3);


DELIMITER //
CREATE PROCEDURE GetEmployeeManager()
BEGIN
    SELECT 
        e.emp_id,
        e.first_name AS Employee,
        m.first_name AS Manager,
        d.dept_name
    FROM employees e
    LEFT JOIN employees m ON e.manager_id = m.emp_id
    JOIN departments d ON e.dept_id = d.dept_id
    ORDER BY d.dept_name, Manager;
END //
DELIMITER ;


CALL GetEmployeeManager();

DELIMITER //
CREATE PROCEDURE GetTotalSalaryByDept(
    IN dept_name VARCHAR(50),
    OUT total_salary DECIMAL(10,2)
)
BEGIN
    SELECT SUM(e.salary)
    INTO total_salary
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE d.dept_name = dept_name;
END //
DELIMITER ;

CALL GetTotalSalaryByDept('Engineering', @total);
SELECT @total AS Total_Salary_Engineering;

SELECT * FROM employees;