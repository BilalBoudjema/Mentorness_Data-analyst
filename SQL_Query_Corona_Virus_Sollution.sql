-- 1. Total number of rows containing NULL values in different columns
SELECT COUNT(*) as Total_of_null_rows
FROM dbo.[Corona Virus Dataset]
WHERE Province IS NULL
   OR Country_Region IS NULL
   OR Latitude IS NULL
   OR Longitude IS NULL
   OR Date IS NULL
   OR Confirmed IS NULL
   OR Deaths IS NULL
   OR Recovered IS NULL;

-- 3. Total number of rows in the dataset
SELECT COUNT(*) as Total_number_of_rows
FROM dbo.[Corona Virus Dataset];

-- 4. Start and end dates of the dataset
SELECT MIN(Date) as start_date, MAX(Date) as end_date
FROM dbo.[Corona Virus Dataset];

-- 5. Number of months present in the dataset
SELECT COUNT(DISTINCT MONTH(Date)) as number_of_month_present_inTheDataset;

-- 5.1. Occurrence of each month
SELECT DISTINCT MONTH(Date) as number_of_month_present_inTheDataset
FROM dbo.[Corona Virus Dataset];

-- 6. Monthly average of confirmed, deaths, and recovered cases
SELECT MONTH(Date) as Month, AVG(Confirmed) as Average_Confirmed, AVG(Deaths) as Average_Deaths, AVG(Recovered) as Average_Recovered
FROM dbo.[Corona Virus Dataset]
GROUP BY MONTH(Date)
ORDER BY Month;

-- 7. Most frequent values for confirmed, deaths, and recovered each month
SELECT MONTH(Date), MAX(Confirmed) as most_frequent_Confirmed, MAX(Deaths) as most_frequent_Deaths, MAX(Recovered) as most_frequent_Recovered
FROM [Corona Virus Dataset]
GROUP BY MONTH(Date)
ORDER BY MONTH(Date);

-- 8. Minimum values for confirmed, deaths, and recovered per year
SELECT YEAR(Date) as year, MIN(Confirmed) as min_frequent_Confirmed, MIN(Deaths) as min_frequent_Deaths, MIN(Recovered) as min_frequent_Recovered
FROM [Corona Virus Dataset]
GROUP BY YEAR(Date)
ORDER BY year;

-- 9. Maximum values for confirmed, deaths, and recovered per year
SELECT YEAR(Date) as year, MAX(Confirmed) as MAX_frequent_Confirmed, MAX(Deaths) as MAX_frequent_Deaths, MAX(Recovered) as MAX_frequent_Recovered
FROM [Corona Virus Dataset]
GROUP BY YEAR(Date)
ORDER BY year;

-- 10. Total number of confirmed, deaths, and recovered cases each month
SELECT YEAR(Date) as year, MONTH(Date) as month, SUM(Confirmed) as total_frequent_Confirmed, SUM(Deaths) as total_frequent_Deaths, SUM(Recovered) as total_frequent_Recovered
FROM [Corona Virus Dataset]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY YEAR(Date), MONTH(Date);

-- 11. Check how coronavirus spread out with respect to confirmed cases (e.g., total confirmed cases, their average, variance, & STDEV)
SELECT SUM(Confirmed) AS Total_Confirmed_Cases,
    AVG(Confirmed) AS Average_Confirmed_Cases,
    VAR(Confirmed) AS Confirmed_Cases_Variance,
    STDEV(Confirmed) AS Confirmed_Cases_Standard_Deviation
FROM [Corona Virus Dataset];

-- 12. Check how coronavirus spread out with respect to death cases per month (e.g., total confirmed cases, their average, variance, & STDEV)
SELECT YEAR(Date) AS year,
       MONTH(Date) AS month,
       SUM(Deaths) AS total_death_cases,
       AVG(Deaths) AS average_death_cases,
       VAR(Deaths) AS death_cases_variance,
       STDEV(Deaths) AS death_cases_standard_deviation
FROM [Corona Virus Dataset]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY YEAR(Date), MONTH(Date);

-- 13. Check how coronavirus spread out with respect to recovered cases per month (e.g., total confirmed cases, their average, variance, & STDEV)
SELECT YEAR(Date) AS year,
       MONTH(Date) AS month,
       SUM(Recovered) AS total_recovered_cases,
       AVG(Recovered) AS average_recovered_cases,
       VAR(Recovered) AS recovered_cases_variance,
       STDEV(Recovered) AS recovered_cases_standard_deviation
FROM [Corona Virus Dataset]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY YEAR(Date), MONTH(Date);

-- 14. Find Country having highest number of confirmed cases
SELECT Country_Region as Country, Confirmed as confirmed_cases
FROM [Corona Virus Dataset]
WHERE Confirmed = (SELECT MAX(Confirmed) FROM [Corona Virus Dataset]);

-- 15. Find Country having lowest number of death cases
WITH CountryDeaths AS (
    SELECT
        Country_Region AS Country,
        SUM(Deaths) AS TotalDeaths
    FROM
        [Corona Virus Dataset]
    GROUP BY
        Country_Region
)
SELECT
    Country,
    TotalDeaths
FROM
    CountryDeaths
WHERE
    TotalDeaths = (SELECT MIN(TotalDeaths) FROM CountryDeaths);

-- 16. Find top 5 countries having highest recovered cases
SELECT TOP 5 Country_Region as Country, SUM(Recovered)  as highest_recovered_cases
FROM [Corona Virus Dataset]
GROUP BY Country_Region
ORDER BY SUM(Recovered)  DESC;