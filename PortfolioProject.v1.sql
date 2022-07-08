SELECT *
FROM CovidDeaths
WHERE continent is not NULL
ORDER BY 3,4

SELECT *
FROM CovidDeaths




--Select data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent is not NULL
ORDER BY 1,2

--Looking at Total Cases vs Total Deaths

-- Shows likelihood of dying if you contract covid in your country

SELECT location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%Kingdom%'
AND continent is not NULL
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as CasesPercentage
FROM CovidDeaths
WHERE location like '%Kingdom%'
AND continent is not NULL
ORDER BY 1,2

-- What countries have the highest infection rates ?

SELECT
	location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) as PercentPopulationInfected
FROM 
	CovidDeaths
WHERE 
	continent is not NULL
GROUP BY
	location, Population
ORDER BY
	PercentPopulationInfected DESC;

-- Showing Countries with highest death count per population 

SELECT
	location, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM
	CovidDeaths
WHERE 
	continent is not NULL
GROUP BY
	location
ORDER BY
	TotalDeathCount DESC;

--Checking by continent

-- Showing continents with the highest death per population

SELECT
	continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM
	CovidDeaths
WHERE 
	continent is not NULL
GROUP BY
	continent
ORDER BY
	TotalDeathCount DESC;


--GLOBAL NUMBERS

SELECT  SUM(new_cases) as New_cases, SUM(cast(new_deaths as int)) as New_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as NewdeathsPercentbyNewCases
FROM CovidDeaths
WHERE continent is not NULL

-- Showing the UK's total new cases, new deaths and percent of compare 

SELECT SUM(new_cases) as New_cases, SUM(cast(new_deaths as int)) as New_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as NewdeathsPercentbyNewCases
FROM CovidDeaths
WHERE location like '%Kingdom%'
AND continent is not NULL


-- Let's look into CovidVaccination table

SELECT *
FROM CovidVaccinations


-- Joins tables together

SELECT *
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date

-- Looking Total Population vs Vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by  dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not NULL
ORDER BY 2,3












