-- Part 4: What are the full names3 of professors teaching exactly one course?

COPY (
    SELECT p.firstName || ' ' || p.lastName AS profFullName
    FROM professor p, teaches t
    WHERE p.profId = t.profId
    GROUP BY p.profId, p.firstName, p.lastName
    HAVING COUNT(*) = 1
)
TO 'src/main/resources/data/output/query3.csv';