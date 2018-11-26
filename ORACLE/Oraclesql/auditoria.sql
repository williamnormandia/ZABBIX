select username "username", 
        to_char(timestamp,'DD-MON-YYYY HH24:MI:SS') "time_stamp", 
        action_name "statement", 
        os_username "os_username", 
        userhost "userhost", 
        returncode||decode(returncode,'1004','-Wrong Connection','1005','-NULL Password','1017','-Wrong Password','1045','-Insufficient Priviledge','0','-Login Accepted','--') "returncode" 
        from sys.dba_audit_session 
        where (sysdate - timestamp)*24 < 1 and returncode <> 0 
        order by timestamp;
