
/* QUESTION :What skills are required for the top-paying data analyst jobs?
1. use the top 10 highest-paying data analysst jobs from first querry
2. add the specific skills required for these roles
3. why? It provided a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries*/


-- we will need a CTE for subquerring the whole 'top paying jobs'

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
