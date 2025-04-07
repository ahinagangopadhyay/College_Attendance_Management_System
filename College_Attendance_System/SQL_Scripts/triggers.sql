-- Additionally this trigger can be implemented to show an error message everytime a new insertion is attempted if we want to prevent insertion
DELIMITER $$

CREATE TRIGGER NotifyNewAttendanceInsert
BEFORE INSERT ON Attendance
FOR EACH ROW
BEGIN
    DECLARE msg TEXT;

    SET msg = CONCAT('New attendance record cannot be inserted: StudentID ',
        CAST(NEW.StudentID AS CHAR), ', SubjectID ',
        CAST(NEW.SubjectID AS CHAR), ', Date ',
        CAST(NEW.Date AS CHAR));

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = msg;
END $$

DELIMITER ;

