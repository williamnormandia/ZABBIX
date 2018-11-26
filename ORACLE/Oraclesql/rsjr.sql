--
--
--  NOME
--    rsjr.sql
--
--  DESCRICAO
--    Exibe os job que estao em execucao.
--
--  HISTORICO
--    18/05/04(Ricardo Scholze) - Implementacao.
--
-----------------------------------------------------------------------------
-- InterSolution            The Right Choice         www.intersolution.inf.br
-- Simplex              Simplificando a sua vida           www.simplex.com.br
-----------------------------------------------------------------------------

col sid      format 9999
col job      format 999
col failures format 9999 heading FAIL

select /*+ rule */ r.sid, j.job, r.last_date, r.this_date, r.failures, j.what
from dba_jobs_running r, dba_jobs j
where r.job = j.job;

--
-- Fim
--

