select amount metric, case when amount=0 then 0 else 2 end value from (select count(1) amount from dba_objects where status!='VALID' and OBJECT_NAME not in ('MV_PRODUCTION_DAILY', 'DOP_VW_FABRICA'));
exit
