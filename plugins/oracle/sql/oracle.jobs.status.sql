SELECT j.job_name AS JOBNAME, STATUS FROM DBA_SCHEDULER_JOB_RUN_DETAILS d, dba_scheduler_jobs j
WHERE 
d.job_name = j.job_name
AND j.owner not in ('SYS','ORACLE_OCM','GTPLAN')
GROUP BY j.job_name,d.STATUS