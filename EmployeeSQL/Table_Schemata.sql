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
FROM Employees
JOIN Salaries
ON employees.emp_no = salaries.emp_no;

--2)List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3)List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT department_manager.emp_no, employees.first_name, employees.last_name, departments.dept_name, departments.dept_no
FROM department_manager
JOIN Employees 
ON employees.emp_no = department_manager.emp_no
JOIN Departments
ON department_manager.dept_no = departments.dept_no;

--4)List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

CREATE VIEW department_managers as 
SELECT department_employees.emp_no, employees.last_name, employees.first_name, departments.dept_name, department_manager.dept_no
FROM department_employees
JOIN departments
ON departments.dept_no = department_employees.dept_no
JOIN employees
ON employees.emp_no = department_employees.emp_no
JOIN department_manager
ON employees.emp_no = department_manager.emp_no;

Select * From department_managers

--5)List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name like 'B%';

--6)List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN department_employees
ON department_employees.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = department_employees.dept_no
WHERE dept_name = 'Sales';
 
--7)List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN department_employees
ON department_employees.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = department_employees.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--8)In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, 
COUNT(*) FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;
