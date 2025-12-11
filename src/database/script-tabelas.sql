-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE QueijariaDolores;

USE QueijariaDolores;

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	razao_social VARCHAR(50),
	cnpj CHAR(14),
	codigo_ativacao VARCHAR(50)
) AUTO_INCREMENT = 100;

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
)AUTO_INCREMENT = 200;

CREATE TABLE sala (
	id INT PRIMARY KEY AUTO_INCREMENT,
	tipoQueijo VARCHAR(100),
	descricao VARCHAR(150),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
) AUTO_INCREMENT = 300;

create table Queijaria (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(300),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
) AUTO_INCREMENT = 400;

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    statusS VARCHAR(50),
    fk_sala INT,
    FOREIGN KEY (fk_sala) REFERENCES sala(id),
    CONSTRAINT chkStatus
        CHECK (statusS IN ('funcionando', 'manutenção', 'parado'))
) AUTO_INCREMENT = 500;

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */
CREATE TABLE leitura (
    id INT AUTO_INCREMENT,
    fk_sensor INT,
    dht11_umidade DECIMAL,
    dht11_temperatura DECIMAL,
    momento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_leitura PRIMARY KEY (id, fk_sensor),
    CONSTRAINT fk_leitura_sensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id)
) AUTO_INCREMENT = 600;


INSERT INTO empresa (razao_social, cnpj, codigo_ativacao)
VALUES ('Queijaria Dolores', '12345678000199', 'CODIGO123');

INSERT INTO usuario (nome, email, senha, fk_empresa)
VALUES 
('João Silva', 'joao@queijaria.com', 'senha123', 100),
('Maria Santos', 'maria@queijaria.com', 'senha456', 100);

INSERT INTO sala (tipoQueijo, descricao, fk_empresa)
VALUES
('Queijo Minas', 'Sala para maturação de Queijo Minas', 100),
('Gorgonzola', 'Ambiente controlado para gorgonzola', 100),
('Parmesão', 'Sala climatizada para parmesão', 100);

INSERT INTO sensor (statusS, fk_sala)
VALUES
('funcionando', 300),
('manutenção', 300),
('funcionando', 301),
('parado', 301),
('funcionando', 302);

INSERT INTO leitura (fk_sensor, dht11_umidade, dht11_temperatura)
VALUES 
(500, 55.2, 22.8),
(500, 58.1, 23.4);

INSERT INTO leitura (fk_sensor, dht11_umidade, dht11_temperatura)
VALUES 
(501, 60.5, 21.9);

INSERT INTO leitura (fk_sensor, dht11_umidade, dht11_temperatura)
VALUES 
(502, 72.4, 19.5),
(502, 75.0, 18.9);

INSERT INTO leitura (fk_sensor, dht11_umidade, dht11_temperatura)
VALUES 
(503, 68.2, 20.1);

INSERT INTO leitura (fk_sensor, dht11_umidade, dht11_temperatura)
VALUES 
(504, 40.1, 16.8),
(504, 41.3, 17.0);

select * from leitura;
select * from sala;
select * from usuario;
select * from empresa;
select * from sensor;