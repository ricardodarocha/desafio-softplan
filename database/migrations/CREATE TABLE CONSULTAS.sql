--  em cumprimento ao requisito US 1.1 Criar uma tabela em um banco de dados de sua escolha onde possa ser
armazenado os resultados das consultas.

drop table if exists consultas;
create table consultas (
   codigo integer not null primary key autoincrement,
   cep varchar(20),
   logradouro varchar(255),
   complemento varchar(255),
   bairro varchar(255),
   localidade varchar(255),
   uf varchar(2),
   logradouro_ varchar(255),
   localidade_ varchar(255)
)