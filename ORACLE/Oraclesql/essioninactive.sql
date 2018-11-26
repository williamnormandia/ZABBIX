select SUM(Decode(Type, 'BACKGROUND', 0, Decode(Status, 'ACTIVE', 0, 1))) FROM V$SESSION;
exit
