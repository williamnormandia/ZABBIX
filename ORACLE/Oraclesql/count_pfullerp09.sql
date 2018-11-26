select machine, count(*)
from v$session where machine='dcsp-pfullerp09' group by machine;
exit
