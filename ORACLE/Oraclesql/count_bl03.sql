select machine, count(*)
from v$session where machine='dcsp-pfullbl03' group by machine;
exit
