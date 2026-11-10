-- Part 4: What are the full names of all professors who have taught at least one course taken by Rebecca Ward?

COPY (
    SELECT DISTINCT p.firstName || ' ' || p.lastName AS profFullName
    FROM professor p, teaches t, transcript ts, student s
    WHERE p.profId = t.profId
      AND t.courseId = ts.courseId
      AND ts.studentId = s.studentId
      AND s.firstName = 'Rebecca'
      AND s.lastName = 'Ward'
)
TO 'src/main/resources/data/output/query4.csv';