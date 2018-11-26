select machine, count(*)
from v$session where machine='dcsp-pfullbl05' group by machine;
exit
