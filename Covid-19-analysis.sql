SELECT *
FROM CovidDeaths
WHERE continent is not NULL

-- Looking at the GLOBAL NUMBERS BY COUNTRY

-- Percentage of Total Infected Population by Country

SELECT location, population, MAX(total_cases) as MaxTotalCasesCount, ROUND((MAX(total_cases)/population)*100,2) as PercentageTotalCase
FROM CovidDeaths
WHERE continent is not Null
GROUP BY location, population
ORDER BY 4 DESC


-- Number of Total Deaths by the Country

SELECT location, population, max(cast(total_deaths as int)) as MaxTotalDeaths
FROM CovidDeaths
WHERE continent is not Null
GROUP BY location, population
ORDER BY 3 DESC

-- Checking Total Case number over the date between 01/01/2020 and 06/07/2022 (dd/mm/yyyy)

SELECT location, date, total_cases
FROM CovidDeaths
WHERE continent is not NULL
ORDER BY 1,2


-- Checking Europe's number of total cases

SELECT location, date, MAX(total_cases) as MaxTotalCases, population
FROM CovidDeaths
WHERE continent = 'Europe'
GROUP BY location, date, population
ORDER BY 1,2


-- Checking continent's total cases the date given above

SELECT location, date, max(total_cases) as MaxTotalCases
FROM CovidDeaths
WHERE continent is NULL and location != 'World'
GROUP BY location, date
ORDER BY 2 DESC


-- Joining CovidVaccinations table on CovidDeaths using location and date

SELECT *
From CovidDeaths as dea
Inner Join CovidVaccinations as vac
	ON dea.location = vac.location 
	and dea.date = vac.date

-- Checking how many people vaccinated over the population ?
-- In addition to these correcting the data types to make our calculations right

SELECT dea.location, dea.population, max(cast(people_fully_vaccinated as float)) as FullyVaccinated, (max(cast(people_fully_vaccinated as float))/dea.population)*100 as PercPeopleFullyVaccinated
From CovidDeaths as dea
Join CovidVaccinations as vac
	ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null
GROUP BY dea.location, dea.population
ORDER BY 1,3


-- Number of Total Vaccinations vs GDP_Per_Capita

SELECT location, gdp_per_capita, max(convert(float,total_vaccinations)) as TotalVaccinations
FROM CovidVaccinations
WHERE continent is not null
GROUP BY location, gdp_per_capita
ORDER BY 2 DESC



SELECT dea.location, CONVERT(date,dea.date) as Date, dea.population, MAX(CONVERT(float, vac.total_vaccinations)) as TotalVaccinations, MAX(CONVERT(float, vac.total_vaccinations))/dea.population as VaccinationPerPeople
From CovidDeaths as dea
Inner Join CovidVaccinations as vac
	ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not NULL and
		dea.date = '2022-07-06'
GROUP BY dea.location, dea.population, dea.date
ORDER BY 5 DESC


Select location, date, total_deaths
FROM CovidDeaths
WHERE continent is not NULL
ORDER by 1,2