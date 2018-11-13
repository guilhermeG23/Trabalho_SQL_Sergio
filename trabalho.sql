#Guilherme Rodrigo Brechot Nº341901 SQL

#trabalho valendo 2 pontos sql

create database BookStore;

use BookStore;

create table Ende(
	CEP varchar(9) primary key not null,
	Rua varchar(50) not null,
	Bairro varchar(30) not null
);

insert Ende values ("12345-123", "Padre Amaro", "Lapa"),
("12345-999", "Leopoldina", "Centro"),
("54321-123", "Tiradentes", "Centro"),
("12345-888", "São Francisco", "Brás"),
("99999-123", "Marechal Deodoro", "Santo Amaro"),
("99999-111", "da Paz", "Santo Amaro"),
("22222-999", "Tabuias", "Moema"),
("33333-123", "Mirante", "Pirituba"),
("33333-999", "13 de Maio", "Paulista"),
("44444-123", "Whashington Luiz", "Jardins"),
("44444-111", "Francisco Xavier", "Ibirapuera"),
("55555-999", "MMDC", "Centro"),
("55555-123", "do Comerciario", "Ibirapuera"),
("66666-999", "Princesa Isabel", "Brás"),
("77777-123", "do Mirante", "Morumbi"),
("88888-111", "Jose Paulino", "Santo Amaro");

create table Editora(
	Cod int primary key auto_increment,
	Nome varchar(30) not null,
	EndCEP varchar(9) not null,
	Numero int not null,
	foreign key(EndCEP) references Ende(CEP)
);

insert Editora values (0, "LiveBooks", "12345-123", 100),
(0, "SuperTech", "54321-123", 1125),
(0, "Saber", "99999-123", 300),
(0, "BooksNets", "99999-111", 325);

create table Cliente(
	Id int primary key auto_increment,
	Nome varchar(30) not null,
	EndCEP varchar(9) not null,
	Numero int not null,
	foreign key(EndCEP) references Ende(CEP)
);

insert Cliente values (0, "João do Caminhão", "44444-111", 250),
(0, "Batman", "88888-111", 1100),
(0, "Kiko", "77777-123", 739),
(0, "Sr. Madruga", "66666-999", 401),
(0, "Mario do Armario", "99999-111", 1500),
(0, "Dunha da Unha", "44444-123", 2345),
(0, "Jerry", "12345-999", 10),
(0, "Jack", "33333-999", 19),
(0, "Harry", "99999-123", 555),
(0, "Hermione", "66666-999", 909),
(0, "Jair Bolsonaro", "33333-999", 1599),
(0, "Haddad", "66666-999", 13);

create table Livro(
	ISBN bigint primary key,
	Nome varchar(30) not null,
	EditoraCod int not null,
	Preco decimal(7,2) not null,
	foreign key(EditoraCod) references Editora(Cod)
);

insert Livro values (123456, "A arte da Guerra", 1, 19.99),
(111111, "Ponto de Impacto", 1, 29.99),
(222222, "O código Da Vinci", 1, 29.99),
(333333, "O Símbolo Perdido", 1, 29.99),
(444444, "Inferno", 1, 29.99),
(555555, "Fortaleza Digital", 1, 29.99),
(666666, "O alquimista", 2, 15.00),
(777777, "Onze minutos", 2, 15.00),
(888888, "Brida", 2, 15.00),
(999999, "Veronika decide morrer", 2, 15.00),
(112211, "Diario de um mago", 2, 15.00),
(223344, "Qual a sua obra?", 2, 29.99),(554433, "Etica vegonha na casa", 2, 29.99),
(665544, "A sorte segue a coragem", 2, 19.99),
(992288, "por que fazemos o que fazemos?", 2, 19.99),
(662299, "A escola do conhecimento", 2, 19.99),
(119966, "Pensar bem nos faz bem", 2, 19.99),
(555566, "Alice - Coleção", 3, 150.00),
(909090, "O magico de Oz", 3, 89.99),
(373737, "Java", 4, 59.99),
(616161, "MySql", 4, 49.99),
(838383, "Linguagem C", 4, 49.99),
(104344, "Algoritmos", 4, 39.99);

create table Estoque(
	Num int primary key auto_increment,
	LivroISBN bigint not null,
	Qtd int not null,
	foreign key(LivroISBN) references Livro(ISBN)
);

insert Estoque values (0, 123456, 20),
(0, 111111, 20),
(0, 222222, 15),
(0, 333333, 10),
(0, 444444, 15),
(0, 555555, 20),
(0, 666666, 10),
(0, 777777, 15),
(0, 888888, 20),
(0, 999999, 10),
(0, 112211, 15),
(0, 223344, 20),
(0, 554433, 15),
(0, 665544, 10),	
(0, 992288, 15),
(0, 662299, 20),
(0, 119966, 10),
(0, 555566, 15),
(0, 909090, 20),
(0, 373737, 10),
(0, 616161, 10),
(0, 838383, 15),
(0, 104344, 20);

create table Carrinho(
	Codigo int primary key auto_increment,
	ClienteId int not null,
	LivroISBN bigint not null,
	Qtd int not null,
	foreign key(ClienteId) references Cliente(Id),
	foreign key(LivroISBN) references Livro(ISBN)
);

insert Carrinho values (0, 1, 123456, 1),
(0, 2, 111111, 1),
(0, 3, 909090, 1),
(0, 4, 777777, 2),
(0, 5, 554433, 1),
(0, 6, 665544, 1),
(0, 7, 555566, 2),
(0, 8, 444444, 1),
(0, 9, 119966, 1),
(0, 10, 373737, 2);

#1
select Cliente.Nome, Livro.Nome from Livro, Cliente, Carrinho where Carrinho.ClienteId = Cliente.Id and Carrinho.LivroISBN = Livro.ISBN and Livro.EditoraCod in (select Cod from Editora where Nome = "BooksNets");

+----------+------+
| Nome     | Nome |
+----------+------+
| Hermione | Java |
+----------+------+

#2
select Livro.Nome from Livro where Livro.ISBN not in (select LivroISBN from Carrinho);

+--------------------------------+
| Nome                           |
+--------------------------------+
| Algoritmos                     |
| Diario de um mago              |
| O código Da Vinci              |
| Qual a sua obra?               |
| O Símbolo Perdido              |
| Fortaleza Digital              |
| MySql                          |
| A escola do conhecimento       |
| O alquimista                   |
| Linguagem C                    |
| Brida                          |
| por que fazemos o que fazemos? |
| Veronika decide morrer         |
+--------------------------------+

#3
select Editora.Nome, Livro.Nome, Livro.Preco, Estoque.Qtd from Livro, Editora, Estoque where Livro.ISBN = Estoque.LivroISBN and Livro.EditoraCod = Editora.Cod order by Livro.Nome asc;

+-----------+--------------------------------+--------+-----+
| Nome      | Nome                           | Preco  | Qtd |
+-----------+--------------------------------+--------+-----+
| LiveBooks | A arte da Guerra               |  19.99 |  20 |
| SuperTech | A escola do conhecimento       |  19.99 |  20 |
| SuperTech | A sorte segue a coragem        |  19.99 |  10 |
| BooksNets | Algoritmos                     |  39.99 |  20 |
| Saber     | Alice - Coleção                | 150.00 |  15 |
| SuperTech | Brida                          |  15.00 |  20 |
| SuperTech | Diario de um mago              |  15.00 |  15 |
| SuperTech | Etica vegonha na casa          |  29.99 |  15 |
| LiveBooks | Fortaleza Digital              |  29.99 |  20 |
| LiveBooks | Inferno                        |  29.99 |  15 |
| BooksNets | Java                           |  59.99 |  10 |
| BooksNets | Linguagem C                    |  49.99 |  15 |
| BooksNets | MySql                          |  49.99 |  10 |
| SuperTech | O alquimista                   |  15.00 |  10 |
| LiveBooks | O código Da Vinci              |  29.99 |  15 |
| Saber     | O magico de Oz                 |  89.99 |  20 |
| LiveBooks | O Símbolo Perdido              |  29.99 |  10 |
| SuperTech | Onze minutos                   |  15.00 |  15 |
| SuperTech | Pensar bem nos faz bem         |  19.99 |  10 |
| LiveBooks | Ponto de Impacto               |  29.99 |  20 |
| SuperTech | por que fazemos o que fazemos? |  19.99 |  15 |
| SuperTech | Qual a sua obra?               |  29.99 |  20 |
| SuperTech | Veronika decide morrer         |  15.00 |  10 |
+-----------+--------------------------------+--------+-----+


#4
select Cliente.Nome from Cliente where Id not in (select ClienteId from Carrinho);

+----------------+
| Nome           |
+----------------+
| Jair Bolsonaro |
| Haddad         |
+----------------+

#5
#Desenvolva um script que retorne, o código da compra, o nome do cliente, o endereço, o número da casa, o nome do livro, e o valor do livro.

select Carrinho.Codigo, Cliente.Nome, Ende.Rua, Cliente.Numero, Livro.Nome, Livro.Preco
from Carrinho, Cliente, Ende, Livro where Carrinho.LivroISBN = Livro.ISBN and Carrinho.ClienteId = Cliente.Id
and Cliente.EndCEP = Ende.CEP and Carrinho.LivroISBN = Livro.ISBN;

+--------+--------------------+------------------+--------+-------------------------+--------+
| Codigo | Nome               | Rua              | Numero | Nome                    | Preco  |
+--------+--------------------+------------------+--------+-------------------------+--------+
|      1 | João do Caminhão   | Francisco Xavier |    250 | A arte da Guerra        |  19.99 |
|      2 | Batman             | Jose Paulino     |   1100 | Ponto de Impacto        |  29.99 |
|      3 | Kiko               | do Mirante       |    739 | O magico de Oz          |  89.99 |
|      4 | Sr. Madruga        | Princesa Isabel  |    401 | Onze minutos            |  15.00 |
|      5 | Mario do Armario   | da Paz           |   1500 | Etica vegonha na casa   |  29.99 |
|      6 | Dunha da Unha      | Whashington Luiz |   2345 | A sorte segue a coragem |  19.99 |
|      7 | Jerry              | Leopoldina       |     10 | Alice - Coleção         | 150.00 |
|      8 | Jack               | 13 de Maio       |     19 | Inferno                 |  29.99 |
|      9 | Harry              | Marechal Deodoro |    555 | Pensar bem nos faz bem  |  19.99 |
|     10 | Hermione           | Princesa Isabel  |    909 | Java                    |  59.99 |
+--------+--------------------+------------------+--------+-------------------------+--------+


#6 
#Desenvolva uma function que retorne o valor total de cada compra feita na livraria.
create function fn_valor_carrinho (quantidade int, preco decimal(10.2)) returns decimal return (quantidade * preco);

#7 
#Mostre a 6 funcinonado
#que retorne o nome do cliente e o valor a pagar.
select Cliente.Nome, fn_valor_carrinho(Carrinho.Qtd, Livro.Preco) as "Valor a pagar" from Cliente, Carrinho, Livro where Carrinho.LivroISBN = Livro.ISBN and Carrinho.ClienteId = Cliente.Id;

+--------------------+---------------+
| Nome               | Valor a pagar |
+--------------------+---------------+
| João do Caminhão   |            20 |
| Batman             |            30 |
| Kiko               |            90 |
| Sr. Madruga        |            30 |
| Mario do Armario   |            30 |
| Dunha da Unha      |            20 |
| Jerry              |           300 |
| Jack               |            30 |
| Harry              |            20 |
| Hermione           |           120 |
+--------------------+---------------+

#8
create function fn_valor_total (quantidade int, preco decimal(10.2)) returns decimal return (quantidade * preco);

#9
select Livro.Nome, fn_valor_total(Estoque.Qtd, Livro.Preco) as "valor de estoque" from Livro, Estoque where Livro.ISBN = Estoque.LivroISBN;

+--------------------------------+------------------+
| Nome                           | valor de estoque |
+--------------------------------+------------------+
| Algoritmos                     |              800 |
| Ponto de Impacto               |              600 |
| Diario de um mago              |              225 |
| Pensar bem nos faz bem         |              200 |
| A arte da Guerra               |              400 |
| O código Da Vinci              |              450 |
| Qual a sua obra?               |              600 |
| O Símbolo Perdido              |              300 |
| Java                           |              600 |
| Inferno                        |              450 |
| Etica vegonha na casa          |              450 |
| Fortaleza Digital              |              600 |
| Alice - Coleção                |             2250 |
| MySql                          |              500 |
| A escola do conhecimento       |              400 |
| A sorte segue a coragem        |              200 |
| O alquimista                   |              150 |
| Onze minutos                   |              225 |
| Linguagem C                    |              750 |
| Brida                          |              300 |
| O magico de Oz                 |             1800 |
| por que fazemos o que fazemos? |              300 |
| Veronika decide morrer         |              150 |
+--------------------------------+------------------+

#10
select sum(fn_valor_total(Estoque.Qtd, Livro.Preco)) as "valor total de estoque" from Livro, Estoque where Livro.ISBN = Estoque.LivroISBN;

+------------------------+
| valor total de estoque |
+------------------------+
|                  12700 |
+------------------------+

#11
#) Desenvolva um procedimento armazenado para aumentar o valor dos livros em 10%
#aumenta
create procedure proc_aumento_dezp(entrada int, editora int) update Livro set Livro.Preco = ((entrada * (Livro.Preco / 100)) + Livro.Preco) where Livro.EditoraCod = editora;
#Diminui

#12
call proc_aumento_dezp(10, 4);
select Livro.Nome, Livro.Preco from Livro where EditoraCod = 4;

+-------------+-------+
| Nome        | Preco |
+-------------+-------+
| Algoritmos  | 43.99 |
| Java        | 65.99 |
| MySql       | 54.99 |
| Linguagem C | 54.99 |
+-------------+-------+

#13
#Desenvolva um procedimento armazenado que exclua um cliente dado o seu nome.

delimiter $$
create procedure proc_deletar_cliente(nome_cliente varchar(30))		
    begin
	    delete from Carrinho where Carrinho.ClienteId in (select Cliente.Id from Cliente where Cliente.Nome = nome_cliente);
	    delete from Cliente where Cliente.Nome = nome_cliente;
	end
$$
delimiter ;

call proc_deletar_cliente("Batman");

+----+--------------------+-----------+--------+
| Id | Nome               | EndCEP    | Numero |
+----+--------------------+-----------+--------+
|  1 | João do Caminhão   | 44444-111 |    250 |
|  3 | Kiko               | 77777-123 |    739 |
|  4 | Sr. Madruga        | 66666-999 |    401 |
|  5 | Mario do Armario   | 99999-111 |   1500 |
|  6 | Dunha da Unha      | 44444-123 |   2345 |
|  7 | Jerry              | 12345-999 |     10 |
|  8 | Jack               | 33333-999 |     19 |
|  9 | Harry              | 99999-123 |    555 |
| 10 | Hermione           | 66666-999 |    909 |
| 11 | Jair Bolsonaro     | 33333-999 |   1599 |
| 12 | Haddad             | 66666-999 |     13 |
+----+--------------------+-----------+--------+


#14
call proc_deletar_cliente("Haddad");

+----+--------------------+-----------+--------+
| Id | Nome               | EndCEP    | Numero |
+----+--------------------+-----------+--------+
|  1 | João do Caminhão   | 44444-111 |    250 |
|  3 | Kiko               | 77777-123 |    739 |
|  4 | Sr. Madruga        | 66666-999 |    401 |
|  5 | Mario do Armario   | 99999-111 |   1500 |
|  6 | Dunha da Unha      | 44444-123 |   2345 |
|  7 | Jerry              | 12345-999 |     10 |
|  8 | Jack               | 33333-999 |     19 |
|  9 | Harry              | 99999-123 |    555 |
| 10 | Hermione           | 66666-999 |    909 |
| 11 | Jair Bolsonaro     | 33333-999 |   1599 |
+----+--------------------+-----------+--------+

#15
delimiter $$
create trigger debito_estoque after insert
	ON Carrinho
	FOR EACH ROW
	begin
		update Estoque set Estoque.Qtd = Estoque.Qtd - new.Qtd where Estoque.LivroISBN = new.LivroISBN;
	end 
$$
delimiter ;

#16
mysql> select * from Estoque;
+-----+-----------+-----+
| Num | LivroISBN | Qtd |
+-----+-----------+-----+
|   1 |    123456 |  20 |
|   2 |    111111 |  20 |
|   3 |    222222 |  15 |
|   4 |    333333 |  10 |
|   5 |    444444 |  15 |
|   6 |    555555 |  20 |
|   7 |    666666 |  10 |
|   8 |    777777 |  15 |
|   9 |    888888 |  20 |
|  10 |    999999 |  10 |
|  11 |    112211 |  15 |
|  12 |    223344 |  20 |
|  13 |    554433 |  15 |
|  14 |    665544 |  10 |
|  15 |    992288 |  15 |
|  16 |    662299 |  20 |
|  17 |    119966 |  10 |
|  18 |    555566 |  15 |
|  19 |    909090 |  20 |
|  20 |    373737 |  10 |
|  21 |    616161 |  10 |
|  22 |    838383 |  15 |
|  23 |    104344 |  20 |
+-----+-----------+-----+

#valores
insert into Carrinho values (default, 1, 616161, 5);
insert into Carrinho values (default, 1, 123456, 1);
insert into Carrinho values (default, 1, 555566, 4);
insert into Carrinho values (default, 1, 119966, 2);
insert into Carrinho values (default, 1, 112211, 3);

#Apos

#17
#Os livros são debitados do estoque atual da tabela estoque

mysql> select * from Estoque;
+-----+-----------+-----+
| Num | LivroISBN | Qtd |
+-----+-----------+-----+
|   1 |    123456 |  19 |
|   2 |    111111 |  20 |
|   3 |    222222 |  15 |
|   4 |    333333 |  10 |
|   5 |    444444 |  15 |
|   6 |    555555 |  20 |
|   7 |    666666 |  10 |
|   8 |    777777 |  15 |
|   9 |    888888 |  20 |
|  10 |    999999 |  10 |
|  11 |    112211 |  12 |
|  12 |    223344 |  20 |
|  13 |    554433 |  15 |
|  14 |    665544 |  10 |
|  15 |    992288 |  15 |
|  16 |    662299 |  20 |
|  17 |    119966 |   8 |
|  18 |    555566 |  11 |
|  19 |    909090 |  20 |
|  20 |    373737 |  10 |
|  21 |    616161 |   5 |
|  22 |    838383 |  15 |
|  23 |    104344 |  20 |
+-----+-----------+-----+

#18 Desenvolva um gatilho para fazer backup da tabela a sua escolha.

create table Bk_Carrinho (
	Codigo int(11) not null primary key,
	ClienteId int(11) not null,
	LivroISBN bigint(20) not null,
	Qtd int(11) not null
);

#Deleta do carrinho e joga para ca
delimiter $$
create trigger Bk_Carrinho_delete after delete 
	ON Carrinho
	FOR EACH ROW
	begin
	insert into Bk_Carrinho values (old.Codigo, old.ClienteId, old.LivroISBN, old.Qtd);
	end 
$$
delimiter ;

#19
/*
Desenvolva uma tabela que ao entrar um registro na tabela Livro, dispare um gatilho para
essa tabela, em que deve ser registrado:
Valor da parcela em 3X: Deve ser acrescido 10%.
Valor da parcela em 6X: Deve ser acrescido 15%.
Valor da parcela em 12X: Deve ser acrescido 20%.
Valor a vista: Deve ser concedido um desconto de 12%.
*/

create table Precos_Div_Livros(
	ISBN bigint(20) not null,
	PrecoVista decimal(10,2) not null,
	Preco3x decimal(10,2) not null,
	Preco6x decimal(10,2) not null,
	Preco12x decimal(10,2) not null
);

delimiter $$
create trigger Preco_Livros after insert 
	ON Livro
	FOR EACH ROW
	begin
		insert into Precos_Div_Livros values (new.ISBN, (new.Preco - (12 * (new.Preco / 100))), (new.Preco + (10 * (new.Preco / 100))), (new.Preco + (15 * (new.Preco / 100))), (new.Preco + (20 * (new.Preco / 100))));
	end 
$$
delimiter ;

#20
#20) Insira dois livros (livre).

insert into Livro values (141262, "teste", 4, 50.00);
insert into Livro values (141272, "teste", 4, 40.00);

#21
#21) Confira se os valores estão corretos na tabela desenvolvida na questão 19.

#baterao
#Saida
+--------+------------+---------+---------+----------+
| ISBN   | PrecoVista | Preco3x | Preco6x | Preco12x |
+--------+------------+---------+---------+----------+
| 141252 |      43.99 |   54.99 |   57.49 |    59.99 |
| 141262 |      44.00 |   55.00 |   57.50 |    60.00 |
| 141272 |      35.20 |   44.00 |   46.00 |    48.00 |
+--------+------------+---------+---------+----------+
