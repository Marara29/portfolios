/* Question : what are the top skills based on salary?
1. look at the average salary associated with each skill
2. Focuses on roles with specified salaries, regardless of location
3. why? it reveals how different skills impact salary level for data analysts and 
it helps identify the most financially rewarding skills to acquire or improve*/

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