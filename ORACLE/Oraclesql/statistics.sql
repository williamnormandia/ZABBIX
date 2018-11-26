select amount metric,case when amount=0 then 0 else 2 end value from (select count(1) amount from (select job_status, JOB_START_TIME FROM dba_autotask_job_history WHERE client_name='auto optimizer stats collection' and job_status<>'SUCCEEDED' and JOB_START_TIME>(SYSDATE - 1)));
exit
