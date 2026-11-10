--Part 3: return only courses which graduate students may enrol in 
SELECT * FROM course WHERE gradCourse IN (1,2);