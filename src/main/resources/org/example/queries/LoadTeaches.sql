-- Part2 make sql loader

CREATE TABLE IF NOT EXISTS teaches (
    profId INT NOT NULL,
    courseId VARCHAR(20) NOT NULL,
    PRIMARY KEY (profID, courseID),
    FOREIGN KEY (profId) REFERENCES professor(profID),
    FOREIGN KEY (courseId) REFERENCES course(courseID)
);

COPY teaches FROM 'src/main/resources/data/teaches.csv';