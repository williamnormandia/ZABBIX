select amount metric,case when amount=0 then 0 else 2 end value from (select count(*) amount from dba_role_privs where granted_role='DBA' and grantee not in ('SYS', 'SYSTEM', 'SYSMAN', 'AVUSER') and grantee not in (SELECT username FROM dba_users WHERE account_status <> 'OPEN'));
exit
