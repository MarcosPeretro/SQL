CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    telefone CHAR(14) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE clientes_enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(150) NOT NULL,
    numero CHAR(4) NOT NULL DEFAULT 'S/N',
    complemento VARCHAR(45),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    principal TINYINT(1) NOT NULL DEFAULT 0, -- endereço principal (flag / boolean) 
    clientes_id INT NOT NULL,
    FOREIGN KEY (clientes_id) 
        REFERENCES clientes(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE funcionarios_funcoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(50) NOT NULL,
    cbo CHAR(7) NOT NULL,
    descricao VARCHAR(45),
    funcionarios_id INT NOT NULL,
    FOREIGN KEY (funcionarios_id) 
        REFERENCES funcionarios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `status` TINYINT(1) NOT NULL DEFAULT 0, -- status do pedido possui multiplos status (flag / boolean)
    data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DOUBLE NOT NULL DEFAULT 0,
    nf VARCHAR(255),
    clientes_id INT NOT NULL,
    funcionarios_id INT NOT NULL,
    CONSTRAINT `fk_pedidos_clientes` -- nome da relação
        FOREIGN KEY (clientes_id) 
            REFERENCES clientes(id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,

    CONSTRAINT `fk_pedidos_funcionarios` -- nome da relação
        FOREIGN KEY(funcionarios_id)
            REFERENCES funcionarios(id)
            ON DELETE NO ACTION  
            ON UPDATE NO ACTION  
);

CREATE TABLE pedidos_itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(150) NOT NULL,
    quantidade INT NOT NULL,
    valor DOUBLE NOT NULL,
    pedidos_id INT NOT NULL,
    pedidos_clientes_id INT NOT NULL
    CONSTRAINT `fk_pedidos_items`
        FOREIGN KEY (pedidos_id, pedidos_clientes_id)
            REFERENCES pedidos(id, clientes_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(45) NOT NULL,
    ativo TINYINT(1) NOT NULL default 1 -- Mostra se o produto esta ativo ou não(flag / boolean)
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100),
    preco DOUBLE NOT NULL DEFAULT 0, 
    from_categorias INT NOT NULL, -- nome alternativo
    FOREIGN KEY (from_categorias)
        REFERENCES categorias(id)
        ON DELETE RESTRICT
        ON UPDATE NO ACTION
);