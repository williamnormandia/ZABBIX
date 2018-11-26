select s.sid    ||'!@#'||
       s.serial#   ||'!@#'||
       s.inst_id   ||'!@#'||
       s.username   ||'!@#'||
    s.osuser   ||'!@#'||
    s.machine   ||'!@#'|| 
    i.instance_name  ||'!@#'||
    i.host_name   ||'!@#'||
    p.spid    
  from gv$session s, gv$process p, gv$instance i, dba_blockers b
 where s.sid = b.holding_session
   and s.paddr = p.addr;
exit
