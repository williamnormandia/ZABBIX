--SET WRAP OFF

--SET PAGESIZE 0
SET linesize 200
SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON


--col SID for 999999
--col SERIAL# for 999999
col MACHINE for a16 JUSTIFY CENTER
--col PROGRAM for a7 tru
col USERNAME for a40 JUSTIFY CENTER
col OSUSER for a30 JUSTIFY CENTER
col "OS PID" for a9

SELECT s.sid, s.serial#, p.spid as "OS PID", s.username, s.osuser, s.status, s.machine, s.program, st.value/100 as "CPU sec", TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
FROM v$sesstat st, v$statname sn, v$session s, v$process p
WHERE sn.name = 'CPU used by this session' -- CPU
AND st.statistic# = sn.statistic#
AND st.sid = s.sid
AND s.paddr = p.addr
--AND s.last_call_et < 3600 -- active within last 1/2 hour
AND s.logon_time > (SYSDATE - 240/1440) -- sessions logged on within 4 hours
--AND s.username = 'ACESSOPRD'
AND s.osuser != 'mv' AND s.osuser !='FLEURY' AND s.osuser !='oracle' AND s.osuser !='thiago.freitas' AND s.osuser !='kleber.krewer' AND s.osuser !='zabbix'
and s.program !='JDBC Thin Client'  AND s.program !='w3wp.exe'AND s.program !='inserverWorkflow.exe'AND s.program !='SIT-E'
ORDER BY st.value DESC;
exit

