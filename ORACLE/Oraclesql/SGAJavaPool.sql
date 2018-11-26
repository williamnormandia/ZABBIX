SELECT to_char(ROUND(SUM(decode(pool,'java pool',(bytes)/(1024*1024),0)),2)) sga_jpool FROM V$SGASTAT;
exit
