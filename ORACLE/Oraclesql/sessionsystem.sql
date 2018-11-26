select SUM(Decode(Type, 'BACKGROUND', 1, 0)) system_sessions FROM V$SESSION;
exit
