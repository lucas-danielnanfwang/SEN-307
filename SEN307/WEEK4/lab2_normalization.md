<!-- LUCAS DANIEL NANFWANG
VUG/SEN/24/11431 -->
# Lab 2: Database Design and Normalization

## Part 1: Entities and Attributes

| Entity | Attributes | Primary key |
|---|---|---|
| Department | dept_id, dept_name | dept_id |
| Student | student_id, matric_no, full_name, dept_id | student_id |
| Lecturer | lecturer_id, full_name, dept_id | lecturer_id |
| Course | course_id, course_code, course_title | course_id |
| Enrolment | enrolment_id, student_id, course_id, session | enrolment_id |
| Teaching | teaching_id, lecturer_id, course_id, session | teaching_id |

## Part 1: Relationships and Cardinalities

The design has two many-to-many relationships, so it needs two junction tables: Enrolment and Teaching.

| Relationship | Cardinality | Explanation |
|---|---|---|
| Department – Student | 1:N | A student belongs to one department; a department has many students. |
| Department – Lecturer | 1:N | A lecturer belongs to one department; a department has many lecturers. |
| Student – Course | M:N | A student registers for many courses; a course has many students. |
| Lecturer – Course | M:N | A course can have different lecturers across sessions; a lecturer can teach many courses. |

## Part 2: Normalization

### Unnormalized Table

| matric_no | student_name | student_dept | course_codes | course_titles | lecturers | lecturer_depts | session |
|---|---|---|---|---|---|---|---|
| 20231234 | Ada Obi | Software Engineering | SEN307, SEN301 | Database Systems, Software Architecture | Dr A. Okafor, Dr M. Bello | Software Eng., Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | SEN307, COS301 | Database Systems, Operating Systems | Dr A. Okafor, Mrs F. Eze | Software Eng., Computer Sci. | 2026/2027 |
| 20231236 | Grace Okon | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |

### First Normal Form (1NF)

**What I fixed:** I removed multi-valued cells by giving each student–course pair its own row, so every cell now holds a single value.

**Primary key:** (matric_no, course_code), a composite key, since neither column is unique on its own.

| matric_no | student_name | student_dept | course_code | course_title | lecturer | lecturer_dept | session |
|---|---|---|---|---|---|---|---|
| 20231234 | Ada Obi | Software Engineering | SEN307 | Database Systems | Dr A. Okafor | Software Eng. | 2026/2027 |
| 20231234 | Ada Obi | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | SEN307 | Database Systems | Dr A. Okafor | Software Eng. | 2026/2027 |
| 20231235 | John Musa | Computer Science | COS301 | Operating Systems | Mrs F. Eze | Computer Sci. | 2026/2027 |
| 20231236 | Grace Okon | Software Engineering | SEN301 | Software Architecture | Dr M. Bello | Software Eng. | 2026/2027 |

### Second Normal Form (2NF)

**What I fixed:** I removed partial dependencies, columns that depended on only part of the composite key, by moving student details and course details into their own tables.

**Student** (PK: matric_no)

| matric_no | student_name | student_dept |
|---|---|---|
| 20231234 | Ada Obi | Software Engineering |
| 20231235 | John Musa | Computer Science |
| 20231236 | Grace Okon | Software Engineering |

**Course** (PK: course_code)

| course_code | course_title | lecturer | lecturer_dept |
|---|---|---|---|
| SEN307 | Database Systems | Dr A. Okafor | Software Eng. |
| SEN301 | Software Architecture | Dr M. Bello | Software Eng. |
| COS301 | Operating Systems | Mrs F. Eze | Computer Sci. |

**Enrolment** (PK: matric_no + course_code)

| matric_no | course_code | session |
|---|---|---|
| 20231234 | SEN307 | 2026/2027 |
| 20231234 | SEN301 | 2026/2027 |
| 20231235 | SEN307 | 2026/2027 |
| 20231235 | COS301 | 2026/2027 |
| 20231236 | SEN301 | 2026/2027 |

### Third Normal Form (3NF)

**What I fixed:** I removed transitive dependencies, where a non-key column depended on another non-key column, by moving department and lecturer details into their own tables linked by foreign keys.

**Department** (PK: dept_id)

| dept_id | dept_name |
|---|---|
| 1 | Software Engineering |
| 2 | Computer Science |

**Student** (PK: student_id, FK: dept_id)

| student_id | matric_no | full_name | dept_id |
|---|---|---|---|
| 1 | 20231234 | Ada Obi | 1 |
| 2 | 20231235 | John Musa | 2 |
| 3 | 20231236 | Grace Okon | 1 |

**Lecturer** (PK: lecturer_id, FK: dept_id)

| lecturer_id | full_name | dept_id |
|---|---|---|
| 1 | Dr A. Okafor | 1 |
| 2 | Dr M. Bello | 1 |
| 3 | Mrs F. Eze | 2 |

**Course** (PK: course_id)

| course_id | course_code | course_title |
|---|---|---|
| 1 | SEN307 | Database Systems |
| 2 | SEN301 | Software Architecture |
| 3 | COS301 | Operating Systems |

**Enrolment** (PK: enrolment_id, FKs: student_id, course_id)

| enrolment_id | student_id | course_id | session |
|---|---|---|---|
| 1 | 1 | 1 | 2026/2027 |
| 2 | 1 | 2 | 2026/2027 |
| 3 | 2 | 1 | 2026/2027 |
| 4 | 2 | 3 | 2026/2027 |
| 5 | 3 | 2 | 2026/2027 |

**Teaching** (PK: teaching_id, FKs: lecturer_id, course_id)

| teaching_id | lecturer_id | course_id | session |
|---|---|---|---|
| 1 | 1 | 1 | 2026/2027 |
| 2 | 2 | 2 | 2026/2027 |
| 3 | 3 | 3 | 2026/2027 |

### Final Schema

- Department (dept_id PK, dept_name)
- Student (student_id PK, matric_no, full_name, dept_id FK → Department)
- Lecturer (lecturer_id PK, full_name, dept_id FK → Department)
- Course (course_id PK, course_code, course_title)
- Enrolment (enrolment_id PK, student_id FK → Student, course_id FK → Course, session)
- Teaching (teaching_id PK, lecturer_id FK → Lecturer, course_id FK → Course, session)
