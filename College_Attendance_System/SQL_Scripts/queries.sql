-- Q.1 Fetch attendance records of a specific student.
SELECT 
    a.StudentID, s.Name AS StudentName,
    a.SubjectID,
    subj.SubjectName,
    a.Date,
    a.Status
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
JOIN Subjects subj ON a.SubjectID = subj.SubjectID
WHERE a.StudentID = 3 
ORDER BY a.Date;

-- Q.2. Count total present and absent days for a student.
--(Assumption taken by us: A student is considered as present if he/she is present in all classes of that day)
WITH SubjectCountPerStudent AS (
    SELECT StudentID, Date, COUNT(*) AS TotalSubjects
    FROM Attendance
    GROUP BY StudentID, Date
),
PresentCountPerStudent AS (
    SELECT StudentID, Date, COUNT(*) AS PresentSubjects
    FROM Attendance
    WHERE Status = 'Present'
    GROUP BY StudentID, Date
),
DayWiseAttendance AS (
    SELECT 
        s.StudentID,
        s.Date,
        s.TotalSubjects,
        COALESCE(p.PresentSubjects, 0) AS PresentSubjects,
        CASE 
            WHEN COALESCE(p.PresentSubjects, 0) = s.TotalSubjects THEN 1 
            ELSE 0 
        END AS IsPresentDay
    FROM SubjectCountPerStudent s
    LEFT JOIN PresentCountPerStudent p 
        ON s.StudentID = p.StudentID AND s.Date = p.Date
)
SELECT
    StudentID,
    COUNT(CASE WHEN IsPresentDay = 1 THEN 1 END) AS Total_Present_Days,
    COUNT(CASE WHEN IsPresentDay = 0 THEN 1 END) AS Total_Absent_Days
FROM DayWiseAttendance
GROUP BY StudentID
ORDER BY StudentID;

-- Q.3 Retrieve all students who have less than 75% attendance.

WITH StudentSubjectsPerDay AS (
    SELECT StudentID, Date, COUNT(*) AS TotalSubjects
    FROM Attendance
    GROUP BY StudentID, Date
),
PresentSubjectsPerDay AS (
    SELECT StudentID, Date, COUNT(*) AS PresentSubjects
    FROM Attendance
    WHERE Status = 'Present'
    GROUP BY StudentID, Date
),
Merged AS (
    SELECT
        s.StudentID,
        s.Date,
        s.TotalSubjects,
        COALESCE(p.PresentSubjects, 0) AS PresentSubjects
    FROM StudentSubjectsPerDay s
    LEFT JOIN PresentSubjectsPerDay p
    ON s.StudentID = p.StudentID AND s.Date = p.Date
),
FinalStatus AS (
    SELECT
        StudentID,
        Date,
        CASE
            WHEN TotalSubjects = PresentSubjects THEN 'Present'
            ELSE 'Absent'
        END AS DayStatus
    FROM Merged
),
StudentAttendanceSummary AS (
    SELECT
        StudentID,
        COUNT(*) AS TotalDays,
        SUM(CASE WHEN DayStatus = 'Present' THEN 1 ELSE 0 END) AS PresentDays
    FROM FinalStatus
    GROUP BY StudentID
)
SELECT 
    s.StudentID,
    st.Name,
    ROUND(PresentDays * 100.0 / TotalDays, 2) AS AttendancePercentage
FROM StudentAttendanceSummary s
JOIN Students st ON s.StudentID = st.StudentID
WHERE (PresentDays * 100.0 / TotalDays) < 75
ORDER BY AttendancePercentage ASC;

-- Q.4 Insert a new attendance record.
INSERT INTO Attendance (AttendanceID, StudentID, SubjectID, Date, Status)
VALUES (62, 1, 101, '2025-03-29', 'Absent'); 

-- Q.5 Generate a monthly attendance report.
--Subjectwise:
SELECT 
    S.Name,
    Sub.SubjectName,
    EXTRACT(MONTH FROM A.Date) AS Month,
    SUM(CASE WHEN A.Status = 'Present' THEN 1 ELSE 0 END) AS Presents,
    SUM(CASE WHEN A.Status = 'Absent' THEN 1 ELSE 0 END) AS Absents,
    ROUND(SUM(CASE WHEN A.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
FROM Attendance A
JOIN Students S ON A.StudentID = S.StudentID
JOIN Subjects Sub ON A.SubjectID = Sub.SubjectID
GROUP BY S.Name, Sub.SubjectName, EXTRACT(MONTH FROM A.Date)
ORDER BY Month, S.Name;


-- Q.6 Identify students with the highest attendance.
WITH StudentAttendance AS (
    SELECT
        a.StudentID,
        s.Name,
        COUNT(*) AS TotalClasses,
        SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS PresentCount,
        ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
    FROM Attendance a
    JOIN Students s ON a.StudentID = s.StudentID
    GROUP BY a.StudentID, s.Name
),
MaxAttendance AS (
    SELECT MAX(AttendancePercentage) AS MaxPercentage
    FROM StudentAttendance
)
SELECT sa.*
FROM StudentAttendance sa
JOIN MaxAttendance ma ON sa.AttendancePercentage = ma.MaxPercentage;

-- Q.7 Retrieve attendance percentage by subject.
SELECT
    a.StudentID,
    s.Name AS StudentName,
    a.SubjectID,
    subj.SubjectName,
    ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
JOIN Subjects subj ON a.SubjectID = subj.SubjectID
GROUP BY a.StudentID, s.Name, a.SubjectID, subj.SubjectName
ORDER BY a.StudentID, a.SubjectID;

-- Q.8 List students with more than 3 consecutive absences.
WITH Ranked AS (
    SELECT 
        A.StudentID, 
        A.Date,
        A.Status,
        ROW_NUMBER() OVER (PARTITION BY A.StudentID ORDER BY A.Date) AS rn_all,
        ROW_NUMBER() OVER (PARTITION BY A.StudentID, A.Status ORDER BY A.Date) AS rn_status
    FROM Attendance A
),
Grouped AS (
    SELECT 
        StudentID,
        Date,
        Status,
        rn_all - rn_status AS grp
    FROM Ranked
)
SELECT DISTINCT S.StudentID, S.Name
FROM Grouped G
JOIN Students S ON G.StudentID = S.StudentID
WHERE G.Status = 'Absent'
GROUP BY G.StudentID, G.grp, S.Name
HAVING COUNT(*) > 3;

-- Q.9 Fetch subjects with the lowest attendance rate.
-- The procedure is written in create_procedures.sql file

CALL GetLowestAttendanceSubject();

-- 10.Calculate the average attendance percentage of each course.
SELECT 
    s.Course,
    ROUND(AVG(student_attendance.AttendancePercentage), 2) AS AverageAttendancePercentage
FROM (
    SELECT 
        a.StudentID,
        ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
    FROM Attendance a
    GROUP BY a.StudentID
) AS student_attendance
JOIN Students s ON student_attendance.StudentID = s.StudentID
GROUP BY s.Course;
