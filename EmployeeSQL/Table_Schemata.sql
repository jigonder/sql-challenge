--create tables

CREATE TABLE Employees (
	emp_no INT NOT NULL,
	emp_title VARCHAR(20) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date DATE NOT NULL,
	CONSTRAINT pk_Employees PRIMARY KEY (emp_no)
	
);

SELECT * FROM Employees;


CREATE TABLE Departments (
	dept_no VARCHAR(20) NOT NULL,
	dept_name VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Departments PRIMARY KEY(
		dept_no
	)
);

SELECT * FROM Departments;

CREATE TABLE Department_Employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR(20) NOT NULL
);

SELECT * FROM Department_Employees;

CREATE TABLE Salaries (
	emp_no INT NOT NULL,
	salary DEC NOT NULL
);

SELECT * FROM Salaries;

CREATE TABLE Titles (
	title_id VARCHAR(10) NOT NULL,
	title VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Titles PRIMARY KEY(
		title_id
	)
);

SELECT * FROM Titles;

CREATE TABLE Department_Manager (
    dept_no VARCHAR(20) NOT NULL,
    emp_no INT NOT NULL
);

SELECT * FROM Department_Manager

--establish foreign keys

ALTER TABLE Employees
ADD CONSTRAINT fk_Employees_emp_title
FOREIGN KEY(emp_title)
REFERENCES Titles (title_id);

ALTER TABLE Department_Employees
ADD CONSTRAINT fk_Department_Employees_emp_no
FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Department_Employees
ADD CONSTRAINT fk_Departmet_Employees_dept_no
FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Salaries
ADD CONSTRAINT fk_Salaries_emp_no
FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Department_Manager
ADD CONSTRAINT fk_Department_Manager_dept_no
FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Department_Manager
ADD CONSTRAINT fk_Deparment_Manager_emp_no
FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

--query data/ answer analysis questions
--1) List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM Employees JOIN Salaries ON employees.emp_no = salaries.emp_no;



