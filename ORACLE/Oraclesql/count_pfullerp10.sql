select machine, count(*)
from v$session where machine='dcsp-pfullerp10' group by machine;
exit
