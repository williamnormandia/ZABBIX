select to_char(decode( unit,'bytes', value/1024/1024, value),'999999999.9') value from V$PGASTAT where name in 'aggregate PGA target parameter';
exit
