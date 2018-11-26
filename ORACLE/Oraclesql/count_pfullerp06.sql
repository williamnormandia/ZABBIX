select machine, count(*)
from v$session where machine='dcsp-pfullerp06' group by machine;
exit
