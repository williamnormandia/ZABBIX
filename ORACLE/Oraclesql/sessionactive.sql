select count(*) from v$session where TYPE!='BACKGROUND' and status='ACTIVE';
exit
