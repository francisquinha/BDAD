
PRAGMA foreign_keys = ON;

INSERT INTO "pessoa" VALUES(1,'AL01','Carlos',102548796,254125789,
	'Rua do Lado Esquerdo','2000-05-05','254789654','323547899',1);
INSERT INTO "pessoa" VALUES(2,'AL02','Joaquim',134548796,254125734,
	'Rua do Lado Direito','2001-06-05','954789654','923547899',2);
INSERT INTO "pessoa" VALUES(3,'AL03','Manuel',434548796,257655734,
	'Rua do Cimo Direito','2000-02-05','954234654','813547899',3);
INSERT INTO "pessoa" VALUES(4,'DC01','Alberto',434548796,257655734,
	'Rua do Cimo Direito','1978-02-05','465478965','962587451',4);
INSERT INTO "pessoa" VALUES(5,'DC02','Custodio',434548796,257655734,
	'Rua do Cimo Esquerdo','1979-02-05','4623478965','962587345',5);
INSERT INTO "pessoa" VALUES(6,'EE01','Baltazar',25478965,12547889,
	'Rua do Lado Esquerdo','1973-02-05','925656541','252587845',1);

INSERT INTO "aluno" VALUES(1,2013,NULL,NULL,NULL,1);
INSERT INTO "aluno" VALUES(2,2013,NULL,NULL,NULL,2);
INSERT INTO "aluno" VALUES(3,2013,NULL,NULL,NULL,3);

INSERT INTO "codigo_postal" VALUES(1,'4100',1);
INSERT INTO "codigo_postal" VALUES(2,'5100',2);
INSERT INTO "codigo_postal" VALUES(3,'4300',3);
INSERT INTO "codigo_postal" VALUES(4,'3600',5);
INSERT INTO "codigo_postal" VALUES(5,'3700',4);

INSERT INTO "docente" VALUES(1,2012,'Portugues, Ingles',4);
INSERT INTO "docente" VALUES(2,2011,'Matematica, Ciencias',5);

INSERT INTO "encarregado" VALUES(1,'10h-11h',6);

INSERT INTO "localidade" VALUES(1,'Porto');
INSERT INTO "localidade" VALUES(2,'Braga');
INSERT INTO "localidade" VALUES(3,'Gaia');
INSERT INTO "localidade" VALUES(4,'Espinho');
INSERT INTO "localidade" VALUES(5,'Famalicao');

INSERT INTO "responsavel" VALUES(1,'Pai','2013-04-20',NULL,1,1);