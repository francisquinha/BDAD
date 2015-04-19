DROP TABLE IF EXISTS "aluno";

CREATE TABLE "aluno" (
"idaluno" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idpessoa" INTEGER NOT NULL , "ano_admissao" INTEGER NOT NULL , 
"observacoes" BLOB
);


DROP TABLE IF EXISTS "area";

CREATE TABLE "area" (
"idarea" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"nome" VARCHAR NOT NULL , 
"descricao" VARCHAR NOT NULL , 
"tipo" VARCHAR NOT NULL 
);


DROP TABLE IF EXISTS "codigopostal";

CREATE TABLE "codigopostal" (
"idcodigopostal" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idlocalidade" INTEGER NOT NULL , 
"numero" VARCHAR NOT NULL 
);


DROP TABLE IF EXISTS "coordenador";

CREATE TABLE "coordenador" (
"idcoordenador" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"iddocente" INTEGER NOT NULL , 
"idarea" INTEGER NOT NULL , 
"data_ini" DATETIME DEFAULT CURRENT_DATE, 
"data_fim" DATETIME DEFAULT CURRENT_DATE
);


DROP TABLE IF EXISTS "diretor";

CREATE TABLE "diretor" (
"iddiretor" INTEGER PRIMARY KEY  NOT NULL , 
"idturma" INTEGER NOT NULL , 
"iddocente" INTEGER NOT NULL 
);


DROP TABLE IF EXISTS "disciplina";

CREATE TABLE "disciplina" (
"iddisciplina" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"codigo" VARCHAR NOT NULL , 
"nome" VARCHAR NOT NULL , 
"descricao" TEXT
);


DROP TABLE IF EXISTS "docente";

CREATE TABLE "docente" (
"iddocente" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idpessoa" INTEGER NOT NULL  UNIQUE , 
"ano_adminssao" INTEGER NOT NULL , 
"qualificacoes" BLOB NOT NULL 
);


DROP TABLE IF EXISTS "encarregado";

CREATE TABLE "encarregado" (
"idencarregado" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idpessoa" INTEGER NOT NULL , 
"horario_contato" VARCHAR
);


DROP TABLE IF EXISTS "inscrito";

CREATE TABLE "inscrito" (
"idinscrito" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idaluno" INTEGER NOT NULL , "idturma" INTEGER NOT NULL , 
"data_ini" DATETIME NOT NULL , 
"data_fim" DATETIME NOT NULL 
);


DROP TABLE IF EXISTS "localidade";

CREATE TABLE "localidade" (
"idlocalidade" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"nome" VARCHAR NOT NULL 
);


INSERT INTO "localidade" VALUES(1,'Porto');
INSERT INTO "localidade" VALUES(2,'Vila Nova de Gaia');
INSERT INTO "localidade" VALUES(3,'Paredes');

INSERT INTO "localidade" VALUES(4,'Esposende');


DROP TABLE IF EXISTS "pessoa";

CREATE TABLE "pessoa" (
"idpessoa" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"numero" VARCHAR, "nome" VARCHAR NOT NULL , 
"bi" DOUBLE, 
"nif" DOUBLE, 
"morada" VARCHAR NOT NULL , 
"data_nasc" DATETIME NOT NULL , 
"telefone" VARCHAR, 
"telemovel" VARCHAR, 
"idcodigopostal" INTEGER NOT NULL 
);


DROP TABLE IF EXISTS "responsavel";

CREATE TABLE "responsavel" (
"idresponsavel" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idaluno" INTEGER NOT NULL , 
"idencarregado" INTEGER NOT NULL , 
"parentesco" VARCHAR NOT NULL , 
"data_ini" DATETIME NOT NULL , 
"data_fim" DATETIME NOT NULL 
);


DROP TABLE IF EXISTS "turma";

CREATE TABLE "turma" (
"idturma" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , 
"idarea" INTEGER NOT NULL , 
"numero" VARCHAR NOT NULL , 
"ano" INTEGER NOT NULL 
);
