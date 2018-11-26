select amount metric, case when amount=0 then 0 else 2 end value from (select count(1) amount from gv$dataguard_status where (ERROR_CODE!=0 or SEVERITY='Error') and TIMESTAMP > SYSDATE - 1/24);
exit
