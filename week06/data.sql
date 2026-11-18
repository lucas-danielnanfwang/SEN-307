
USE sen307_11431;

-- ===== Part 1: Departments and Courses (provided) =====
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

-- Check: 5 departments, 10 courses in total
SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

-- ===== Part 2 Step 1: Lecturers (10, two per department) =====
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor',     'a.okafor@vua.edu.ng',   1),
('VUA/ST/102', 'Dr Musa Bello',       'm.bello@vua.edu.ng',    1),
('VUA/ST/103', 'Prof Ngozi Eze',      'n.eze@vua.edu.ng',      2),
('VUA/ST/104', 'Dr Ibrahim Danjuma',  'i.danjuma@vua.edu.ng',  2),
('VUA/ST/105', 'Dr Chidinma Nwosu',   'c.nwosu@vua.edu.ng',    3),
('VUA/ST/106', 'Dr Tunde Adeyemi',    't.adeyemi@vua.edu.ng',  3),
('VUA/ST/107', 'Dr Hauwa Suleiman',   'h.suleiman@vua.edu.ng', 4),
('VUA/ST/108', 'Mr Emeka Obiora',     'e.obiora@vua.edu.ng',   4),
('VUA/ST/109', 'Dr Funke Balogun',    'f.balogun@vua.edu.ng',  5),
('VUA/ST/110', 'Dr Yakubu Garba',     'y.garba@vua.edu.ng',    5);

-- ===== Part 2 Step 2: Students (20) =====
-- Student 1 is me. Student 19 and 20 will have no enrolments.
INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('20231234', 'Lucas Daniel Nanfwang', 'M', '2004-06-15', 1),
('20231235', 'John Musa',             'M', '2004-11-02', 2),
('20231236', 'Ada Obi',               'F', '2005-03-14', 1),
('20231237', 'Fatima Abdullahi',      'F', '2003-09-21', 3),
('20231238', 'Chukwudi Okeke',        'M', '2005-01-30', 3),
('20231239', 'Blessing Ekpo',         'F', '2006-07-08', 4),
('20231240', 'Aminu Yusuf',           'M', '2003-12-12', 5),
('20231241', 'Zainab Lawal',          'F', '2004-04-19', 2),
('20231242', 'Samuel Ojo',            'M', '2005-08-25', 1),
('20231243', 'Grace Eze',             'F', '2006-02-03', 4),
('20231244', 'Ifeanyi Nnamdi',        'M', '2004-10-17', 5),
('20231245', 'Halima Sani',           'F', '2007-05-29', 3),
('20231246', 'David Adebayo',         'M', '2003-03-06', 2),
('20231247', 'Mercy Ikechukwu',       'F', '2005-11-11', 1),
('20231248', 'Peter Danladi',         'M', '2006-09-23', 4),
('20231249', 'Aisha Mohammed',        'F', '2004-01-14', 5),
('20231250', 'Emmanuel Udoh',         'M', '2007-02-27', 3),
('20231251', 'Joy Chukwuma',          'F', '2005-06-09', 2),
('20231252', 'Tobi Alabi',            'M', '2006-12-01', 1),
('20231253', 'Rakiya Umar',           'F', '2003-07-18', 4);

-- ===== Part 2 Step 3: Enrolments (40) and allocations =====
SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

INSERT INTO Enrolment (student_id, course_id) VALUES
(1,1),(1,2),(1,5),
(2,1),(2,3),
(3,1),(3,4),(3,6),
(4,1),(4,7),
(5,1),(5,8),(5,10),
(6,1),(6,9),
(7,2),(7,3),
(8,2),(8,5),
(9,3),(9,6),(9,9),
(10,4),(10,7),
(11,5),(11,8),
(12,6),(12,10),
(13,2),(13,7),
(14,3),(14,9),
(15,4),(15,8),
(16,1),(16,10),
(17,5),(17,6),
(18,2),(18,9);

-- Every course has a lecturer; course 1 (SEN307) has two
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1,1),(1,2),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,5),
(8,7),
(9,8),
(10,9);

-- ===== Part 3: UPDATE =====
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';
SET SQL_SAFE_UPDATES = 0;
UPDATE Student SET dept_id = 2 WHERE matric_no = '20231234';
SET SQL_SAFE_UPDATES = 1;
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '20231234';

-- ===== Part 4: Referential integrity =====
-- Step 1
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');
INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 2: this FAILS with Error 1451 (run it on its own, screenshot the error,
-- then leave it commented so the rest of the script runs cleanly)
-- DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- Step 3: the correct fix
SET SQL_SAFE_UPDATES = 0;
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM Department;

-- ===== Final check =====
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;
