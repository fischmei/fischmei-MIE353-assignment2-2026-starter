-- Part 4: Which professors (full names) who teach at least one course have never given a failing 
-- grade in any of their courses? (A failing grade is 49 or below).

COPY (
    SELECT p.firstName || ' ' || p.lastName AS profFullName
    FROM professor p
    WHERE p.profId IN (
        SELECT profId
        FROM teaches
    )
    AND p.profId NOT IN (
        SELECT t.profId
        FROM teaches t, transcript tr
        WHERE t.courseId = tr.courseId AND tr.grade <= 49
    )
)
TO 'src/main/resources/data/output/query5.csv';