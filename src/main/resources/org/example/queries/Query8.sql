-- Part 4: For each student and each department in which the student has taken at least two
-- courses with different course numbers, compare the student’s grade in their lowest-level 
-- course in that department with their grade in their highest-level course in that
-- department. A course is higher-level if it has a higher course number within its department 
-- (MIE353 is higher than MIE250), and graduate courses are higher-level than all
-- undergraduate and 500-level courses. If several courses share the same course number,
-- use the one with the higher grade. Your result should consist of four columns: the
-- student’s full name, the department code, the (lowest, highest) pair of courses, and the
-- (lowest, highest) pair of grades for those courses. Be sure to list all student–department
-- combinations that qualify.

-- Reference for SUBSTR: https://duckdb.org/docs/1.3/sql/functions/text

CREATE VIEW takenCourses AS
SELECT t.studentId, t.courseId, t.grade,
       SUBSTR(t.courseId, 1, 3) AS department,
       '9' || SUBSTR(t.courseId, 4, 4) AS rank
FROM transcript t, course c
WHERE t.courseId = c.courseId AND c.gradCourse = 1

UNION ALL

SELECT t.studentId, t.courseId, t.grade,
       SUBSTR(t.courseId, 1, 3) AS department,
       SUBSTR(t.courseId, 4, 3) AS rank
FROM transcript t, course c
WHERE t.courseId = c.courseId AND c.gradCourse IN (0, 2);

CREATE VIEW takenPairs AS
SELECT studentId, department,
       MAX(rank) AS highest,
       MIN(rank) AS lowest
FROM takenCourses
GROUP BY studentId, department
HAVING COUNT(DISTINCT rank) >= 2;

COPY (
    SELECT s.firstName || ' ' || s.lastName AS studentFullName,
           p.department,
           '(' || MIN(l.courseId) || ', ' || MIN(h.courseId) || ')' AS courses,
           '(' || l.grade || ', ' || h.grade || ')' AS grades
    FROM student s, takenPairs p, takenCourses l, takenCourses h
    WHERE s.studentId = p.studentId
      AND l.studentId = p.studentId
      AND l.department = p.department
      AND l.rank = p.lowest
      AND h.studentId = p.studentId
      AND h.department = p.department
      AND h.rank = p.highest
      AND l.grade = (
          SELECT MAX(t.grade)
          FROM takenCourses t
          WHERE t.studentId = p.studentId
            AND t.department = p.department
            AND t.rank = p.lowest
      )
      AND h.grade = (
          SELECT MAX(t.grade)
          FROM takenCourses t
          WHERE t.studentId = p.studentId
            AND t.department = p.department
            AND t.rank = p.highest
      )
    GROUP BY s.studentId, s.firstName, s.lastName,
             p.department, l.grade, h.grade
)
TO 'src/main/resources/data/output/query8.csv';