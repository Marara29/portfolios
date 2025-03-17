# INTRODUCTION
Basically this project is all about top paying jobs,and needed skills and shows you where high demand meets high salary in Data analytics

Link here : [analytical_jobs_insights](/analytical_jobs_insights/)

# BACKGROUND
This is a learning material and open source for getting data about income in data industry ,its customizable depending on location,type,roles etc 
### QUESTIONS ASKED ARE FOLLLOWING
1. what are highest paying data analyst jobs?
2. what skills needed? (generally)
3. what skills are in most demand?
4. which skills are related to higher salaries
5. whats optimal skills to learn?

# TOOLS
The tools I used were :
1. SQL 
2. PostgresSQL
3. Git&GitHub

# ANALYSIS ( From first question to last respectively)

### Question 1
1. identify the top 10 highest paying jobs that are available remotely
2. focuses on job postings with specified salaries ( remove nulls)
``` SQL
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id --we need to attach another table so that we can get company ID
WHERE job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```
### Question 2
1. use the top 10 highest-paying data analysst jobs from first querry
2. add the specific skills required for these roles

``` SQL
WITH top_paying_jobs AS (
SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id --we need to attach another table so that we can get company ID
WHERE job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10

)

SELECT
    top_paying_jobs.* ,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
ORDER BY
     salary_year_avg DESC
```

### Question 3


1.Join job postings to inner join table similar to query 2
2.identify the top 5 in-demand skills for a data analyst
3.focus on all job postings
``` SQL
SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
    job_title_short ='Data Analyst' AND
    job_work_from_home = True
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```

### Question 4
1. look at the average salary associated with each skill
2. Focuses on roles with specified salaries, regardless of location
``` SQL
SELECT 
    skills,
    ROUND (AVG (salary_year_avg),1) AS avg_salary  --Round function noted as  (ROUND(a,b)) used for removing/decreasing decimals
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
    job_title_short ='Data Analyst' AND
    salary_year_avg IS NOT NULL
    --job_work_from_home = True
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 100
```

### Question 5 
1. identify skills in high demand and asssociated with high average salaries for data analyst roles
concentrate on remote positions with specified salaries
``` SQL
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) AS demand_count,
    ROUND (AVG (salary_year_avg),1) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE -- Filter unwanted values
    job_title_short = 'Data Analyst'AND
    salary_year_avg IS NOT NULL AND 
    job_work_from_home =True
GROUP BY skills_dim.skill_id
HAVING 
    COUNT(job_postings_fact.job_id)>10
ORDER BY
    avg_salary DESC,
    demand_count DESC 
    
LIMIT 100
```
# Points

1. Correcly use of CTE , data efficiency and speed up the process and save time
2. Acessing multiple tables to get desired datas
3. Call the columns you actually need saves a lot of processing power and time

# CONCLUSION
Based on above data research :
1. top paying data analyst jobs that allow remote work offer a wide range of salaries with the highest being $650,000
2. High paying jobs require SQL as top demanding skills for Data Analyst
3. Most demanded skill is also SQL followed by python,tableau and POWER BI
4. skills with higher salary ,we found that SVN,Solidity are the most paid 
5. Optimal skills for job market value ,SQL leads in demand and offer high average salary

# Non technical takeaway

Glad to share some insights computed with help of SQL about this job_market out here hope it will narrow everyone job's hunting field ,I focused mainly on analytical jobs  and whole project was fun and inspiring as my aim is to be among those top salaries range ,lol ( I mean who doesn't)