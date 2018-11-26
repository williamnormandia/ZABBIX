select machine, count(*)
from v$session where machine='dcsp-pfullerp08' group by machine;
exit
