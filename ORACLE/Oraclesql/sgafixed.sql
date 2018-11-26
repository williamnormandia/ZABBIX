SELECT TO_CHAR(ROUND(SUM(decode(pool,NULL,decode(name,'fixed_sga',(bytes)/(1024*1024),0),0)),2)) sga_fixed FROM V$SGASTAT;
exit
