--col AUD_OSUSER for a20
--col AUD_USERNAME for a15
--col AUD_PROGRAM for a25
--col AUD_PROCESS for a15
--col AUD_MACHINE for a30
set lines 190

select AUD_USERNAME,AUD_OSUSER,AUD_MACHINE,to_char(AUD_LOGON_TIME,'dd/mm/yyy HH24:mi:SS'),AUD_PROCESS,AUD_PROGRAM 
from sys.ACSC_AUDIT_LOGON 
where AUD_LOGON_TIME between sysdate -75/86400 and sysdate
order by AUD_LOGON_TIME;
exit
