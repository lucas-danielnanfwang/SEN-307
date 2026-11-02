# VUA-SEN307 — Week 5 Practical (Lab 3: DDL) — Notes

Matric no: 20231234 (replace with yours) | Database: sen307_20231234

## Part 3: Constraint tests (each statement failed, no rows saved)

| # | Constraint | Statement | Error message |
|---|-----------|-----------|---------------|
| 1 | NOT NULL | `INSERT INTO Department (dept_name) VALUES (NULL);` | `ERROR 1048 (23000) at line 1: Column 'dept_name' cannot be null` |
| 2 | CHECK | `INSERT INTO Course (course_code, course_title, credit_units) VALUES ('TST101','Test',9);` | `ERROR 3819 (HY000) at line 1: Check constraint 'chk_credit_units' is violated.` |
| 3 | FOREIGN KEY | `INSERT INTO Student (matric_no, full_name, dept_id) VALUES ('TEST001','Test',999);` | `ERROR 1452 (23000) at line 1: Cannot add or update a child row: a foreign key constraint fails (`sen307_20231234`.`Student`, CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`))` |
| 4 | ENUM | `INSERT INTO Student (matric_no, full_name, gender) VALUES ('TEST002','Test','X');` | `ERROR 1265 (01000) at line 1: Data truncated for column 'gender' at row 1` |

Confirmation: `SELECT COUNT(*)` returned **0** for Department, Course and Student, so every table is still empty.

### My own test: UNIQUE on Department.dept_name

```sql
INSERT INTO Department (dept_name) VALUES ('Software Engineering');  -- succeeds
INSERT INTO Department (dept_name) VALUES ('Software Engineering');  -- fails
```
Error: `ERROR 1062 (23000) at line 1: Duplicate entry 'Software Engineering' for key 'Department.dept_name'`

Cleanup:
```sql
DELETE FROM Department WHERE dept_name = 'Software Engineering';
```

## Part 4: Comparison with my Week 4 diagram

> EDIT THIS SECTION: it must describe YOUR own Week 4 diagram. Suggested wording:

My Week 4 diagram showed Student–Course and Course–Lecturer as many-to-many relationships. The reverse-engineered EER diagram replaces both with the junction tables Enrolment and CourseAllocation, each holding two foreign keys, because MySQL cannot store a many-to-many relationship directly. It also shows the physical details the logical model left out: data types, AUTO_INCREMENT primary keys, UNIQUE keys such as (student_id, course_id, academic_session), and the `phone` column added later with ALTER TABLE.
