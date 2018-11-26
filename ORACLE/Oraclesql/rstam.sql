--
--
--  NOME
--    rstam.sql
--
--  DESCRICAO
--    Exibe o tamanho do banco de dados.
--
--  HISTORICO
--    03/08/06(Ricardo Scholze) - Implementacao.
--
-----------------------------------------------------------------------------
-- InterSolution            The Right Choice         www.intersolution.inf.br
-- Simplex              Simplificando a sua vida           www.simplex.com.br
-----------------------------------------------------------------------------

set feed off
--SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON
--prompt
--prompt TAMANHO DO BANCO DE DADOS EM MB
--prompt ===============================

col dados for a10
col undo  for a12
col redo  for a12
col temp  for a12
col livre for a12
col total for a12

select to_char(sum(dados) / 1048576, 'fm99g999g990') dados,
       to_char(sum(undo) / 1048576, 'fm99g999g990') undo,
       to_char(sum(redo) / 1048576, 'fm99g999g990') redo,
       to_char(sum(temp) / 1048576, 'fm99g999g990') temp,
       to_char(sum(free) / 1048576, 'fm99g999g990') livre,
       to_char(sum(dados + undo + redo + temp) / 1048576, 'fm99g999g990') total
from (
  select sum(decode(substr(t.contents, 1, 1), 'P', bytes, 0)) dados,
         sum(decode(substr(t.contents, 1, 1), 'U', bytes, 0)) undo,
         0 redo,
         0 temp,
         0 free
  from dba_data_files f, dba_tablespaces t
  where f.tablespace_name = t.tablespace_name
  union all
  select 0 dados,
         0 undo,
         0 redo,
         sum(bytes) temp,
         0 free
  from dba_temp_files f, dba_tablespaces t
  where f.tablespace_name = t.tablespace_name(+)
  union all
  select 0 dados,
         0 undo,
         sum(bytes * members) redo,
         0 temp,
         0 free
  from v$log
  union all
  select 0 dados,
         0 undo,
         0 redo,
         0 temp,
         sum(bytes) free
  from dba_free_space f, dba_tablespaces t
  where f.tablespace_name = t.tablespace_name and
        substr(t.contents, 1, 1) = 'P'
);

prompt

set feed on
exit
--
-- Fim
--
