
PRAGMA foreign_keys = ON;

DELETE FROM coordenador;
DELETE FROM diretor;
DELETE FROM docencia;
DELETE FROM reuniao;
DELETE FROM aptidao;
DELETE FROM frequencia;
DELETE FROM inscricao;
DELETE FROM responsavel;
DELETE FROM turma;
DELETE FROM area;
DELETE FROM disciplina;
DELETE FROM periodo;
DELETE FROM ano_letivo;
DELETE FROM docente;
DELETE FROM aluno;
DELETE FROM encarregado;
DELETE FROM pessoa;
DELETE FROM codigo_postal;
DELETE FROM localidade;

INSERT INTO localidade VALUES(1, 'Porto');
INSERT INTO localidade VALUES(2, 'Braga');
INSERT INTO localidade VALUES(3, 'Gaia');
INSERT INTO localidade VALUES(4, 'Espinho');
INSERT INTO localidade VALUES(5, 'Famalicao');

INSERT INTO codigo_postal VALUES(1, '4100', 1);
INSERT INTO codigo_postal VALUES(2, '5100', 2);
INSERT INTO codigo_postal VALUES(3, '4300', 3);
INSERT INTO codigo_postal VALUES(4, '3600', 5);
INSERT INTO codigo_postal VALUES(5, '3700', 4);

INSERT INTO pessoa VALUES(1, 'AL01', 'Carlos', 102548796, 254125789, 
	'Rua do Lado Esquerdo', '2000-05-05', '254789654', '323547899', 1);
INSERT INTO pessoa VALUES(2, 'AL02', 'Ana', 134548796, 254125734, 
	'Rua do Lado Direito', '2001-06-05', '954789654', '923547899', 2);
INSERT INTO pessoa VALUES(3, 'AL03', 'Manuel', 434548796, 257655734, 
	'Rua do Cimo Direito', '2000-02-05', '954234654', '813547899', 3);
INSERT INTO pessoa VALUES(4, 'DC01', 'Alberto', 434548796, 257655734, 
	'Rua do Cimo Direito', '1978-02-05', '465478965', '962587451', 4);
INSERT INTO pessoa VALUES(5, 'DC02', 'Custodio', 434548796, 257655734, 
	'Rua do Cimo Esquerdo', '1979-02-05', '4623478965', '962587345', 5);
INSERT INTO pessoa VALUES(6, 'EE01', 'Baltazar', 254789651, 125478891, 
	'Rua do Lado Esquerdo', '1973-02-05', '925656541', '252587845', 1);
INSERT INTO pessoa VALUES(7, 'EE02', 'Mariana', 254789650, 125478890, 
	'Rua do Lado Direito', '1978-03-05', '922656541', '252587245', 2);
INSERT INTO pessoa VALUES(8, 'AL04', 'Joao', 434528796, 257255734, 
	'Rua Fernando Pessoa', '2000-02-05', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(9, 'AL04', 'Carla', 434528796, 257255734, 
	'Rua da Carla', '2000-02-05', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(10, 'AL05', 'Maria', 434528796, 257255734, 
	'Rua Fernando Pessoa', '2000-02-05', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(11, 'AL06', 'Pedro', 434528796, 257255734, 
	'Rua Fernando Pessoa', '2000-02-05', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(12, 'DC03', 'Marta', 434528796, 257255734, 
	'Rua Fernando Pessoa', '1980-06-21', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(13, 'DC04', 'Pedro', 434528796, 257255734, 
	'Rua Fernando Pessoa', '1974-11-30', '954224654', '813527899', 4);
INSERT INTO pessoa VALUES(14, 'DC05', 'Patricia', 434528796, 257255734, 
	'Rua Fernando Pessoa', '1968-02-015', '954224654', '813527899', 4);

INSERT INTO aluno(id_aluno, ano_admissao, observacoes) VALUES(1, 2010, 'Alergico a amendoins');
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(2, 2011);
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(3, 2009);
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(8, 2009);
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(9, 2008);
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(10, 2008);
INSERT INTO aluno(id_aluno, ano_admissao) VALUES(11, 2007);

INSERT INTO docente VALUES(4, 2012, 'Licenciatura em Linguas');
INSERT INTO docente VALUES(5, 2011, 'Mestrado em Matematica');
INSERT INTO docente VALUES(6, 2008, 'Licenciatura em Desporto');
INSERT INTO docente VALUES(12, 2007, 'Licenciatura em Biologia');
INSERT INTO docente VALUES(13, 2000, 'Doutoramento em Artes Visuais');
INSERT INTO docente VALUES(14, 1990, 'Licenciatura em Fisica');

INSERT INTO encarregado VALUES(6, '10h-11h');
INSERT INTO encarregado VALUES(7, '14h-18h');

INSERT INTO responsavel VALUES(1, 'pai', 1, 6, '2011-04-20', NULL);
INSERT INTO responsavel VALUES(2, 'mae', 2, 7, '2011-04-10', NULL);
INSERT INTO responsavel VALUES(3, 'mae', 3, 7, '2011-04-10', NULL);
INSERT INTO responsavel VALUES(4, 'tio', 8, 6, '2011-04-21', NULL);

INSERT INTO ano_letivo VALUES(1, '2012/2013', '2012-09-23', '2013-06-27');

INSERT INTO disciplina VALUES(1, 'MAT12', 'Matematica', NULL, 1);
INSERT INTO disciplina VALUES(2, 'POT12', 'Portugues', NULL, 1);
INSERT INTO disciplina VALUES(3, 'FQ11', 'Fisica-Quimica',NULL,1);
INSERT INTO disciplina VALUES(4, 'EF', 'Educacao Fisica',NULL,1);
INSERT INTO disciplina VALUES(5, 'AV', 'Artes Visuais',NULL,1);
INSERT INTO disciplina VALUES(6, 'BIO', 'Biologia',NULL,1);

INSERT INTO periodo VALUES(1, 1, 1, '2012-09-23', '2012-12-31');
INSERT INTO periodo VALUES(2, 2, 1, '2013-01-01', '2013-04-22');
INSERT INTO periodo VALUES(3, 3, 1, '2013-04-23', '2013-06-27');

INSERT INTO frequencia VALUES(1, 1, 1, 12);
INSERT INTO frequencia VALUES(1, 2, 1, 14);
INSERT INTO frequencia VALUES(1, 3, 1, 16);
INSERT INTO frequencia VALUES(1, 1, 2, 9);
INSERT INTO frequencia VALUES(1, 2, 2, 10);
INSERT INTO frequencia VALUES(1, 3, 2, 10);
INSERT INTO frequencia VALUES(1, 1, 3, 12);
INSERT INTO frequencia VALUES(1, 2, 3, 13);
INSERT INTO frequencia VALUES(1, 3, 3, 11);
INSERT INTO frequencia VALUES(2, 1, 1, 15);
INSERT INTO frequencia VALUES(2, 2, 1, 8);
INSERT INTO frequencia VALUES(2, 3, 1, 15);
INSERT INTO frequencia VALUES(2, 1, 2, 17);
INSERT INTO frequencia VALUES(2, 2, 2, 17);
INSERT INTO frequencia VALUES(2, 3, 2, 18);
INSERT INTO frequencia VALUES(2, 1, 4, 15);
INSERT INTO frequencia VALUES(2, 2, 4, 15);
INSERT INTO frequencia VALUES(2, 3, 4, 15);
INSERT INTO frequencia VALUES(3, 1, 1, 8);
INSERT INTO frequencia VALUES(3, 2, 1, 8);
INSERT INTO frequencia VALUES(3, 3, 1, 9);
INSERT INTO frequencia VALUES(3, 1, 2, 10);
INSERT INTO frequencia VALUES(3, 2, 2, 9);
INSERT INTO frequencia VALUES(3, 3, 2, 11);
INSERT INTO frequencia VALUES(3, 1, 5, 8);
INSERT INTO frequencia VALUES(3, 2, 5, 9);
INSERT INTO frequencia VALUES(3, 3, 5, 10);
INSERT INTO frequencia VALUES(8, 1, 1, 18);
INSERT INTO frequencia VALUES(8, 2, 1, 20);
INSERT INTO frequencia VALUES(8, 3, 1, 20);
INSERT INTO frequencia VALUES(8, 1, 2, 10);
INSERT INTO frequencia VALUES(8, 2, 2, 9);
INSERT INTO frequencia VALUES(8, 3, 2, 11);
INSERT INTO frequencia VALUES(8, 1, 6, 12);
INSERT INTO frequencia VALUES(8, 2, 6, 11);
INSERT INTO frequencia VALUES(8, 3, 6, 13);
INSERT INTO frequencia VALUES(9, 1, 2, 19);
INSERT INTO frequencia VALUES(9, 2, 2, 19);
INSERT INTO frequencia VALUES(9, 3, 2, 20);
INSERT INTO frequencia VALUES(9, 1, 4, 18);
INSERT INTO frequencia VALUES(9, 2, 4, 20);
INSERT INTO frequencia VALUES(9, 3, 4, 19);
INSERT INTO frequencia VALUES(9, 1, 6, 17);
INSERT INTO frequencia VALUES(9, 2, 6, 19);
INSERT INTO frequencia VALUES(9, 3, 6, 19);
INSERT INTO frequencia VALUES(10, 1, 1, 18);
INSERT INTO frequencia VALUES(10, 2, 1, 18);
INSERT INTO frequencia VALUES(10, 3, 1, 19);
INSERT INTO frequencia VALUES(10, 1, 3, 19);
INSERT INTO frequencia VALUES(10, 2, 3, 19);
INSERT INTO frequencia VALUES(10, 3, 3, 20);
INSERT INTO frequencia VALUES(10, 1, 5, 19);
INSERT INTO frequencia VALUES(10, 2, 5, 18);
INSERT INTO frequencia VALUES(10, 3, 5, 19);
INSERT INTO frequencia VALUES(11, 1, 1, 17);
INSERT INTO frequencia VALUES(11, 2, 1, 18);
INSERT INTO frequencia VALUES(11, 3, 1, 18);
INSERT INTO frequencia VALUES(11, 1, 4, 19);
INSERT INTO frequencia VALUES(11, 2, 4, 18);
INSERT INTO frequencia VALUES(11, 3, 4, 18);
INSERT INTO frequencia VALUES(11, 1, 6, 19);
INSERT INTO frequencia VALUES(11, 2, 6, 19);
INSERT INTO frequencia VALUES(11, 3, 6, 19);

INSERT INTO area VALUES(1, 'ciencias', NULL, 'geral');
INSERT INTO area VALUES(2, 'informatica', NULL, 'tecnologico');
INSERT INTO area VALUES(3, 'saude', NULL, 'geral');

INSERT INTO turma VALUES(1, '10A', 10, 1, 1);
INSERT INTO turma VALUES(2, '11B', 11, 2, 1);
INSERT INTO turma VALUES(3, '12C', 12, 3, 1);

INSERT INTO diretor VALUES(1, 4, 2, '2012-09-23', NULL);
INSERT INTO diretor VALUES(2, 5, 1, '2012-09-23', NULL);
INSERT INTO diretor VALUES(3, 12, 3, '2012-09-23', NULL);

INSERT INTO coordenador VALUES(1, 6, 2, '2012-09-23', NULL);
INSERT INTO coordenador VALUES(2, 5, 1, '2012-09-23', NULL);

INSERT INTO inscricao VALUES(1, 1, 1, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(2, 2, 1, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(3, 3, 2, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(4, 8, 2, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(5, 9, 2, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(6, 10, 3, '2012-09-23', NULL);
INSERT INTO inscricao VALUES(7, 11, 3, '2012-09-23', NULL);

INSERT INTO aptidao VALUES(4, 1);
INSERT INTO aptidao VALUES(4, 2);
INSERT INTO aptidao VALUES(6, 1);
INSERT INTO aptidao VALUES(5, 1);

INSERT INTO docencia VALUES(1, 1, 1, 4, '2012-09-23', NULL);
INSERT INTO docencia VALUES(2, 2, 1, 4, '2012-09-23', NULL);
INSERT INTO docencia VALUES(3, 3, 2, 5, '2012-09-23', NULL);
INSERT INTO docencia VALUES(4, 4, 2, 6, '2012-09-23', NULL);
INSERT INTO docencia VALUES(5, 5, 3, 12, '2012-09-23', NULL);
INSERT INTO docencia VALUES(6, 6, 3, 13, '2012-09-23', NULL);


