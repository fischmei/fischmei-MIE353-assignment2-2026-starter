-- Part 4: How many students received a grade of 80 or above in mie301h1f?

COPY (
    SELECT COUNT(*) AS studentCount
    FROM transcript
    WHERE courseId = 'mie301h1f' AND grade >= 80
)
TO 'src/main/resources/data/output/query1.csv';