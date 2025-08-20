DROP TABLE IF EXISTS student;
CREATE TABLE student(
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(30) ,
admitted_date DATE);

INSERT INTO student(student_id,student_name,admitted_date) VALUES
(11, 'Ibrahim', '2012-10-01'),
(7, 'Taiwo', '2013-12-01'),
(9, 'Nurain', '2012-11-21'),
(8, 'Joel', '2012-10-31'),
(10, 'Mustapha', '2015-11-01'),
(5, 'Muritadoh', '2011-09-01'),
(2, 'Yusuf', '2022-05-03'),
(3, 'Habeebah', '2012-11-01'),
(1, 'Tomiwa', '2013-04-01'),
(4, 'Gbadebo', '2008-10-01'),
(12, 'Tolu', '2009-11-21');

select * from student;

SELECT CURRENT_DATE();


SELECT *,EXTRACT(YEAR FROM admitted_date) as "YEAR OF ADMISSION" FROM student;

SELECT MONTH(admitted_date) FROM student;

SELECT *,DATE_ADD(admitted_date, INTERVAL 3 DAY) AS "3 DAYS ADDED" FROM student;

SELECT*,DATE_SUB(admitted_date,INTERVAL 3 DAY) AS "3 DAYS SUBTRACTED" FROM student;

SELECT DATEDIFF("2017-06-25 09:34:21", "2017-06-15 15:25:35");

