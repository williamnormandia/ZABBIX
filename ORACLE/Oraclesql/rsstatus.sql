--
--
--  NOME
--    rsstatus.sql
--
--  DESCRICAO
--    Exibe o status da instancia e do banco de dados.
--
--  HISTORICO
--    18/11/05(Ricardo Scholze) - Criacao.
--    15/12/05(Ricardo Scholze) - Adaptacao para RAC.
--
-----------------------------------------------------------------------------
-- InterSolution            The Right Choice         www.intersolution.inf.br
-- Simplex              Simplificando a sua vida           www.simplex.com.br
-----------------------------------------------------------------------------

set feed off

col kinstance_name for a12  heading 'Instancia'
col khostname      for a20  heading 'Servidor'
col kstatus                 heading 'Estado'
col ksessions      for 9999 heading 'Sessoes'

select decode(i.instance_name, null, '   ', '>> ') ||
       c.instance_name kinstance_name, 
       c.host_name khostname,
       c.status kstatus, 
       l.sessions_current ksessions
from gv$instance c, 
     gv$license l,
     v$instance i
where c.instance_number = i.instance_number (+)
  and c.thread# = i.thread# (+)
  and l.inst_id = c.inst_id;

prompt

-- Restaura configuracao do sqlplus

set feed on

--
-- Fim
--
