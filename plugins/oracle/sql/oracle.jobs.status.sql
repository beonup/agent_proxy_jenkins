select STATUS from(
select job_name,STATUS,max(log_Date) as log from DBA_SCHEDULER_JOB_RUN_DETAILS
group by job_name,STATUS)
where job_name like '%{#JOB_NAME}%'