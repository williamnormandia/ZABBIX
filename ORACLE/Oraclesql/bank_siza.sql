   SELECT --'Database Tamanho' "*****"
--,ROUND(SUM(ROUND(SUM(NVL(fs.bytes/1024/1024,0)))) /
--SUM(ROUND(SUM(NVL(fs.bytes/1024/1024,0))) + ROUND(df.bytes/1024/
--1024 - SUM(NVL(fs.bytes/1024/1024,0)))) * 100, 0) "%Livre"
--,ROUND(SUM(ROUND(df.bytes/1024/1024 - SUM(NVL(fs.bytes/1024/
--1024,0)))) / SUM(ROUND(SUM(NVL(fs.bytes/1024/1024,0))) +
--ROUND(df.bytes/1024/1024 - SUM(NVL(fs.bytes/1024/1024,0)))) * 100,
--0) "%Usado"
---,SUM(ROUND(SUM(NVL(fs.bytes/1024/1024/1024,0)))) "GB Livre"
---,SUM(ROUND(df.bytes/1024/1024/1024
--- SUM(NVL(fs.bytes/1024/1024/1024,0)))) "GB Usado"
SUM(ROUND(SUM(NVL(fs.bytes/1024/1024/1024,0))) + ROUND(df.bytes/1024/
1024/1024
- SUM(NVL(fs.bytes/1024/1024/1024,0)))) "Tamanho em GB"
FROM dba_free_space fs, dba_data_files df
WHERE fs.file_id(+) = df.file_id
GROUP BY df.tablespace_name, df.file_id, df.bytes,
df.autoextensible
ORDER BY df.file_id ;
exit
