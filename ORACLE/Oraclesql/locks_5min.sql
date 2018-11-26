select amount metric,case when amount=0 then 0 else 2 end value from (select count(1) amount from gv$lock where block=0 and ctime > 5*60);
exit
