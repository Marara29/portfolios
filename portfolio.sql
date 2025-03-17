-- It should be working 
SELECT *
FROM job_postings_fact
WHERE job_title_short = 'Data Scientist'
LIMIT 100