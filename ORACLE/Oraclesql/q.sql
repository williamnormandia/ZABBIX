SELECT s.username, s.program, COUNT(a.sid), SUM(a.value) Open_Cursors
FROM v$sesstat a, v$statname b, v$session s
WHERE a.statistic# = b.statistic# AND s.sid=a.sid
  AND b.name = 'opened cursors current'
  AND s.program NOT LIKE 'ORACLE%'
  AND s.program NOT LIKE 'OMS'
GROUP BY s.username, s.program
ORDER BY s.program;
