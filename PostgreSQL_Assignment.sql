-- Active: 1760717065858@@127.0.0.1@5432@university_db
-- create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    AGE INT,
    email VARCHAR(100),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(20)
);


-- CREATE courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
    );


-- CREATE enrollments table
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
    );

-- INSERT sample data into students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES 
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

SELECT * FROM students;


--create courses table
INSERT INTO courses (course_name, credits) 
VALUES 
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

SELECT * FROM courses;

-- Insert sample data into enrollments table

INSERT INTO enrollments (student_id, course_id) 
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);

SELECT * FROM enrollments;


-- Query 1: Insert a new student record with my own details.
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES ('Mustakim Al Noman', 30, 'mustakimalnoman@gmail.com', 60, 60, NULL);

--Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM students AS s
JOIN enrollments AS e ON s.student_id = e.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';    

--Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

--Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollments
);

--Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

--Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM courses AS c
LEFT JOIN enrollments AS e ON c.course_id = e.course_id
GROUP BY c.course_name; 

--Query 7: Calculate and display the average age of all students.
SELECT AVG(age) AS average_age
FROM students;

--Query 8:Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';   


/* 

Question1.What is PostgreSQL?

Ans: PostgreSQL is an open-source relational database management system (RDBMS). It is designed to handle a wide range of workloads, from single-machine applications to large-scale data warehousing and web services.

Question2. What is the purpose of a database schema in PostgreSQL?

Ans: A database schema in PostgreSQL serves as a logical container for database objects such as tables, views, indexes, and functions.
Imagine a PostgreSQL schema is just like a folder on our computer.

We know how we have a 'Projects' folder, a 'Personal' folder, and a 'Work' folder to keep our files sorted? A schema does the same thing inside a database.

It groups related tables together, so we don't have one giant, messy list. This stops things from getting mixed up and makes it easier to find what we need.It lets us set permissions, so we can decide who gets to see what, just like sharing a link to only one specific folder.

Question3: Explain the primary key and foreign key concepts in PostgreSQL.

Ans:
Primary Key: A unique ID for each row in a table, like a social security number. No two rows can have the same one, and it can't be empty.

Foreign Key: A column in one table that points to the Primary Key in another table. It creates a link between the two tables, like using a customer's ID in an orders table to show who placed the order.

Question4: What is the difference between the VARCHAR and CHAR data types?

Ans:
VARCHAR: A flexible text box. If you define it as VARCHAR(100) and only store 5 characters, it only uses space for those 5.

CHAR: A fixed-size text box. If you define it as CHAR(100) and store 5 characters, it will pad the rest with spaces to always use 100 characters of space.

Question5: Explain the purpose of the WHERE clause in a SELECT statement.
Ans: TIt acts as a filter for my SELECT query. It lets us pick and choose which rows we want to see based on a condition, like WHERE age > 30.

Question6: What are the LIMIT and OFFSET clauses used for?

Ans: 
LIMIT: Lets us specify the maximum number of rows to get back. It's like saying "just show me the top 10 results."

OFFSET: Tells the database to skip a certain number of rows before starting to return results. It's used for pagination, like "skip the first 20 results, then show me the next 10.

Question7: How can you perform data modification using UPDATE statements?

Ans: We use the UPDATE statement to change existing data. We tell it which table, what new values to set, and use a WHERE clause to specify which exact rows to change. Without a WHERE clause, we will update every row in the table.

Question8: What is the significance of the JOIN operation, and how does it work in PostgreSQL?

Ans:
A JOIN combines rows from two or more tables based on a related column (usually a Foreign Key). It's how you answer questions that need data from multiple places at once, like "show me all orders along with the customer's name.

Question9: Explain the GROUP BY clause and its role in aggregation operations.

Ans: GROUP BY groups rows that have the same values into summary rows. It's the key to getting totals and summaries. For example, you can GROUP BY "department" to count how many employees are in each one. It's used with aggregation functions (like COUNT, SUM, AVG) to perform calculations on each group.

Question10: How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?

Ans: 
These are summary functions you use with GROUP BY:

COUNT(): Counts the number of rows.
SUM(): Adds up the values in a column.
AVG(): Calculates the average value of a column.

Question11: What is the purpose of an index in PostgreSQL, and how does it optimize query performance?

Ans: 
An index is like the index at the back of a textbook. It helps the database find data super fast without having to scan every single page (or row) of a table. This dramatically speeds up search queries.

Question12: Explain the concept of a PostgreSQL view and how it differs from a table.
Ans: 
Table: Actually stores the data on disk.

View: A saved, virtual table defined by a SELECT query. It doesn't store data itself; it just shows us a specific view of the data that's already in the tables. It's useful for simplifying complex queries or hiding sensitive columns.




*/