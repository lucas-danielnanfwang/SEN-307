
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Lucas Daniel Nanfwang   Matric: 11431  
USE sen307_11431;

-- Recap: confirm the Week 6 data is there
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;

-- --------------------------------------------
-- Task 1: Students in one department, sorted A-Z
-- Explanation: Joins Student to Department on dept_id, keeps only the
-- Software Engineering rows with WHERE, and sorts by name with ORDER BY ASC.
-- --------------------------------------------
SELECT s.matric_no, s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Comment: lists every Software Engineering student alphabetically. Lucas is not
-- shown because he was moved to Computer Science in Week 6.

-- --------------------------------------------
-- Task 2: Courses with their lecturers (INNER JOIN)
-- Explanation: Course and Lecturer have no direct link, so we go through the
-- CourseAllocation bridge table: Course -> CourseAllocation -> Lecturer.
-- INNER JOIN keeps only rows that match in both tables.
-- --------------------------------------------
SELECT c.course_code, c.course_title, l.full_name AS lecturer
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_code, l.full_name;
-- Comment: returns one row per course-lecturer pair. SEN307 appears twice
-- because it has two lecturers.

-- --------------------------------------------
-- Task 3: Students and their courses (LEFT JOIN)
-- Explanation: LEFT JOIN keeps ALL students (the left table). Where a student
-- has no enrolment, the course columns come back as NULL.
-- --------------------------------------------
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Comment: every student with each of their courses; students with no
-- enrolments show NULL for course_title.

-- Only the students with no courses
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Comment: shows the students with no enrolments: Rakiya Umar, Tobi Alabi
-- (the two created in Week 6) and Transfer Student (added in Part 4).

-- --------------------------------------------
-- Task 4: Filtering with AND / OR / IN / BETWEEN
-- Explanation: Combines AND, IN and BETWEEN (three of the four operators).
-- --------------------------------------------
SELECT matric_no, full_name, gender, date_of_birth, dept_id
FROM Student
WHERE gender = 'F'
  AND dept_id IN (1, 3)
  AND date_of_birth BETWEEN '2004-01-01' AND '2005-12-31';
-- Comment: female students in Software Engineering (1) or Artificial
-- Intelligence (3) who were born in 2004 or 2005.

-- Same idea using OR as well (brackets are needed when mixing AND with OR)
SELECT matric_no, full_name, gender, date_of_birth, dept_id
FROM Student
WHERE (dept_id = 1 OR dept_id = 3)
  AND gender = 'F'
  AND date_of_birth BETWEEN '2004-01-01' AND '2005-12-31';
-- Comment: gives the same result. The brackets make the OR apply to the
-- department only; without them AND would bind first and change the meaning.

-- --------------------------------------------
-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Explanation: LIMIT 10 returns 10 rows; OFFSET skips rows already shown.
-- --------------------------------------------
-- Page 1 (rows 1-10)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 0;
-- Page 2 (rows 11-20)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 10;
-- Comment: Why always ORDER BY with LIMIT? Without ORDER BY, MySQL returns
-- rows in no guaranteed order, so page 1 and page 2 could overlap or skip
-- rows. ORDER BY makes the order stable, so each page is predictable.

-- --------------------------------------------
-- Challenge: Task 3 rewritten with RIGHT JOIN
-- --------------------------------------------
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name;
-- Comment: same result as the LEFT JOIN version, because Student is now the
-- right-hand table and RIGHT JOIN keeps all of its rows. The LEFT JOIN version
-- is easier to read: it starts from Student (the table we care about) and
-- reads left to right, whereas the RIGHT JOIN version puts the main table last.
