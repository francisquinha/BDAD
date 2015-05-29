.mode column
.headers on

DROP TABLE IF EXISTS localidade;
CREATE TABLE localidade (
id_localidade INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
nome VARCHAR NOT NULL);

DROP TABLE IF EXISTS codigo_postal;
CREATE TABLE codigo_postal (
id_cod_postal INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
numero VARCHAR NOT NULL,
id_localidade INTEGER NOT NULL,
FOREIGN KEY(id_localidade) REFERENCES localidade(id_localidade));

DROP TABLE IF EXISTS pessoa;
CREATE TABLE pessoa (
id_pessoa INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
numero VARCHAR, 
nome VARCHAR NOT NULL, 
bi INTEGER, 
nif INTEGER, 
morada VARCHAR NOT NULL, 
data_nasc DATETIME NOT NULL, 
telefone VARCHAR, 
telemovel VARCHAR, 
id_cod_postal INTEGER NOT NULL,
FOREIGN KEY(id_cod_postal) REFERENCES codigo_postal(id_cod_postal));

DROP TABLE IF EXISTS docente;
CREATE TABLE docente (
id_docente INTEGER PRIMARY KEY NOT NULL, 
ano_admissao INTEGER NOT NULL, 
qualificacoes TEXT NOT NULL,
FOREIGN KEY(id_docente) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
id_aluno INTEGER PRIMARY KEY NOT NULL, 
ano_admissao INTEGER NOT NULL, 
observacoes TEXT,
media FLOAT DEFAULT 0,
max_nota INTEGER DEFAULT 0,
num_disc_feitas INTEGER DEFAULT 0,
FOREIGN KEY(id_aluno) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS encarregado;
CREATE TABLE encarregado (
id_encarregado INTEGER PRIMARY KEY NOT NULL, 
horario_contato VARCHAR ,
FOREIGN KEY(id_encarregado) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS area;
CREATE TABLE area (
id_area INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
nome VARCHAR NOT NULL, 
descricao VARCHAR NOT NULL, 
tipo VARCHAR NOT NULL);

DROP TABLE IF EXISTS coordenador;
CREATE TABLE coordenador (
id_coordenador INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
data_ini DATETIME DEFAULT CURRENT_DATE, 
data_fim DATETIME DEFAULT NULL,
id_docente INTEGER NOT NULL, 
id_area INTEGER NOT NULL, 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
FOREIGN KEY(id_area) REFERENCES area(id_area),
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS turma;
CREATE TABLE turma (
id_turma INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
numero VARCHAR NOT NULL, 
ano_escolar VARCHAR NOT NULL,
id_area INTEGER NOT NULL,
id_ano_letivo INTEGER NOT NULL,
FOREIGN KEY(id_area) REFERENCES area(id_area),
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo));

DROP TABLE IF EXISTS diretor;
CREATE TABLE diretor (
id_diretor INTEGER PRIMARY KEY NOT NULL, 
data_ini DATETIME DEFAULT CURRENT_DATE, 
data_fim DATETIME DEFAULT NULL,
id_docente INTEGER NOT NULL,
id_turma INTEGER NOT NULL, 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS inscricao;
CREATE TABLE inscricao (
id_inscricao INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
data_ini DATETIME NOT NULL, 
data_fim DATETIME NOT NULL,
id_aluno INTEGER NOT NULL, 
id_turma INTEGER NOT NULL, 
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno),
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS responsavel;
CREATE TABLE responsavel (
id_responsavel INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
parentesco VARCHAR NOT NULL, 
data_ini DATETIME DEFAULT CURRENT_DATE, 
data_fim DATETIME DEFAULT NULL,
id_aluno INTEGER NOT NULL, 
id_encarregado INTEGER NOT NULL, 
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno),
FOREIGN KEY(id_encarregado) REFERENCES encarregado(id_encarregado),
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS disciplina;
CREATE TABLE disciplina (
id_disciplina INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
codigo VARCHAR NOT NULL, 
nome VARCHAR NOT NULL, 
descricao TEXT,
id_ano_letivo INTEGER NOT NULL,
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo));

DROP TABLE IF EXISTS ano_letivo;
CREATE TABLE ano_letivo (
id_ano_letivo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
designacao TEXT NOT NULL, 
data_ini DATETIME NOT NULL, 
data_fim DATETIME NOT NULL,
CHECK (data_ini < data_fim));

DROP TABLE IF EXISTS periodo;
CREATE TABLE periodo (
id_periodo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
numero INTEGER NOT NULL, 
data_ini DATETIME NOT NULL, 
data_fim DATETIME NOT NULL,
id_ano_letivo INTEGER NOT NULL,
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo),
CHECK (data_ini < data_fim));

DROP TABLE IF EXISTS frequencia;
CREATE TABLE frequencia (
id_aluno INTEGER NOT NULL,  
id_periodo INTEGER NOT NULL, 
id_disciplina INTEGER NOT NULL,
classificacao FLOAT NOT NULL,
PRIMARY KEY(id_aluno, id_periodo, id_disciplina),
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno),
FOREIGN KEY(id_periodo) REFERENCES periodo(id_periodo),
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina),
CHECK (classificacao > 0 AND classificacao <= 20));

DROP TABLE IF EXISTS docencia;
CREATE TABLE docencia (
id_docencia INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
data_ini DATETIME DEFAULT CURRENT_DATE, 
data_fim DATETIME DEFAULT NULL,
id_disciplina INTEGER NOT NULL,
id_turma INTEGER NOT NULL,
id_docente INTEGER NOT NULL,
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina),
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS aptidao;
CREATE TABLE aptidao (
id_docente INTEGER NOT NULL,
id_disciplina INTEGER NOT NULL,
PRIMARY KEY (id_docente, id_disciplina),
FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina));

DROP TABLE IF EXISTS reuniao;
CREATE TABLE reuniao (
id_reuniao INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
data DATETIME NOT NULL,
hora DOUBLE NOT NULL,
sala VARCHAR NOT NULL,
id_docente INTEGER NOT NULL,
id_encarregado INTEGER NOT NULL, 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente),
FOREIGN KEY(id_encarregado) REFERENCES encarregado(id_encarregado));

DROP TRIGGER IF EXISTS caduca_coordenador;
CREATE TRIGGER caduca_coordenador
AFTER INSERT ON coordenador 
FOR EACH ROW
BEGIN
UPDATE coordenador SET data_fim = date(NEW.data_ini, '-1 day') WHERE data_fim = NULL;
END;

DROP TRIGGER IF EXISTS caduca_diretor;
CREATE TRIGGER caduca_diretor
AFTER INSERT ON diretor 
FOR EACH ROW
BEGIN
	UPDATE diretor SET data_fim = date(NEW.data_ini, '-1 day') WHERE data_fim = NULL;
END;

DROP TRIGGER IF EXISTS caduca_inscricao;
CREATE TRIGGER caduca_inscricao
AFTER INSERT ON inscricao 
FOR EACH ROW
BEGIN
	UPDATE inscricao SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

DROP TRIGGER IF EXISTS caduca_responsavel;
CREATE TRIGGER caduca_responsavel
AFTER INSERT ON responsavel 
FOR EACH ROW
BEGIN
	UPDATE responsavel SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

DROP TRIGGER IF EXISTS caduca_docencia;
CREATE TRIGGER caduca_docencia
AFTER INSERT ON docencia 
FOR EACH ROW
BEGIN
	UPDATE docencia SET data_fim = NEW.data_ini WHERE data_fim = NULL;
END;

DROP TRIGGER IF EXISTS media_max_num;
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
	UPDATE aluno SET media = (media  + NEW.classificacao) / num_disc_feitas WHERE aluno.id_aluno = NEW.id_aluno;
	UPDATE aluno SET max_nota = NEW.classificacao WHERE aluno.id_aluno = NEW.id_aluno AND aluno.max_nota < NEW.classificacao;
END;