# College Attendance Management System

## Project Details
- **Group:** 17  
- **Roll Numbers:** 81–85  
- **Course:** Database Management Systems (DBMS)  
- **Project Title:** College Attendance Management System  

---

## About the Project

This project is a **College Attendance Management System** built using MySQL. It is designed to maintain attendance records of students across various subjects in a college environment. The system allows tracking of student-wise and subject-wise attendance, and generates useful reports such as defaulter lists and subject-wise attendance analysis.

---

## Virtual Database Environment

We used the **MySQL Command Line Client** for database development and testing. This virtual environment allowed us to:

- Test queries safely without affecting live data  
- Quickly reset and rerun our scripts  
- Ensure consistent database structure across all group members  
- View results instantly to aid debugging and development

---

## Database Structure

The system consists of three main tables:

### Students
- `StudentID` (Primary Key)  
- `Name`  
- `RollNumber`  
- `Course`  

### Subjects
- `SubjectID` (Primary Key)  
- `SubjectName`  
- `TeacherID`  

### Attendance
- `AttendanceID` (Primary Key)  
- `StudentID` (Foreign Key)  
- `SubjectID` (Foreign Key)  
- `Date`  
- `Status` (`Present` or `Absent`)  

---

## Project Directory Structure
```
College_Attendance_System/
├── SQL_Scripts/
│   ├── create_tables.sql    # Creates the database structure
│   ├── insert_data.sql      # Adds sample data
│   └── queries.sql          # Contains all our required queries
|   └── stored_procedures.sql #For lowest attendance
|   └── triggers.sql #To stop  insertion
├── Reports/
│   └── Project_Report.docx
├── Screenshots/
│   ├── (Image file of the output of each queries)
└── README.md
```

## Features Implemented

All features were implemented as SQL queries or procedures:

-  Fetch attendance records for a student  
-  Count total present and absent days  
-  Identify students with <75% attendance  
-  Add new attendance records  
-  Monthly attendance reports  
-  Students with the highest attendance  
-  Subject-wise attendance percentages  
-  Students with more than 3 consecutive absences  
-  Subjects with lowest average attendance  
-  Average attendance percentage for each course  

---

## How to Run the Project

To set up and run the project locally:

```sql
-- Step 1: Open MySQL Command Line Client
mysql -u <your_username> -p

-- Step 2: Create and use the database
CREATE DATABASE attendance_system;
USE attendance_system;

-- Step 3: Execute the following scripts in order
SOURCE SQL_Scripts/create_tables.sql;
SOURCE SQL_Scripts/insert_data.sql;
SOURCE SQL_Scripts/queries.sql;
SOURCE SQL_Scripts/stored_procedures.sql;
SOURCE SQL_Scripts/triggers.sql;
```
## Note
This is our submission for the DBMS course project. We've implemented everything using MySQL Command Line Client as our virtual database environment.
