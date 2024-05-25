CREATE DATABASE corona_virus

SELECT * FROM corona_virus_dataset

##Q1. Write a code to check NULL values

SELECT * FROM corona_virus_dataset WHERE province IS NULL;
SELECT * FROM corona_virus_dataset WHERE country_region IS NULL;
SELECT * FROM corona_virus_dataset WHERE latitude IS NULL;
SELECT * FROM corona_virus_dataset WHERE longitude IS NULL;
SELECT * FROM corona_virus_dataset WHERE date IS NULL;
SELECT * FROM corona_virus_dataset WHERE confirmed IS NULL;
SELECT * FROM corona_virus_dataset WHERE deaths IS NULL;
SELECT * FROM corona_virus_dataset WHERE  recovered IS NULL;

##Q2. If NULL values are present, update them with zeros for all columns.UPDATE your_table

update corona_virus_dataset
SET province = COALESCE(province, 0),
    country_region = COALESCE(country_region, 0),
    latitude = COALESCE(latitude, 0),
    longitude = COALESCE(longitude,0),
    DATE = COALESCE(DATE,0),
    confirmed = COALESCE(confirmed,0),
    deaths = COALESCE(deaths,0),
    recovered = COALESCE(recovered,0)
WHERE province IS NULL OR country_region IS NULL OR latitude 
      IS NULL OR longitude IS NULL OR DATE IS NULL OR confirmed 
		IS NULL OR deaths IS NULL OR recovered IS NULL;
		
-- Q3. check total number of rows

SELECT COUNT(*) as no_of_rows from corona_virus_dataset;
 
-- Q4. Check what is start_date and end_date

SELECT min(DATE) as start_date ,MAX(DATE) AS end_date FROM corona_virus_dataset 

-- Q5. Number of month present in dataset

SELECT count(distinct DATE_FORMAT(DATE,"%Y-%m")) AS no_of_month 
FROM corona_virus_dataset

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
   date_format(DATE,"%Y-%m") AS MONTH,
   round(AVG(confirmed),2) AS  avg_confirmed, 
	round(AVG(deaths),2) AS avg_deaths, 
	round(AVG(recovered),2) AS avg_recovered
FROM 
   corona_virus_dataset 
GROUP BY 
   DATE_FORMAT(DATE,"%Y-%m")

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    date_format(DATE,"%Y-%m") AS month,
    COUNT(*) AS frequency,
    MAX(confirmed) AS most_frequent_confirmed,
    MAX(deaths) AS most_frequent_deaths,
    MAX(recovered) AS most_frequent_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    MONTH(date);
    
-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    year(date) AS year,
    COUNT(*) AS frequency,
    min(confirmed) AS min_values_confirmed,
    min(deaths) AS min_values_deaths,
    min(recovered) AS min_values_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    year(date);
    
-- Q9. Find maximum values of confirmed, deaths, recovered per year 
  SELECT 
    year(date) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    year(date); 
    
-- Q10. The total number of case of confirmed, deaths, recovered each month
 SELECT 
    date_format(DATE,"%Y-%m") AS month,
    sum(confirmed) AS total_confirmed,
    sum(deaths) AS total_deaths,
    sum(recovered) AS total_recovered
FROM 
    corona_virus_dataset
GROUP BY 
    month(date); 
    
-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT SUM(confirmed) AS total_confirmed_cases,AVG(confirmed) AS average_confirmed_cases,
VARIANCE(confirmed) AS confirmed_cases_variance,
SQRT(VARIANCE(confirmed)) AS confirmed_cases_stdev
FROM corona_virus_dataset;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT date_format(DATE,"%Y-%m") AS month,SUM(deaths) AS total_confirmed_deaths_cases,AVG(deaths) AS average_deaths_cases,
VARIANCE(deaths) AS deaths_cases_variance,
SQRT(VARIANCE(deaths)) AS deaths_cases_stdev
FROM corona_virus_dataset GROUP BY MONTH(DATE)

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(recovered) AS total_recovered_cases,AVG(recovered) AS average_recovered_cases,
VARIANCE(recovered) AS recovered_cases_variance,
SQRT(VARIANCE(recovered)) AS recovered_cases_stdev
FROM corona_virus_dataset;

-- Q14. Find Country having highest number of the Confirmed case
SELECT province,confirmed FROM corona_virus_dataset ORDER BY confirmed DESC LIMIT 1;


-- Q15. Find Country having lowest number of the death case
SELECT province,deaths FROM corona_virus_dataset ORDER BY deaths ASC LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT province,recovered FROM corona_virus_dataset ORDER BY recovered DESC LIMIT 5;