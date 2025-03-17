/*Question : what are the most optimal skills to learn
1. identify skills in high demand and asssociated with high average salaries for data analyst roles
concentrate on remote positions with specified salaries
why? targets skills that offer job security (high demand) and financial bebefits (high salaries),offering stategic insights for career development in data analysis*/


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
 