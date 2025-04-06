
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    RollNumber VARCHAR(10),
    Course VARCHAR(10)
);


CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(50),
    TeacherID INT
);


CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    StudentID INT,
    SubjectID INT,
    Date DATE,
    Status VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);
