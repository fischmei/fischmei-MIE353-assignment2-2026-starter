-- Part 4: Find all pairs of students who have taken at least three courses in common. For each
-- pair, list both students’ full names (as two columns, each pair listed only once), the
-- number of courses they have in common, and each student’s average grade across those shared courses.

COPY (
    SELECT s1.firstName || ' ' || s1.lastName AS s1FullName,
           s2.firstName || ' ' || s2.lastName AS s2FullName,
           COUNT(*) AS commonCourses,
           AVG(t1.grade) AS s1AverageGrade,
           AVG(t2.grade) AS s2AverageGrade
    FROM student s1, student s2, transcript t1, transcript t2
    WHERE t1.courseId = t2.courseId
      AND t1.studentId = s1.studentId
      AND t2.studentId = s2.studentId
      AND t1.studentId < t2.studentId
    GROUP BY s1.studentId, s1.firstName, s1.lastName,
             s2.studentId, s2.firstName, s2.lastName
    HAVING COUNT(*) >= 3
)
TO 'src/main/resources/data/output/query7.csv';