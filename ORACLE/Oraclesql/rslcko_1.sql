--
--
--  NOME
--    rslcko.sql
--
--  DESCRICAO
--    Exibe objetos "lockados".
--
--  HISTORICO
--    30/05/05(Ricardo Scholze) - Implementacao.
--
-----------------------------------------------------------------------------
-- InterSolution            The Right Choice         www.intersolution.inf.br
-- Simplex              Simplificando a sua vida           www.simplex.com.br
-----------------------------------------------------------------------------
set serveroutput on
set feedback off
col session_id      format 9999 heading 'Sid'
col owner           format a12  heading 'Owner'
col object_name     format a20  heading 'Objeto'
col oracle_username format a10  heading 'Username'
col os_user_name    format a10  heading 'OS user'
col blocked         format a15   heading 'waiting'
col type            format a2   heading 'ty'

  declare
  comsid number;
  branc  varchar2(100) default '                                                    ';

begin
  dbms_output.enable(65536);
  dbms_output.put_line('sid  Owner        Objeto              User       Os User    Waiting   [sid] ty(I)');
  dbms_output.put_line('---- ------------ ------------------- ---------- ---------- --------- ----- -----');
  for lst in (select l.SESSION_ID, o.owner, o.object_name, l.oracle_username, l.os_user_name, type ,
            decode (v.request,0,' ',
            ltrim  (to_char(floor(v.Ctime/3600  ), '000' ))    || ':' ||
            substr (to_char(mod  (ceil (v.ctime/60) ,60 ), '00'),2,2)                        || ':' ||
            substr (to_char(mod  (v.ctime,60    ), '00'),2,2)                         ) blocked
            ,v.id1,v.id2,v.inst_id
            from gv$locked_object l, dba_objects o ,gv$lock v
            where l.object_id = o.object_id and v.sid = l.session_id order by o.object_name)
  loop
    if lst.blocked <> ' ' then
    for lst1 in (select sid from gv$lock where id1 = lst.id1 and id2 = lst.id2 and request = 0)
    loop
      comsid := lst1.sid;
    end loop;
    dbms_output.put_line(lst.SESSION_ID      || substr(branc,1,5- length(lst.SESSION_ID))  ||
                         lst.owner           || substr(branc,1,13- length(lst.owner))      ||
                         lst.object_name     || substr(branc,1,20- length(lst.object_name))||
                         lst.oracle_username || substr(branc,1,11- length(lst.oracle_username)) ||
                         lst.os_user_name    || substr(branc,1,11- length(lst.os_user_name)) ||
                         lst.blocked         || ' [' || comsid || '] ' ||
                         lst.type            || '(' || lst.inst_id || ')'
                         );
    end if;
  end loop;
end;
/
set feedback on
--
-- Fim
--