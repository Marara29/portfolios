/*QUESTION : What are the highest paid data analyst jobs?

1. identify the top 10 highest paying jobs that are available remotely
2. focuses on job postings with specified salaries ( remove nulls)
3. why? higlight the top-paying opportunities for data analysts ,offereing insights needed */ 

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
