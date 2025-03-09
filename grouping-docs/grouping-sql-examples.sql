use TheFirstDatabase;

CREATE TABLE visit (
    id INT IDENTITY(1,1) PRIMARY KEY,
    visit_date DATE,
    price MONEY,
    duration INT
);

INSERT INTO visit (visit_date, price, duration) 
VALUES 
    ('2020-05-01', 150.00, 60),
    ('2020-05-01', 200.50, 90),
    ('2020-05-06', 120.75, 45),
    ('2024-05-06', 180.00, 75);


-- QUESTION 1) Calculate the number of visitors for each visit date.

SELECT visit_date as "Visit date", COUNT(1) as "Number of visitors"
FROM visit 
GROUP BY visit_date;

-- QUESTION 2) Calculate the average price of visits for each year and month.

SELECT
  YEAR(visit_date) AS year,
  MONTH(visit_date) AS month,
  ROUND(AVG(price), 2) AS avg_price
FROM visit
GROUP BY
  YEAR(visit_date),
  MONTH(visit_date);

-- QUESTION 3) Calculate the average duration of visits for each year and month.

SELECT
  YEAR(visit_date) AS year,
  MONTH(visit_date) AS month,
  ROUND(AVG(duration), 2) AS avg_duration
FROM visit
GROUP BY
  YEAR(visit_date),
  MONTH(visit_date)
ORDER BY
  YEAR(visit_date),
  MONTH(visit_date);


/*	QUESTION 4)
	Calculate the average price of visits for each date, but only show dates where more than 3 visits were made.
*/

SELECT
  visit_date,
  ROUND(AVG(price), 2) AS avg_price
FROM visit
GROUP BY visit_date
HAVING COUNT(*) > 3
ORDER BY visit_date;


/*	QUESTION 5)
	Calculate the average duration of visits where the duration is greater than 5 for each date, 
	but only show dates where more than 3 visits were made.
*/
SELECT
  visit_date,
  ROUND(AVG(duration), 2) AS avg_duration
FROM visit
WHERE duration > 5
GROUP BY visit_date
HAVING COUNT(*) > 3
ORDER BY visit_date;


