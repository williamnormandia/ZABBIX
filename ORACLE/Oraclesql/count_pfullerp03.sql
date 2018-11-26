select machine, count(*)
from v$session where machine='dcsp-pfullerp03' group by machine;
exit
