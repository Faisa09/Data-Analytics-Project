-- Checking the data is correct 
SELECT * 
FROM faisa.sql_project;

-- Checking that it is the correct number of rows
SELECT count(*)
 FROM faisa.sql_project;
 
 -- Find top 5 countries with the highest infant deaths in Year 2015
 SELECT country, infant_deaths, status 
 FROM faisa.sql_project
 WHERE year = 2015
 ORDER BY infant_deaths DESC
 LIMIT 10;

-- Find top 5 countries with lowest infant deaths in Year 2015
SELECT country, infant_deaths, status 
 FROM sql_project
 WHERE year = 2015 
 ORDER BY infant_deaths ASC
 LIMIT 10;

 -- Finding the sum of infant deaths as a total from 2000-2015 for developed countries
SELECT sum(infant_deaths)
FROM faisa.sql_project
WHERE status = 'developed';
 
 -- Finding the sum of infant deaths as a total from 2000-2015 for developing countries
SELECT sum(infant_deaths)
FROM faisa.sql_project
WHERE status = 'developing'; 

-- What is the impact of measles on infant death- do countries with high infant death have high rates of measles infection?
-- show prercentage of measles in comparison to total number of  infant deaths
SELECT country, status, year, infant_deaths,(measles/ (SELECT sum(measles) FROM faisa.sql_project) * 100) AS '% of measles'
FROM faisa.sql_project
ORDER BY 5 DESC;

-- lets Look at adult mortalilty rate as an average comparing it between developed and developing countries
SELECT status, ROUND(AVG(adult_mortality),2) AS 'AVG Adult mortality'
FROM faisa.sql_project
GROUP BY status;

-- comparing the percentage of Adult mortality to of life expectancy 
-- this shows countries with low life expectanxy have high adult mortality %
SELECT country, life_expectancy, year, status, (adult_mortality / (SELECT SUM(adult_mortality) FROM faisa.sql_project) * 100) AS '% of Adult Mortality'
FROM faisa.sql_project
ORDER BY 5 DESC;


-- Find the average life expectancy in each country comparing it to the average life expectancy in 2015 
-- Top life expectancy was Slovenia at (88) and Lowest was Sierra Leone at (51)
SELECT country, ROUND(AVG(life_expectancy),2) AS 'Average_Life_Expectancy', 
(SELECT ROUND(AVG(life_expectancy),2)
FROM faisa.sql_project
WHERE year = 2015)
FROM faisa.sql_project
WHERE year = 2015
GROUP BY country
ORDER BY AVG(life_expectancy) DESC;


-- Finding the effect of BMI, alchol and HIV Aids on life expectancy in year 2000
-- Sierra Leone had the lowest life expectancy with high HIV rate.
-- Jappan highest life expectancy With low HIV rate but high alchol rate.
SELECT country, life_expectancy, HIV_AIDS, alcohol, 
CASE
WHEN bmi < 18.5 THEN 'Underweight'
WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Healthy'
WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obese'
ELSE 'Morbidly Obese'
END AS 'BMI Range'
FROM faisa.sql_project
WHERE year = 2000
ORDER BY 2 ASC;

-- Finding the effect of BMI, alchol and HIV Aids on life expectancy in year 2015
-- Sierra Leone stil has the lowest expectancy but now Slovenia has the highest life expectancy.
SELECT country, life_expectancy, HIV_AIDS, alcohol, 
CASE
WHEN bmi < 18.5 THEN 'Underweight'
WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Healthy'
WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obese'
ELSE 'Morbidly Obese'
END AS 'BMI Range'
FROM faisa.sql_project
WHERE year = 2015
ORDER BY 2 ASC;

-- interesting to find that Denmark has a high BMI levels despite having a high life expectancy in 2015
SELECT country, life_expectancy,BMI
FROM faisa.sql_project
WHERE country LIKE 'D%k';
