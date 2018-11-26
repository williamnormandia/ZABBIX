select machine, count(*)
from v$session where machine='dcsp-pfullerp05' group by machine;
exit
