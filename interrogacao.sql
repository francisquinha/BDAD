.print ""
.print "1"
SELECT 'encarregados' AS pessoas, count(*) AS numero
FROM encarregado
UNION
SELECT 'alunos' AS pessoas, count(*) AS numero
FROM aluno
UNION
SELECT 'docentes' AS pessoas, count(*) AS numero
FROM docente;

.print ""
.print "2"
SELECT pessoa.*
FROM pessoa, docente, encarregado
WHERE pessoa.id_pessoa = docente.id_docente 
	AND pessoa.id_pessoa = encarregado.id_encarregado;

DROP VIEW IF EXISTS aluno_diretor;
CREATE VIEW aluno_diretor AS
SELECT aluno.id_aluno, docente.id_docente AS id_diretor
FROM aluno, inscricao, turma, diretor, docente
WHERE aluno.id_aluno = inscricao.id_aluno 
	AND inscricao.data_ini <= datetime('now') 
	AND (datetime('now') <= inscricao.data_fim OR inscricao.data_fim IS NULL) 
	AND inscricao.id_turma = turma.id_turma
	AND turma.id_turma = diretor.id_turma AND diretor.data_ini <= datetime('now') 
	AND (datetime('now') <= diretor.data_fim 
	OR diretor.data_fim IS NULL) AND diretor.id_docente = docente.id_docente;

.print ""
.print "3"
SELECT p1.*
FROM codigo_postal AS c1, pessoa AS p1, aluno_diretor, pessoa AS p2, codigo_postal AS c2
WHERE c1.id_cod_postal = p1.id_cod_postal AND p1.id_pessoa = aluno_diretor.id_aluno 
	AND aluno_diretor.id_diretor = p2.id_pessoa AND p2.id_cod_postal = c2.id_cod_postal
	AND c1.id_localidade = c2.id_localidade;

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
SELECT area.id_area, area.nome, count(aluno.id_aluno) AS numero_alunos
FROM area, turma, inscricao, aluno
WHERE area.id_area = turma.id_area AND turma.id_turma = inscricao.id_turma 
	AND inscricao.id_aluno = aluno.id_aluno
	AND inscricao.data_ini <= datetime('now') 
	AND (datetime('now') <= inscricao.data_fim OR inscricao.data_fim IS NULL)
GROUP BY area.id_area, area.nome;

.print ""
.print "7"
SELECT pessoa.*, max_media
FROM pessoa, aluno, (SELECT max(media) AS max_media
					 FROM aluno) AS temp
WHERE pessoa.id_pessoa = aluno.id_aluno AND aluno.media = temp.max_media;

DROP VIEW IF EXISTS disciplina_aprovacoes;
CREATE VIEW disciplina_aprovacoes AS
SELECT disciplina.id_disciplina, frequencia.id_periodo, count(*) AS alunos_aprovados
FROM disciplina 
JOIN frequencia
ON disciplina.id_disciplina = frequencia.id_disciplina
WHERE frequencia.classificacao >= 10
GROUP BY disciplina.id_disciplina, frequencia.id_periodo;

DROP VIEW IF EXISTS disciplina_alunos;
CREATE VIEW disciplina_alunos AS
SELECT disciplina.id_disciplina, frequencia.id_periodo, count(*) AS alunos_total
FROM disciplina 
JOIN frequencia
ON disciplina.id_disciplina = frequencia.id_disciplina
GROUP BY disciplina.id_disciplina, frequencia.id_periodo;

.print ""
.print "8"
SELECT disciplina.id_disciplina, disciplina.codigo, disciplina.nome, 
	periodo.numero AS periodo, ano_letivo.designacao AS ano_letivo,
	disciplina_aprovacoes.alunos_aprovados * 100 / disciplina_alunos.alunos_total 
	AS pctg_aprovacoes
FROM disciplina, periodo, ano_letivo, disciplina_aprovacoes, disciplina_alunos
WHERE disciplina.id_disciplina = disciplina_aprovacoes.id_disciplina AND 
	disciplina.id_disciplina = disciplina_alunos.id_disciplina AND
	periodo.id_periodo = disciplina_aprovacoes.id_periodo AND 
	periodo.id_periodo = disciplina_alunos.id_periodo AND
	ano_letivo.id_ano_letivo = periodo.id_ano_letivo;

DROP VIEW IF EXISTS alunos_negativa;
CREATE VIEW alunos_negativa AS
SELECT id_aluno 
FROM frequencia, (SELECT id_periodo
 				  FROM periodo, (SELECT max(data_fim) AS max_data_fim
				  				 FROM periodo
								 WHERE data_fim <= datetime('now')) AS temp
 				  WHERE periodo.data_fim = temp.max_data_fim) AS periodo_recente
WHERE frequencia.id_periodo = periodo_recente.id_periodo AND classificacao < 10;

.print ""
.print "9"
SELECT p1.id_pessoa AS id_diretor, p1.nome AS nome_diretor, 
	p2.id_pessoa AS id_encarregado, p2.nome AS nome_encarregado, 
	p2.telefone AS telefone_enc, p2.telemovel AS telemovel_enc,
	encarregado.horario_contacto AS hor_contacto_enc
FROM pessoa AS p1, diretor, inscricao, alunos_negativa, responsavel, 
	encarregado, pessoa AS p2
WHERE p1.id_pessoa = diretor.id_docente 
	AND diretor.id_turma = inscricao.id_turma 
	AND inscricao.id_aluno = alunos_negativa.id_aluno 
	AND alunos_negativa.id_aluno = responsavel.id_aluno
	AND responsavel.id_encarregado = encarregado.id_encarregado 
	AND encarregado.id_encarregado = p2.id_pessoa;

.print ""
.print "10"
SELECT disciplina.id_disciplina, disciplina.nome, ano_letivo.designacao, 
	pessoa.id_pessoa, pessoa.nome, temp.classificacao 
FROM disciplina, ano_letivo, frequencia, pessoa,
	(SELECT id_disciplina, frequencia.id_periodo, id_ano_letivo, 
		max(classificacao) AS classificacao
	 FROM frequencia, periodo
	 WHERE frequencia.id_periodo = periodo.id_periodo 
	 	AND periodo.numero = 3
	 GROUP BY id_disciplina, frequencia.id_periodo, id_ano_letivo) AS temp
WHERE disciplina.id_disciplina = temp.id_disciplina 
	AND ano_letivo.id_ano_letivo = temp.id_ano_letivo 
	AND frequencia.id_disciplina = temp.id_disciplina 
	AND frequencia.id_periodo = temp.id_periodo 
	AND frequencia.classificacao = temp.classificacao 
	AND frequencia.id_aluno = pessoa.id_pessoa;
	
.print ""
.print "11"
SELECT area.id_area, area.nome, pessoa.id_pessoa, pessoa.nome, 
	pessoa.telefone, pessoa.telemovel
FROM area, coordenador, pessoa
WHERE area.id_area = coordenador.id_area 
	AND coordenador.id_docente = pessoa.id_pessoa;

.print ""
.print "12"
SELECT disciplina.id_disciplina, disciplina.nome, count(*) AS numero_docentes
FROM disciplina, aptidao
WHERE disciplina.id_disciplina = aptidao.id_disciplina
GROUP BY disciplina.id_disciplina, disciplina.nome;

.print ""
.print "13"
SELECT disciplina.id_disciplina, disciplina.nome, count(*) AS numero_vintes
FROM disciplina, frequencia, periodo
WHERE disciplina.id_disciplina = frequencia.id_disciplina 
	AND frequencia.id_periodo = periodo.id_periodo 
	AND periodo.numero = 3 AND frequencia.classificacao = 20
GROUP BY disciplina.id_disciplina, disciplina.nome;

DROP VIEW IF EXISTS docente_aprovacoes;
CREATE VIEW docente_aprovacoes AS
SELECT docente.id_docente, periodo.id_ano_letivo, count(*) AS alunos_aprovados
FROM docente, docencia, frequencia, periodo
WHERE docente.id_docente = docencia.id_docente 
	AND docencia.id_disciplina = frequencia.id_disciplina
	AND frequencia.id_periodo = periodo.id_periodo 
	AND frequencia.classificacao >= 10 AND periodo.numero = 3
GROUP BY docente.id_docente, periodo.id_ano_letivo;

DROP VIEW IF EXISTS docente_alunos;
CREATE VIEW docente_alunos AS
SELECT docente.id_docente, periodo.id_ano_letivo, count(*) AS alunos_total
FROM docente, docencia, frequencia, periodo
WHERE docente.id_docente = docencia.id_docente 
	AND docencia.id_disciplina = frequencia.id_disciplina
	AND frequencia.id_periodo = periodo.id_periodo 
	AND periodo.numero = 3
GROUP BY docente.id_docente, periodo.id_ano_letivo;

.print ""
.print "14"
SELECT docente.id_docente, pessoa.nome, ano_letivo.designacao AS ano_letivo,
	docente_aprovacoes.alunos_aprovados * 100 / docente_alunos.alunos_total 
	AS pctg_aprovacoes
FROM docente, pessoa, ano_letivo, docente_aprovacoes, docente_alunos
WHERE docente.id_docente = docente_aprovacoes.id_docente AND 
	docente.id_docente = docente_alunos.id_docente AND
	docente.id_docente = pessoa.id_pessoa AND
	ano_letivo.id_ano_letivo = docente_aprovacoes.id_ano_letivo AND
	ano_letivo.id_ano_letivo = docente_alunos.id_ano_letivo;

DROP VIEW IF EXISTS aluno_ano;
CREATE VIEW aluno_ano AS
SELECT aluno.id_aluno, ano_letivo.designacao AS ano_letivo, 
	turma.ano_escolar
FROM ano_letivo, turma, inscricao, aluno
WHERE ano_letivo.id_ano_letivo = turma.id_ano_letivo 
	AND turma.id_turma = inscricao.id_turma 
	AND inscricao.id_aluno = aluno.id_aluno;

.print ""
.print "15"
SELECT aluno_ano.ano_letivo as ano_letivo, aluno_ano.ano_escolar as ano_escolar, 
	aluno_ano.id_aluno as id_aluno, pessoa.nome as nome, aluno.media as media
FROM aluno_ano, pessoa, aluno,
	(SELECT aluno_ano.ano_letivo, aluno_ano.ano_escolar,
		max(aluno.media) as media
	 FROM aluno_ano, aluno
	 WHERE aluno_ano.id_aluno = aluno.id_aluno
	 GROUP BY aluno_ano.ano_letivo, aluno_ano.ano_escolar) AS ano_media
WHERE aluno.media = ano_media.media 
	AND aluno_ano.id_aluno = pessoa.id_pessoa 
	AND aluno_ano.id_aluno = aluno.id_aluno 
	AND aluno_ano.ano_letivo = ano_media.ano_letivo 
	AND aluno_ano.ano_escolar = ano_media.ano_escolar;
		
.print ""
.print "16"
SELECT aluno.id_aluno, pessoa.nome
FROM aluno, pessoa, 
	(SELECT frequencia.id_aluno, count(*) AS numero_disciplinas
	 FROM frequencia, periodo
	 WHERE frequencia.id_periodo = periodo.id_periodo 
	 	AND periodo.numero = 3
	 GROUP BY frequencia.id_aluno) AS aluno_disciplinas, 
	(SELECT frequencia.id_aluno, count(*) AS notas_elevadas
			 FROM frequencia, periodo
			 WHERE frequencia.id_periodo = periodo.id_periodo 
			 	AND periodo.numero = 3 
			 	AND classificacao > 16
				GROUP BY frequencia.id_aluno) AS aluno_elevadas
WHERE aluno.id_aluno = pessoa.id_pessoa 
	AND aluno.id_aluno = aluno_disciplinas.id_aluno 
	AND aluno.id_aluno = aluno_elevadas.id_aluno 
	AND round(notas_elevadas/numero_disciplinas,1) >= 0.5;
	 


				  


