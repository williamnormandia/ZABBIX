select machine, count(*)
from v$session where machine='dcsp-pfullerp04' group by machine;
exit
