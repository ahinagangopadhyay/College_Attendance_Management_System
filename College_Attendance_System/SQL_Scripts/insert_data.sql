INSERT INTO Students (StudentID, Name, RollNumber, Course) VALUES
(1, 'Amisha Mehta', '81', 'CSE'),
(2, 'Tanya Nair', '82', 'CSE'),
(3, 'Adrika Das', '83', 'ECE'),
(4, 'Ishita Sen', '84', 'ECE'),
(5, 'Amit Roy', '85', 'CSE');

INSERT INTO Subjects (SubjectID, SubjectName, TeacherID) VALUES
(101, 'DBMS', 1001),
(102, 'Operating Systems', 1002),
(201, 'Signals and Systems', 1003),
(202, 'Digital Circuits', 1004);

INSERT INTO Attendance (AttendanceID, StudentID, SubjectID, Date, Status) VALUES
(1, 1, 101, '2025-02-05', 'Present'),
(2, 1, 102, '2025-02-05', 'Present'),
(3, 1, 101, '2025-02-15', 'Present'),
(4, 1, 102, '2025-02-20', 'Present'),
(5, 1, 101, '2025-03-01', 'Absent'),
(6, 1, 102, '2025-03-05', 'Present'),
(7, 1, 101, '2025-03-15', 'Present'),
(8, 1, 102, '2025-03-25', 'Present'),
(9, 1, 101, '2025-03-25', 'Present'),
(10, 1, 101, '2025-03-20', 'Present'),
(11, 1, 102, '2025-03-20', 'Present'),


(12, 2, 101, '2025-02-05', 'Present'),
(13, 2, 102, '2025-02-05', 'Absent'),
(14, 2, 101, '2025-02-15', 'Present'),
(15, 2, 102, '2025-02-20', 'Absent'),
(16, 2, 101, '2025-03-01', 'Present'),
(17, 2, 102, '2025-03-05', 'Present'),
(18, 2, 101, '2025-03-15', 'Absent'),
(19, 2, 102, '2025-03-25', 'Present'),
(20, 2, 101, '2025-03-25', 'Present'),
(21, 2, 101, '2025-03-20', 'Present'),
(22, 2, 102, '2025-03-20', 'Present'),


(23, 5, 101, '2025-02-05', 'Present'),
(24, 5, 102, '2025-02-05', 'Present'),
(25, 5, 101, '2025-02-15', 'Present'),
(26, 5, 102, '2025-02-20', 'Absent'),
(27, 5, 101, '2025-03-01', 'Present'),
(28, 5, 102, '2025-03-05', 'Present'),
(29, 5, 101, '2025-03-15', 'Absent'),
(30, 5, 102, '2025-03-25', 'Present'),
(31, 5, 101, '2025-03-25', 'Present'),
(32, 5, 101, '2025-03-20', 'Present'),
(33, 5, 102, '2025-03-20', 'Present'),


(34, 3, 201, '2025-02-06', 'Present'),
(35, 3, 202, '2025-02-11', 'Present'),
(36, 3, 201, '2025-02-21', 'Present'),
(37, 3, 202, '2025-03-02', 'Absent'),
(38, 3, 201, '2025-03-12', 'Present'),
(39, 3, 202, '2025-03-18', 'Present'),
(40, 3, 201, '2025-03-25', 'Present'),
(41, 3, 202, '2025-03-25', 'Present'),
(42, 3, 201, '2025-03-20', 'Present'),
(43, 3, 202, '2025-03-20', 'Present'),

(44, 4, 201, '2025-02-06', 'Present'),
(45, 4, 202, '2025-02-11', 'Absent'),
(46, 4, 201, '2025-02-21', 'Absent'),
(47, 4, 202, '2025-03-02', 'Present'),
(48, 4, 201, '2025-03-12', 'Present'),
(49, 4, 202, '2025-03-18', 'Absent'),
(50, 4, 201, '2025-03-25', 'Present'),
(51, 4, 202, '2025-03-25', 'Present'),
(52, 4, 201, '2025-03-20', 'Present'),
(53, 4, 202, '2025-03-20', 'Present'),


(54, 2, 101, '2025-03-27', 'Absent'),
(55, 2, 101, '2025-03-28', 'Absent'),
(56, 2, 101, '2025-03-29', 'Absent'),
(57, 2, 101, '2025-03-30', 'Absent'),

(58, 4, 202, '2025-03-26', 'Absent'),
(59, 4, 202, '2025-03-27', 'Absent'),
(60, 4, 202, '2025-03-28', 'Absent'),
(61, 4, 202, '2025-03-29', 'Absent');
