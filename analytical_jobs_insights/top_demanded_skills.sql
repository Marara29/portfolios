/* Question : What are the most in-demand skills for data analyst?
1.Join job postings to inner join table similar to query 2
2.identify the top 5 in-demand skills for a data analyst
3.focus on all job postings
4.why? Retrieve the top 5 skills with the highest demand in the job seekers.
provide insights into the most valuable skills for job seekers*/

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
LIMIT 10
