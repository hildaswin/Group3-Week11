CREATE DATABASE Group3_Database;
GO

use Group3_Database;
GO

CREATE TABLE Room(RoomId INT NOT NULL PRIMARY KEY);
GO

CREATE TABLE WeekDay(WeekDayId VARCHAR(9) NOT NULL PRIMARY KEY);
GO

CREATE TABLE Student(
   StudentId INT IDENTITY NOT NULL PRIMARY KEY,
   StudentFirstName VARCHAR(20) NOT NULL,
   StudentMiddleName VARCHAR(20) NOT NULL DEFAULT 'N/A',
   StudentLastName VARCHAR(20) NOT NULL,
   StudentPhone VARCHAR(10) NOT NULL,
   StudentEmail VARCHAR(40) NOT NULL
);
GO

CREATE TABLE Instructor(
   InstructorId INT IDENTITY NOT NULL PRIMARY KEY,
   InstructorFirstName VARCHAR(20) NOT NULL,
   InstructorMiddleName VARCHAR(20) NOT NULL DEFAULT 'N/A',
   InstructorLastName VARCHAR(20) NOT NULL,
   InstructorEMPStatus VARCHAR(10) NOT NULL,
   InstructorPhone VARCHAR(10) NOT NULL,
   InstructorEmail VARCHAR(40) NOT NULL
);
GO

CREATE TABLE Subject(
   SubjectId INT IDENTITY NOT NULL PRIMARY KEY,
   SubjectName VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Course(
   CourseId INT IDENTITY NOT NULL PRIMARY KEY,
   CourseName VARCHAR(20) NOT NULL,
   CourseDescription TEXT NOT NULL,
   CourseCredits TINYINT NOT NULL,
   SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subject(SubjectId)
);
GO

CREATE TABLE ClassTable(
   ClassId INT IDENTITY NOT NULL PRIMARY KEY,
   CourseId INT NOT NULL FOREIGN KEY REFERENCES Course(CourseId),
   InstructorId INT NOT NULL FOREIGN KEY REFERENCES Instructor(InstructorId),
   ClassMaxSize INT NOT NULL DEFAULT 32,
   RoomId INT NOT NULL FOREIGN KEY REFERENCES Room(RoomId),
   ClassStartDate DATE NOT NULL,
   ClassEndDate DATE NOT NULL,
   ClassWithdrawEndDate DATE NOT NULL,
   ClassDropEndDate DATE NOT NULL
);
GO

CREATE TABLE ClassSchedule(
   ClassId INT NOT NULL FOREIGN KEY REFERENCES ClassTable(ClassId),
   WeekDayId VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES WeekDay(WeekDayId),
   ClassSchTime Time NOT NULL,
   PRIMARY KEY (ClassId, WeekDayId)
);
GO

CREATE TABLE Status(
   ClassStatusCode CHAR(3) NOT NULL PRIMARY KEY,
   StatusName VARCHAR(10) NOT NULL,
   StatusDescription TEXT NOT NULL
);
GO

CREATE TABLE StudentClass(
   ClassId INT NOT NULL FOREIGN KEY REFERENCES ClassTable(ClassId),
   StudentId INT NOT NULL FOREIGN KEY REFERENCES Student(StudentId),
   StudClassGrade CHAR(1),
   ClassStatusCode CHAR(3),
   PRIMARY KEY (ClassId, StudentId)
);
GO

use Group3_Database;
GO

INSERT INTO Room(RoomId)
VALUES (101),
	   (102),
	   (103),
	   (104),
	   (105),
	   (106);
GO

INSERT INTO WeekDay(WeekDayId)
VALUES ('Mon'),
	   ('Tue'),
	   ('Wed'),
	   ('Thurs'),
	   ('Fri');
GO

INSERT INTO Student(StudentFirstName, StudentMiddleName, StudentLastName, StudentPhone, StudentEmail)
VALUES ('Joe', 'Scott', 'Rose', '000-0000', 'email@email.com'),
       ('Mary', 'Justin', 'Chuck', '000-0000', 'email@email.com'),
	   ('Ethan', 'Huston', 'Kim', '000-0000', 'email@email.com'),
	   ('Chris', 'Michael', 'Lynn', '000-0000', 'email@email.com'),
	   ('Cassidy', 'Max', 'Wrin', '000-0000', 'email@email.com');
GO

INSERT INTO Instructor(InstructorFirstName,InstructorMiddleName, InstructorLastName, InstructorEMPStatus, InstructorPhone, InstructorEmail)
VALUES ('Kim', 'Wes', 'Lynn', 'True', '000-0000', 'email@email.com'),
	   ('Mary', DEFAULT, 'Scott', 'True', '000-0000', 'email@email.com'),
	   ('Denise', 'Paula', 'King', 'True', '000-0000', 'email@email.com'),
	   ('Patrick', 'Wood', 'Griffin', 'True', '000-0000', 'email@email.com'),
	   ('Aaron', 'Parker', 'Garcia', 'True', '000-0000', 'email@email.com');
GO

INSERT INTO Subject(SubjectName)
VALUES ('Math'),
       ('Science'),
	   ('English'),
	   ('History'),
	   ('Engineering');
GO

INSERT INTO Course(CourseName, CourseDescription, CourseCredits, SubjectId)
VALUES ('Intro to Algebra', 'Starting algebra course', 3, 1),
       ('Biology I', 'Introduction to biology', 4, 2),
	   ('Western Civilization', 'Introduction to Western Civ', 3, 4),
	   ('Metalworking I', 'Introduction to Metalworking', 4, 5),
	   ('Speech', 'Introductory to Speech', 4, 3);
GO

INSERT INTO ClassTable(CourseId, InstructorId, ClassMaxSize, RoomId, ClassStartDate, ClassEndDate, ClassWithdrawEndDate, ClassDropEndDate)
VALUES (1, 4, 25, 101, '2023-08-24', '2023-12-23', '2023-12-01', '2023-08-27'),
       (2, 1, 25, 105, '2023-08-24', '2023-12-23', '2023-12-01', '2023-08-27'),
	   (4, 2, 15, 106, '2023-08-24', '2023-12-23', '2023-12-01', '2023-08-27'),
	   (5, 5, 25, 104, '2023-08-24', '2023-12-23', '2023-12-01', '2023-08-27'),
	   (3, 3, 25, 103, '2023-08-24', '2023-12-23', '2023-12-01', '2023-08-27');
GO

INSERT INTO ClassSchedule(ClassId, WeekDayId, ClassSchTime)
VALUES (1, 'Mon', '13:30'),
       (2, 'Thurs', '8:00'),
	   (3, 'Fri', '8:00'),
	   (4, 'Tue', '10:00'),
	   (5, 'Wed', '16:00');
GO

INSERT INTO Status(ClassStatusCode, StatusName, StatusDescription)
VALUES ('A01', 'Auth', 'Authorized'),
       ('UA1', 'UnAuth', 'UnAuthorized');
GO

INSERT INTO StudentClass(ClassId, StudentId, StudClassGrade, ClassStatusCode)
VALUES (1, 4, 'B', 'A01'),
	   (2, 5, 'B', 'A01'),
	   (3, 3, 'A', 'A01'),
	   (4, 2, 'C', 'A01'),
	   (5, 1, 'C', 'UA1');
GO
