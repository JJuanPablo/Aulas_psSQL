CREATE TABLE clients (
	idclient SERIAL PRIMARY KEY,
	cpf varchar(14),
	firstname text,
	lastname text,
	address text
);

CREATE TABLE products (
	idproduct SERIAL PRIMARY KEY,
	idclient int,
	CONSTRAINT fk_client FOREIGN KEY (idclient) REFERENCES clients (idclient),
	productname varchar(50),
	brand varchar(20),
	category varchar(20),
	discount numeric,
	price numeric
);

INSERT INTO clients (cpf,firstname,lastname,address) VALUES
('000.000.000-00','Rodrigo','Junior','Rua 00, 000, Bairro 0'),
('111.111.111-11','Joao','Silva','Rua 01, 100, Bairro 1'),
('222.222.222-22','Maria','Gomez','Rua 02, 200, Bairro 2'),
('333.333.333-33','José','Andrade','Rua 03, 300, Bairro 3'),
('444.444.444-44','Bruno','Silveira','Rua 04, 400, Bairro 4'),
('555.555.555-55','Ana','Cabral','Rua 05, 500, Bairro 5'),
('666.666.666-66','Lucia','Silva','Rua 06, 600, Bairro 6'),
('777.777.777-77','Antonio','Mange','Rua 07, 700, Bairro 7'),
('888.888.888-88','Nicolas','Silva','Rua 08, 800, Bairro 8'),
('999.999.999-99','Sandra','Fourlan','Rua 09, 900, Bairro 9');

INSERT INTO products (idclient,productname,brand,category,discount,price) VALUES
(2,'Headset','jbl','eletronicos',0.1,195.89),
(1,'notebook','dell','eletronicos',0.12,3500.00),
(10,'cadeira gammer','dragon','imobiliario',0.0,1630.9),
(2,'mesa para computador','dragon','imobiliario',0.0,695.89),
(1,'mouse','dell','eletronicos',0.12,124.79),
(3,'prateleira',null,'imobiliario',0.0,80.9),
(5,'postit','faber castel','papelaria',0.02,5.29);


--Comandos DQL (Data query Language)

--Visualizando a tabela de clientes
SELECT * FROM products

--Selecionando colunas especificas
SELECT productname, brand, price, discount, price*discount AS "Disconto em reais" FROM products

-- Desafio: Exibir nome do prodto, preço e preço com desconto
SELECT productname, price, price - price * discount AS "Preço com desconto" FROM products

-- Exibe valores sem repetição
SELECT DISTINCT brand FROM products

-- Calculadora
SELECT ||/27

-- Funções
SELECT random()

-- SELECT com clausula WHERE

-- Operadores de comparação >,<,>=,<=,=,<> ou !=
-- Exibir produtos com valor acima de 100 reais
SELECT productname, price FROM products WHERE price >= 100

--  Operadores lógicos: AND, OR e NOT

-- Produtos entre 100 e 800 reais
SELECT productname, price FROM products WHERE price >=100 AND price <=800

-- Produtos cujo preço esteja abaixo de 100 e acima de 800
SELECT productname, price FROM products WHERE price <=100 OR price >=800

-- Alternativa para entre um preço
SELECT productname, price FROM products WHERE price BETWEEN 100 AND 800

-- DESAFIO: listar todos os produtos da marca DELL
SELECT productname, brand FROM products WHERE brand = 'dell'

-- Desafio: listar todos os produtos comprados por João
SELECT * FROM products WHERE idclient = (SELECT idclient FROM clients WHERE firstname = 'Joao')

-- Desafio: listar todos os clientes com id par
SELECT * FROM clients WHERE idclient %2 = 0

-- COUNT
-- Quantos produtos foram vendidos no total?
SELECT COUNT(idproduct) FROM products

-- Função AVG (Média)
-- Qual o preço médio dos produtos vendidos?
SELECT AVG (price) FROM products

-- Função MAX (máximo)
-- Qual o preço mais alto negociado?
SELECT MAX (price) FROM products

-- Função MIN (mínimo)
-- Qual o preço mais baixo negociado?
SELECT MIN (price) FROM products

-- Função SUM (Soma)
-- Qual o valor total vendido?
SELECT SUM (price) FROM products

-- ORDER BY / DESC
SELECT * FROM clients ORDER BY lastname DESC

-- Exercícios:

-- 1. Quantos produtos da marca dell foram vendidos?

SELECT COUNT (brand) FROM products
WHERE brand = 'dell'

-- 2. Quantos produtos João comprou?
SELECT COUNT (idproduct) FROM products 
WHERE idclient = (SELECT idclient FROM clients WHERE firstname = 'Joao')

-- 3. Qual o preço médio dos produtos da dell?
SELECT AVG (price) FROM products 
WHERE brand = 'dell'

-- 4. Qual o produto mais caro vendido?
SELECT productname, price FROM products 
WHERE price = (SELECT MAX (price) FROM products)

-- 5. Qual o produto mais barato vendido?
SELECT productname, price FROM products 
WHERE price = (SELECT MIN (price) FROM products)

-- 6. Qual o valor total de equipamentos dell vendidos?
SELECT SUM (price) FROM products 
WHERE brand = 'dell'

-- 7. Quanto Rodrigo já gastou no eCommerce?
SELECT SUM (price) FROM products 
WHERE idclient = (SELECT idclient FROM clients WHERE firstname = 'Rodrigo')

-- 8. Exiba todos os produtos da catergoria eletronicos ordenados do mais barato para o mais caro.
SELECT productname, price FROM products 
WHERE category = 'eletronicos' 
ORDER BY (price)

-- 9. Exiba todos os produtos comprados por Rodrigo ordenados do mais caro para o mais barato.
SELECT * FROM products 
WHERE idclient = (SELECT idclient FROM clients WHERE firstname = 'Rodrigo')
ORDER BY (price) DESC

-- Cross join

SELECT * FROM clients,products
SELECT * FROM products,clients
SELECT * FROM clients CROSS JOIN products

-- Inner join (relaciona por PK/FK)
SELECT * FROM clients INNER JOIN products
ON clients.idclient = products.idclient
WHERE firstname = 'Rodrigo' OR firstname = 'rodrigo'

SELECT * FROM clients INNER JOIN products USING (idclient)

SELECT * FROM clients NATURAL INNER JOIN products

SELECT clients.firstname, products.productname
FROM clients LEFT JOIN products USING (idclient)

SELECT clients.firstname, products.productname
FROM clients RIGHT JOIN products USING (idclient)

SELECT clients.firstname, products.productname
FROM clients FULL JOIN products USING (idclient)

--Exercicios:

--1. Quais clientes compraram produtos da categoria eletrônicos?
SELECT clients.firstname, clients.lastname, products.productname, products.category FROM clients INNER JOIN products USING (idclient)
WHERE products.category = 'eletronicos'

--2. Quais clientes não compraram nenhum produto?
SELECT clients.firstname, clients.lastname FROM clients LEFT JOIN products USING (idclient)
WHERE products.idproduct IS null

--3. Quais produtos não foram vendidos?
SELECT products.productname FROM clients RIGHT JOIN products USING (idclient)
WHERE clients.firstname IS null


-- Inserindo produtos novos
INSERT INTO products (productname,brand,category,discount,price) VALUES
('Escova','Colgate','saude bucal',0.1,10.00),
('Colher','Tramontina','cozinha',0.12,5.00);

-- 4. Quais produtos Rodrigo comprou?
SELECT clients.firstname, products.productname FROM clients RIGHT JOIN products USING (idclient)
WHERE clients.firstname = 'Rodrigo'

-- 5. Quais clientes compraram produtos da marca DELL?
SELECT clients.firstname, products.productname, products.brand FROM clients RIGHT JOIN products USING (idclient)
WHERE products.brand = 'dell'