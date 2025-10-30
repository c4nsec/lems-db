-- LEMS (SQL Server / Azure SQL)
IF DB_ID('lems') IS NULL CREATE DATABASE lems;
GO
USE lems;
GO

IF OBJECT_ID('Registration') IS NOT NULL DROP TABLE Registration;
IF OBJECT_ID('Loan') IS NOT NULL DROP TABLE Loan;
IF OBJECT_ID('Event') IS NOT NULL DROP TABLE Event;
IF OBJECT_ID('Book') IS NOT NULL DROP TABLE Book;
IF OBJECT_ID('Member') IS NOT NULL DROP TABLE Member;

CREATE TABLE Member (
  member_id   INT PRIMARY KEY,
  full_name   NVARCHAR(100) NOT NULL,
  email       NVARCHAR(120) NOT NULL UNIQUE,
  member_type NVARCHAR(20)  NOT NULL
    CHECK (member_type IN (N'student', N'external')),
  join_date   DATE NOT NULL
);

CREATE TABLE Book (
  book_id  INT PRIMARY KEY,
  title    NVARCHAR(150) NOT NULL,
  author   NVARCHAR(100) NOT NULL,
  category NVARCHAR(50)  NOT NULL,
  isbn     NVARCHAR(20)  NOT NULL UNIQUE,
  copies   INT NOT NULL CHECK (copies >= 0)
);

CREATE TABLE Event (
  event_id   INT PRIMARY KEY,
  title      NVARCHAR(150) NOT NULL,
  event_date DATE NOT NULL,
  start_time TIME(0) NOT NULL,
  end_time   TIME(0) NOT NULL,
  location   NVARCHAR(80) NOT NULL,
  CHECK (start_time < end_time)
);

CREATE TABLE Loan (
  loan_id     INT PRIMARY KEY,
  member_id   INT NOT NULL,
  book_id     INT NOT NULL,
  loan_date   DATE NOT NULL,
  due_date    DATE NOT NULL,
  return_date DATE NULL,
  CONSTRAINT FK_Loan_Member FOREIGN KEY (member_id) REFERENCES Member(member_id),
  CONSTRAINT FK_Loan_Book   FOREIGN KEY (book_id)   REFERENCES Book(book_id),
  CONSTRAINT UQ_Loan UNIQUE (member_id, book_id, loan_date),
  CONSTRAINT CK_Loan_Dates CHECK (due_date > loan_date)
);

CREATE TABLE Registration (
  event_id      INT NOT NULL,
  member_id     INT NOT NULL,
  registered_at DATETIME2(0) NOT NULL,
  CONSTRAINT PK_Registration PRIMARY KEY (event_id, member_id),
  CONSTRAINT FK_Reg_Event  FOREIGN KEY (event_id)  REFERENCES Event(event_id),
  CONSTRAINT FK_Reg_Member FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Member VALUES
(1001,N'Alice Kaya',N'alice.kaya@uni.edu',N'student','2025-09-01'),
(1002,N'Berk Yilmaz',N'berk.yilmaz@uni.edu',N'student','2025-09-03'),
(1003,N'Ceren Aydin',N'ceren.aydin@uni.edu',N'student','2025-09-05'),
(1004,N'Deniz Arslan',N'deniz.arslan@uni.edu',N'student','2025-09-06'),
(1005,N'Efe Demir',N'efe.demir@uni.edu',N'student','2025-09-07'),
(1006,N'Fatma Soylu',N'fatma.soylu@mail.com',N'external','2025-09-10'),
(1007,N'Gokhan Cetin',N'gokhan.cetin@mail.com',N'external','2025-09-12'),
(1008,N'Hale Ucar',N'hale.ucar@uni.edu',N'student','2025-09-15'),
(1009,N'Ipek Korkmaz',N'ipek.korkmaz@mail.com',N'external','2025-09-18'),
(1010,N'Kerem Oz',N'kerem.oz@uni.edu',N'student','2025-09-20');

INSERT INTO Book VALUES
(2001,N'Database System Concepts',N'Silberschatz',N'CS',N'97812600818',5),
(2002,N'Introduction to Algorithms',N'Cormen',N'CS',N'97802620428',3),
(2003,N'Clean Code',N'Robert C. Martin',N'CS',N'97801323508',4),
(2004,N'The Pragmatic Programmer',N'Andrew Hunt',N'CS',N'97802016162',2),
(2005,N'Design Patterns',N'Gamma et al.',N'CS',N'97802016336',3),
(2006,N'Deep Work',N'Cal Newport',N'Productivity',N'97814555866',2),
(2007,N'Atomic Habits',N'James Clear',N'Productivity',N'97807352112',6),
(2008,N'Sapiens',N'Yuval Noah Harari',N'History',N'97800623161',4),
(2009,N'1984',N'George Orwell',N'Fiction',N'97804515249',5),
(2010,N'To Kill a Mockingbird',N'Harper Lee',N'Fiction',N'97800611200',3);

INSERT INTO Event VALUES
(3001,N'Author Talk: Clean Code','2025-10-25','14:00','15:30',N'FENS G077'),
(3002,N'Research Skills Workshop','2025-10-28','10:00','12:00',N'FMAN G071'),
(3003,N'AI Ethics Panel','2025-11-02','16:00','17:30',N'FASS Auditorium'),
(3004,N'Data Modeling 101','2025-11-05','11:00','12:30',N'FENS G077'),
(3005,N'Career Talk: Tech CVs','2025-11-08','09:30','10:45',N'UC Cinema'),
(3006,N'Book Club: Sapiens','2025-11-12','13:00','14:30',N'Library Room 1'),
(3007,N'Query Optimization Clinic','2025-11-15','10:00','11:30',N'FENS G050'),
(3008,N'Time Management Tips','2025-11-18','15:00','16:00',N'FMAN G071'),
(3009,N'Open Source Meetup','2025-11-20','18:00','19:30',N'FASS Hall'),
(3010,N'Cybersecurity Basics','2025-11-22','10:00','11:30',N'FENS G077');

INSERT INTO Loan VALUES
(4001,1001,2001,'2025-10-01','2025-10-15',NULL),
(4002,1002,2003,'2025-10-02','2025-10-16','2025-10-14'),
(4003,1003,2002,'2025-10-03','2025-10-17',NULL),
(4004,1004,2007,'2025-10-04','2025-10-18','2025-10-10'),
(4005,1005,2005,'2025-10-05','2025-10-19',NULL),
(4006,1006,2008,'2025-10-06','2025-10-20',NULL),
(4007,1007,2009,'2025-10-07','2025-10-21',NULL),
(4008,1008,2010,'2025-10-08','2025-10-22','2025-10-20'),
(4009,1009,2004,'2025-10-09','2025-10-23',NULL),
(4010,1010,2006,'2025-10-10','2025-10-24',NULL);

INSERT INTO Registration VALUES
(3001,1001,'2025-10-20T09:10:00'),
(3002,1002,'2025-10-21T14:05:00'),
(3003,1003,'2025-10-22T10:30:00'),
(3004,1004,'2025-10-22T11:15:00'),
(3005,1005,'2025-10-22T12:20:00'),
(3006,1006,'2025-10-22T12:45:00'),
(3007,1007,'2025-10-22T13:05:00'),
(3008,1008,'2025-10-22T13:25:00'),
(3009,1009,'2025-10-22T13:40:00'),
(3010,1010,'2025-10-22T14:00:00');
