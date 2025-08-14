-- Task 4 - Project: Movie Rental Analysis System
-- create database
-- CREATE DATABASE MovieRental;
-- USE MovieRental;

CREATE TABLE rental_data (
    MOVIE_ID INT,
    CUSTOMER_ID INT,
    GENRE VARCHAR(50),
    RENTAL_DATE DATE,
    RETURN_DATE DATE,
    RENTAL_FEE DECIMAL(6,2)
);

INSERT INTO rental_data (MOVIE_ID, CUSTOMER_ID, GENRE, RENTAL_DATE, RETURN_DATE, RENTAL_FEE)
VALUES
(101, 1, 'Action', '2025-07-01', '2025-07-03', 5.99),
(102, 2, 'Drama', '2025-06-15', '2025-06-17', 4.50),
(103, 3, 'Comedy', '2025-05-10', '2025-05-12', 3.99),
(101, 4, 'Action', '2025-07-05', '2025-07-07', 5.99),
(104, 5, 'Horror', '2025-06-01', '2025-06-03', 4.99),
(105, 2, 'Drama', '2025-07-20', '2025-07-22', 4.75),
(106, 1, 'Comedy', '2025-04-15', '2025-04-17', 3.50),
(107, 3, 'Action', '2025-07-25', '2025-07-26', 6.50),
(108, 4, 'Sci-Fi', '2025-06-10', '2025-06-12', 5.00),
(109, 5, 'Action', '2025-05-05', '2025-05-07', 5.99),
(110, 1, 'Drama', '2025-07-30', '2025-08-01', 4.25),
(111, 2, 'Action', '2025-08-01', '2025-08-03', 6.25);

-- OLAP Operations:
-- a) Drill Down: Analyze rentals from genre to individual movie level.
SELECT GENRE, MOVIE_ID, COUNT(*) AS rental_count
FROM rental_data
GROUP BY GENRE, MOVIE_ID
ORDER BY GENRE, MOVIE_ID;

-- b) Rollup: Summarize total rental fees by genre and then overall.
SELECT GENRE, sum(RENTAL_FEE) AS rental_count
FROM rental_data
GROUP BY GENRE WITH ROLLUP;

-- c) Cube: Analyze total rental fees across combinations of genre, rental date, and customer.
SELECT
  GENRE,
  RENTAL_DATE,
  CUSTOMER_ID,
  SUM(RENTAL_FEE) AS total_fee
FROM rental_data
GROUP BY
  GENRE, RENTAL_DATE, CUSTOMER_ID
WITH ROLLUP;

-- d) Slice: Extract rentals only from the ‘Action’ genre.
SELECT *
FROM rental_data
WHERE GENRE = 'Action';

-- e) Dice: Extract rentals where GENRE = 'Action' or 'Drama' and RENTAL_DATE is in the last 3 months
SELECT *
FROM rental_data
WHERE GENRE IN ('Action', 'Drama')
  AND RENTAL_DATE >= DATE_ADD(current_date, INTERVAL -3 MONTH);