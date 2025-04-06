--Additionally this trigger can be implemented to show a message everytime a new insertion is done
--Q.4
    
DELIMITER $$

CREATE TRIGGER NotifyNewAttendanceInsert
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN
    DECLARE msg TEXT;
    SET msg = CONCAT(
        'New attendance record inserted: StudentID ',
        CAST(NEW.StudentID AS CHAR), ', SubjectID ',
        CAST(NEW.SubjectID AS CHAR), ', Date ',
        CAST(NEW.Date AS CHAR)
    );

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = msg;
END $$

DELIMITER ;
