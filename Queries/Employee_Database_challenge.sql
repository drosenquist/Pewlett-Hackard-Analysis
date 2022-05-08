--The Number of Retiring Employees by Title
SELECT emp.emp_no,
    emp.first_name,
    emp.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees AS emp
INNER JOIN titles AS ti
ON (emp.emp_no = ti.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rtitle.emp_no) rtitle.emp_no,
    rtitle.first_name,
    rtitle.last_name,
    rtitle.title
INTO unique_titles
FROM retirement_titles AS rtitle
WHERE (rtitle.to_date = '9999-01-01')
ORDER BY rtitle.emp_no, rtitle.to_date DESC;

SELECT * FROM retirement_titles;

-- Number of employees by current job title close to retirement
SELECT COUNT(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--Employee mentorship eligibility
SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
  emp.first_name,
  emp.last_name,
  emp.birth_date,
  demp.from_date,
  demp.to_date,
  ti.title
INTO mentorship
FROM employees as emp
INNER JOIN dept_emp as demp
  ON (emp.emp_no = demp.emp_no)
INNER JOIN titles as ti
  ON (emp.emp_no = ti.emp_no)
WHERE (demp.to_date = '9999-01-01')
AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no;

SELECT * FROM mentorship;