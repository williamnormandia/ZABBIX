select machine, count(*)
from v$session where machine='dcsp-pfullblct' group by machine;
exit
