SELECT
a.spid
b.sid
b.serial#
b.machine
b.username
b.osuser
b.program
b.status
concat(a.pga_used_mem, ' KB') used_mem
concat(a.pga_alloc_mem, ' KB') alloc_mem
from
v$session b, v$process a
where
b.PADDR = a.ADDR
and type = 'USER' AND status = 'ACTIVE'
order by spid;
