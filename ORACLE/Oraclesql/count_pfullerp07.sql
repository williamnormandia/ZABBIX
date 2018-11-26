select machine, count(*)
from v$session where machine='dcsp-pfullerp07' group by machine;
exit
