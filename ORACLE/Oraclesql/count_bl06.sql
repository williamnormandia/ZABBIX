select machine, count(*)
from v$session where machine='dcsp-pfullbl06' group by machine;
exit
