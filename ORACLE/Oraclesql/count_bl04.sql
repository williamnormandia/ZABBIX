select machine, count(*)
from v$session where machine='dcsp-pfullbl04' group by machine;
exit
