--
--
--   NOME
--     rsblk.sql
--
--   DESCRICAO
--     Exibe informacoes sobre usuarios bloqueadores.
--
--   HISTORICO
--     03/02/06(Ricardo Scholze) - Implementacao.
--
-----------------------------------------------------------------------------
-- InterSolution            The Right Choice         www.intersolution.inf.br
-- Simplex              Simplificando a sua vida           www.simplex.com.br
-----------------------------------------------------------------------------

set serveroutput on
set verify off
set feed off

prompt
prompt Informacoes sobre os usuarios bloqueadores
prompt ==========================================
prompt

begin
  for lst in (select s.sid, s.serial#, s.username, s.osuser, s.machine, s.program,
                     i.instance_name, i.host_name, p.spid
              from v$session s, v$process p, v$instance i, dba_blockers b
              where s.sid = b.holding_session
                and s.paddr = p.addr ) loop
    dbms_output.put_line('Sid..............: ' || lst.sid);
    dbms_output.put_line('Serial#..........: ' || lst.serial#);
    dbms_output.put_line('Username.........: ' || lst.username);
    dbms_output.put_line('Maquina..........: ' || lst.machine);
    dbms_output.put_line('Programa.........: ' || lst.program);
    dbms_output.put_line('OS User..........: ' || lst.osuser);
    dbms_output.put_line('Host.............: ' || lst.host_name);
    dbms_output.put_line('Instance.........: ' || lst.instance_name);
    dbms_output.put_line('PID..............: ' || lst.spid);
    dbms_output.put(chr(10));
  end loop;
end;
/

prompt

-- Restaura configuracao do sqlplus

set feed on

--
-- Fim
--
