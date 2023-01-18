Select *
From MRReport..['owid-covid-data$']

Select location,date ,total_cases ,new_cases_per_million , new_cases
From MRReport..['owid-covid-data$']
Where location Like  'United States'


Select location, date, new_cases
, SUM(CONVERT(int,new_cases)) OVER (Partition by Location Order by location, Date) as Cumulativetotalnewcases
--, (RollingPeopleVaccinated/population)*100
From MRReport..['owid-covid-data$']
Where location Like  'United States'
order by date ASC

Create Table #USnewcases
(
Location nvarchar(255),
Date datetime,
new_cases numeric,
CumulativeTotalnewcases numeric,
)

Insert into #USnewcases
Select location, date, new_cases
, SUM(CONVERT(int,new_cases)) OVER (Partition by Location Order by location, Date) as Cumulativetotalnewcases
--, (RollingPeopleVaccinated/population)*100
From MRReport..['owid-covid-data$']
Where location Like  'United States'
order by date ASC




Create view USnewcases as 
Select location, date, new_cases
, SUM(CONVERT(int,new_cases)) OVER (Partition by Location Order by location, Date) as Cumulativetotalnewcases
--, (RollingPeopleVaccinated/population)*100
From MRReport..['owid-covid-data$']
Where location Like  'United States'
