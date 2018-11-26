select to_char((sysdate-startup_time)*86400, 'FM99999999999999990') retvalue from v$instance;
exit

