.read lab11_data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = "blue" AND pet = "dog";


CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING COUNT(*) = 1;


CREATE TABLE matchmaker AS
  SELECT students_a.pet, students_a.song, students_a.color, students_b.color FROM 
  students AS students_a, students AS students_b WHERE
  students_a.time < students_b.time AND students_a.pet = students_b.pet AND
  students_a.song = students_b.song;


CREATE TABLE sevens AS
  SELECT seven FROM students, numbers WHERE students.time = numbers.time AND
  number = 7 AND "7" = "True";


CREATE TABLE avg_difference AS
  SELECT round(avg(abs(number - smallest))) FROM students;

