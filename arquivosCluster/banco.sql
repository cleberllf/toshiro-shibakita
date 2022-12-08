CREATE TABLE clientes (
	idCliente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	email VARCHAR(60) NOT NULL,
	telefone VARCHAR(15) NOT NULL,
	host VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO clientes (idCliente, nome, endereco, email, telefone, host) VALUES
	(1, "José", "Salvador", "jose@trabalho.com.br", "(71) 9999-9999", "host1"),
	(4, "Patrícia", "Jacobina", "patricia@estudo.com.br", "(74) 8888-8888", "host2");