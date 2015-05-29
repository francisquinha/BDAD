
DROP TRIGGER IF EXISTS caduca_coordenador;
DROP TRIGGER IF EXISTS caduca_diretor;
DROP TRIGGER IF EXISTS caduca_inscricao;
DROP TRIGGER IF EXISTS caduca_responsavel;
DROP TRIGGER IF EXISTS caduca_docencia;
DROP TRIGGER IF EXISTS media_max_num;

CREATE TRIGGER caduca_coordenador
AFTER INSERT ON coordenador 
FOR EACH ROW
BEGIN
UPDATE coordenador SET data_fim = date(NEW.data_ini, '-1 day') WHERE data_fim = NULL;
END;

CREATE TRIGGER caduca_diretor
AFTER INSERT ON diretor 
FOR EACH ROW
BEGIN
	UPDATE diretor SET data_fim = date(NEW.data_ini, '-1 day') WHERE data_fim = NULL;
END;

CREATE TRIGGER caduca_inscricao
AFTER INSERT ON inscricao 
FOR EACH ROW
BEGIN
	UPDATE inscricao SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

CREATE TRIGGER caduca_responsavel
AFTER INSERT ON responsavel 
FOR EACH ROW
BEGIN
	UPDATE responsavel SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

CREATE TRIGGER caduca_docencia
AFTER INSERT ON docencia 
FOR EACH ROW
BEGIN
	UPDATE docencia SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

CREATE TRIGGER media_max_num
AFTER INSERT ON frequencia
FOR EACH ROW
WHEN ((SELECT numero
	   FROM periodo
	   WHERE periodo.id_periodo = NEW.id_periodo) = 3
   	  AND NEW.classificacao >= 10)
BEGIN
	UPDATE aluno SET media = media * num_disc_feitas WHERE aluno.id_aluno = NEW.id_aluno;	
	UPDATE aluno SET num_disc_feitas = num_disc_feitas + 1 WHERE aluno.id_aluno = NEW.id_aluno;
	UPDATE aluno SET media = round((media  + NEW.classificacao) / num_disc_feitas, 2) WHERE aluno.id_aluno = NEW.id_aluno;
	UPDATE aluno SET max_nota = NEW.classificacao WHERE aluno.id_aluno = NEW.id_aluno AND aluno.max_nota < NEW.classificacao;
END;
