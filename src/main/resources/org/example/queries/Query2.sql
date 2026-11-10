-- Part 4: What are all the names of fourth-year courses? (fourth-year courses have a number code beginning with 4 after their department code)

COPY (
    SELECT DISTINCT courseName
    FROM course
    WHERE courseId LIKE '___4%'
)
TO 'src/main/resources/data/output/query2.csv';