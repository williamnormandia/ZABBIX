select amount metric, case when amount=0 then 0 else 2 end value from (select count(*) amount from dba_fga_audit_trail where DB_USER='SICOBE_RO' and OS_USER<>'sicobe' and timestamp>(SYSDATE - 10) and 'ACR'<>(select profile from dba_users where username='SICOBE_RO'));
exit
