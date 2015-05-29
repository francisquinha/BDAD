.print ""
.print "1"
SELECT count(*) AS numero, 'alunos' AS pessoas
FROM aluno
UNION
SELECT count(*) AS numero, 'docentes' AS pessoas
FROM docente
UNION
SELECT count(*) AS numero, 'encarregados' AS pessoas
FROM encarregado;
/*
.print ""
.print "2"
SELECT pessoa.*
FROM pessoa, docente, encarregado
WHERE pessoa.id_pessoa = docente.id_docente AND pessoa.id_pessoa = encarregado.id_encarregado;

DROP VIEW IF EXISTS aluno_diretor;
CREATE VIEW aluno_diretor AS
SELECT aluno.id_aluno, docente.id_docente AS id_diretor
FROM aluno, inscricao, turma, diretor, docente
WHERE pessoa.id_pessoa = aluno.id_aluno AND aluno.id_aluno = inscricao.id_aluno AND inscricao.data_ini <= CURRENT_DATE 
	AND (CURRENT_DATE <= inscricao.data_fim OR inscricao.data_fim = NULL) AND inscricao.id_turma = turma.id_turma
	AND turma.id_turma = diretor.id_turma AND diretor.data_ini <= CURRENT_DATE AND (CURRENT_DATE <= diretor.data_fim 
	OR diretor.data_fim = NULL) AND diretor.id_docente = docente.id_docente;

.print ""
.print "3"
SELECT p1.*,
FROM pessoa AS p1 INNER JOIN aluno_diretor INNER JOIN pessoa AS p2
ON p1.id_pessoa = aluno_diretor.id_aluno AND aluno_diretor.id_diretor = p2.id_pessoa
WHERE p1.localidade = p2.localidade

DROP VIEW IF EXISTS freq_parentesco;
CREATE VIEW freq_parentesco AS
SELECT parentesco, count(*) AS count_parentesco
FROM responsavel
GROUP BY parentesco;

.print ""
.print "4"
SELECT freq_parentesco.*
FROM freq_parentesco
JOIN (SELECT max(count_parentesco) AS max_count_parentesco
	  FROM freq_parentesco)
ON count_parentesco = max_count_parentesco;

.print ""
.print "5"
SELECT parentesco
FROM responsavel
WHERE parentesco NOT IN ('pai', 'mae');

.print ""
.print "6"
SELECT area.*, count(aluno.id_aluno) AS numero_alunos
FROM area, turma, inscricao, aluno
WHERE area.id_area = turma.id_area AND turma.id_turma = inscricao.id_turma AND inscricao.id_aluno = aluno.id_aluno
	AND inscricao.data_ini <= CURRENT_DATE AND (CURRENT_DATE <= inscricao.data_fim OR inscricao.data_fim = NULL)
GROUP BY area.*;

.print ""
.print "7"
SELECT pessoa.*, max_media
FROM pessoa, aluno, (SELECT max(media) AS max_media
					 FROM aluno) AS temp
WHERE pessoa.id_pessoa = aluno.id_aluno AND aluno.media = temp.max_media;

.print ""
.print "8"
SELECT disciplina.id_disciplina, disciplina.codigo, disciplina.nome, periodo.numero AS periodo, 
	ano_letivo.designacao AS ano_letivo, temp1.alunos_aprovados * 100 / temp2.alunos_total AS pctg_aprovacoes
FROM disciplina, periodo, ano_letivo
	(SELECT disciplina.id_disciplina, frequencia.id_periodo, count(*) AS alunos_aprovados
	 FROM disciplina 
	 JOIN frequencia
	 ON disciplina.id_disciplina = frequencia.id_disciplina
	 WHERE frequencia.classificacao >= 10) AS temp1
	 GROUP BY disciplina.id_disciplina, frequencia.id_periodo),
 	(SELECT disciplina.id_disciplina, frequencia.id_periodo, count(*) AS alunos_total
 	 FROM disciplina 
 	 JOIN frequencia
 	 ON disciplina.id_disciplina = frequencia.id_disciplina) AS temp2
WHERE disciplina.id_disciplina = temp1.id_disciplina AND disciplina.id_disciplina = temp2.id_disciplina AND
	periodo.id_periodo = temp1.id_periodo AND periodo.id_periodo = temp2.id_periodo AND
	ano_letivo.id_ano_letivo = periodo.id_ano_letivo;

DROP VIEW IF EXISTS alunos_negativa;
CREATE VIEW alunos_negativa AS
SELECT id_pessoa 
FROM frequencia, (SELECT id_periodo
 				  FROM periodo, (SELECT max(data_fim) AS max_data_fim
				  				 FROM periodo
								 WHERE data_fim <= CURRENT_DATE) AS temp
 				  WHERE periodo.data_fim = temp.max_data_fim) AS periodo_recente
WHERE frequencia.id_periodo = periodo_recente.id_periodo AND classificacao < 10;

.print ""
.print "9"
SELECT p1.id_pessoa AS id_diretor, p1.nome AS nome_diretor, p2.id_pessoa AS id_encarregado, 
	p2.nome AS nome_encarregado, p2.telefone AS telefone_enc, p2.telemovel AS telemovel_enc,
	encarregado.horario_contacto AS hor_contacto_enc
FROM pessoa AS p1, diretor, inscricao, alunos_negativa, responsavel, pessoa AS p2
WHERE p1.id_pessoa = diretor.id_pessoa AND diretor.id_turma = inscricao.id_turma 
	AND inscricao.id_aluno = alunos_negativa.id_aluno AND alunos_negativa.id_aluno = responsavel.id_aluno
	AND responsavel.id_encarregado = p2.id_encarregado;

.print ""
.print "10"
SELECT disciplina.id_disciplina, disciplina.nome, ano_letivo.designacao, pessoa.id_pessoa, pessoa.nome
FROM disciplina, ano_letivo, frequencia, pessoa,
	(SELECT id_disciplina, id_periodo, id_ano_letivo, max(classficacao) AS melhor_nota
	 FROM frequencia, periodo
	 WHERE frequencia.id_periodo = periodo.id_periodo AND periodo.numero = 3
	 GROUP BY id_disciplina, id_periodo, id_ano_letivo) AS temp
WHERE disciplina.id_disciplina = temp.id_disciplina AND ano_letivo.id_ano_letivo = temp.id_ano_letivo 
	AND frequencia.id_disciplina = temp.id_disciplina AND frequencia.id_periodo = temp.id_periodo 
	AND frequencia.classificacao = temp.classificacao AND frequencia.id_aluno = pessoa.id_pessoa;
	
.print ""
.print "11"
SELECT area.nome, pessoa.nome, pessoa.telefone, pessoa.telemovel
FROM area, coordenador, pessoa
WHERE area.id_area = coordenador.id_area AND coordenador.id_docente = pessoa.id_pessoa;

.print ""
.print "12"
SELECT disciplina.id_disciplina, disciplina.nome, count(*) AS numero_docentes
FROM disciplina, aptidao
WHERE disciplina.id_disciplina = aptidao.id_disciplina
GROUP BY id_disciplina, nome;

.print ""
.print "13"
SELECT reuniao.id_docente, p1.nome_docente, reuniao.id_encarregado, p2.nome_encarregado, 
	reuniao.data, reuniao.hora, reuniao.sala
FROM reuniao, pessoa AS p1, pessoa AS p2
WHERE reuniao.id_docente = p1.id_pessoa AND reuniao.id_encarregado = p2.id_pessoa AND
	(p2.nome LIKE '%' + SUBSTRING(p1.nome, 1, INSTR(p1.nome, ' ') - 1) + '%' OR
	 p2.nome LIKE '%' + SUBSTRING(p1.nome, CHARINDEX(' ',p1.nome) + 1, CHARINDEX(' ',p1.nome) + '%') 

*/

				  


