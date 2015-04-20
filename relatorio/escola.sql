.mode column
.headers on

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS localidade;

CREATE TABLE localidade (
id_localidade INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
nome VARCHAR NOT NULL );

DROP TABLE IF EXISTS codigo_postal;

CREATE TABLE codigo_postal (
id_cod_postal INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
numero VARCHAR NOT NULL ,
id_localidade INTEGER NOT NULL ,
FOREIGN KEY(id_localidade) REFERENCES localidade(id_localidade));

DROP TABLE IF EXISTS pessoa;

CREATE TABLE pessoa (
id_pessoa INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
numero VARCHAR, 
nome VARCHAR NOT NULL , 
bi DOUBLE, 
nif DOUBLE, 
morada VARCHAR NOT NULL , 
data_nasc DATETIME NOT NULL , 
telefone VARCHAR, 
telemovel VARCHAR, 
id_cod_postal INTEGER NOT NULL ,
FOREIGN KEY(id_cod_postal) REFERENCES codigo_postal(id_cod_postal));

DROP TABLE IF EXISTS docente;

CREATE TABLE docente (
id_docente INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
ano_admissao INTEGER NOT NULL , 
qualificacoes BLOB NOT NULL ,
id_pessoa INTEGER NOT NULL  UNIQUE ,
FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS aluno;

CREATE TABLE aluno (
id_aluno INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
ano_admissao INTEGER NOT NULL , 
observacoes BLOB ,
media FLOAT ,
max_nota FLOAT ,
id_pessoa INTEGER NOT NULL , 
FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS encarregado;

CREATE TABLE encarregado (
id_encarregado INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
horario_contato VARCHAR ,
id_pessoa INTEGER NOT NULL , 
FOREIGN KEY(id_pessoa) REFERENCES pessoa(id_pessoa));

DROP TABLE IF EXISTS area;

CREATE TABLE area (
id_area INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
nome VARCHAR NOT NULL , 
descricao VARCHAR NOT NULL , 
tipo VARCHAR NOT NULL );

DROP TABLE IF EXISTS coordenador;

CREATE TABLE coordenador (
id_coordenador INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
data_ini DATETIME DEFAULT CURRENT_DATE , 
data_fim DATETIME DEFAULT NULL ,
id_docente INTEGER NOT NULL , 
id_area INTEGER NOT NULL , 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ,
FOREIGN KEY(id_area) REFERENCES area(id_area) ,
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS turma;

CREATE TABLE turma (
id_turma INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
numero VARCHAR NOT NULL , 
ano_escolar VARCHAR NOT NULL ,
id_area INTEGER NOT NULL ,
id_ano_letivo INTEGER NOT NULL ,
FOREIGN KEY(id_area) REFERENCES area(id_area) ,
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo));

DROP TABLE IF EXISTS diretor;

CREATE TABLE diretor (
id_diretor INTEGER PRIMARY KEY  NOT NULL , 
data_ini DATETIME DEFAULT CURRENT_DATE , 
data_fim DATETIME DEFAULT NULL ,
id_docente INTEGER NOT NULL ,
id_turma INTEGER NOT NULL , 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ,
FOREIGN KEY(id_turma) REFERENCES turma(id_turma) ,
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS inscricao;

CREATE TABLE inscricao (
id_inscricao INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
data_ini DATETIME NOT NULL , 
data_fim DATETIME NOT NULL ,
id_aluno INTEGER NOT NULL , 
id_turma INTEGER NOT NULL , 
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno) ,
FOREIGN KEY(id_turma) REFERENCES turma(id_turma) ,
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS responsavel;

CREATE TABLE responsavel (
id_responsavel INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
parentesco VARCHAR NOT NULL , 
data_ini DATETIME DEFAULT CURRENT_DATE , 
data_fim DATETIME DEFAULT NULL ,
id_aluno INTEGER NOT NULL , 
id_encarregado INTEGER NOT NULL , 
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno) ,
FOREIGN KEY(id_encarregado) REFERENCES encarregado(id_encarregado) ,
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS disciplina;

CREATE TABLE disciplina (
id_disciplina INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
codigo VARCHAR NOT NULL , 
nome VARCHAR NOT NULL , 
descricao TEXT ,
id_ano_letivo INTEGER NOT NULL ,
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo));

DROP TABLE IF EXISTS ano_letivo;

CREATE TABLE ano_letivo (
id_ano_letivo INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
data_ini DATETIME NOT NULL , 
data_fim DATETIME NOT NULL ,
CHECK (data_ini < data_fim));

DROP TABLE IF EXISTS periodo;

CREATE TABLE periodo (
id_periodo INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
numero INTEGER NOT NULL , 
data_ini DATETIME NOT NULL , 
data_fim DATETIME NOT NULL ,
id_ano_letivo INTEGER NOT NULL ,
FOREIGN KEY(id_ano_letivo) REFERENCES ano_letivo(id_ano_letivo) ,
CHECK (data_ini < data_fim));

DROP TABLE IF EXISTS frequencia;

CREATE TABLE frequencia (
id_frequencia INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
classificacao FLOAT NOT NULL , 
id_aluno INTEGER NOT NULL ,  
id_periodo INTEGER NOT NULL , 
id_disciplina INTEGER NOT NULL ,
FOREIGN KEY(id_aluno) REFERENCES aluno(id_aluno) ,
FOREIGN KEY(id_periodo) REFERENCES periodo(id_periodo) ,
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina) ,
CHECK (classificacao > 0 AND classificacao <= 20));

DROP TABLE IF EXISTS docencia;

CREATE TABLE docencia (
id_docencia INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
data_ini DATETIME DEFAULT CURRENT_DATE , 
data_fim DATETIME DEFAULT NULL ,
id_disciplina INTEGER NOT NULL ,
id_turma INTEGER NOT NULL ,
id_docente INTEGER NOT NULL ,
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina) ,
FOREIGN KEY(id_turma) REFERENCES turma(id_turma) ,
FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ,
CHECK (data_ini <= data_fim));

DROP TABLE IF EXISTS aptidao;

CREATE TABLE aptidao (
id_docente INTEGER NOT NULL ,
id_disciplina INTEGER NOT NULL ,
PRIMARY KEY (id_docente, id_disciplina) ,
FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ,
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id_disciplina));

DROP TABLE IF EXISTS reuniao;

CREATE TABLE reuniao (
id_reuniao INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL ,
data DATETIME NOT NULL ,
hora DOUBLE NOT NULL,
sala VARCHAR NOT NULL,
id_docente INTEGER NOT NULL ,
id_encarregado INTEGER NOT NULL , 
FOREIGN KEY(id_docente) REFERENCES docente(id_docente) ,
FOREIGN KEY(id_encarregado) REFERENCES encarregado(id_encarregado));
