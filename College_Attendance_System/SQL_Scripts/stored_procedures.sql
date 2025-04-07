-- Q.9 Procedure stored to execute required query
DELIMITER $$

CREATE PROCEDURE GetLowestAttendanceSubject()
BEGIN
    SELECT 
        a.SubjectID,
        s.SubjectName,
        ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttendancePercentage
    FROM Attendance a
    JOIN Subjects s ON a.SubjectID = s.SubjectID
    GROUP BY a.SubjectID, s.SubjectName
    ORDER BY AttendancePercentage ASC
    LIMIT 1;
END$$

DELIMITER ;
