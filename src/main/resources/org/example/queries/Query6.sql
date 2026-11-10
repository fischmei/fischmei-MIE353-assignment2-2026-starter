-- Part 4: List all the students (full names) who have taken a course named “Data Modelling”
-- and received a grade of 90 or above in at least one course not named “Data Modelling”

COPY (
    SELECT s.firstName || ' ' || s.lastName AS studentFullName
    FROM student s
    WHERE s.studentId IN (
        SELECT tr.studentId
        FROM transcript tr, course c
        WHERE tr.courseId = c.courseId
          AND c.courseName = 'Data Modelling'
    )
    AND s.studentId IN (
        SELECT tr.studentId
        FROM transcript tr, course c
        WHERE tr.courseId = c.courseId
          AND tr.grade >= 90
          AND c.courseName <> 'Data Modelling'
    )
)
TO 'src/main/resources/data/output/query6.csv';