CREATE TABLE hospede (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(90) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone CHAR(9) NOT NULL,
    email VARCHAR(150) NOT NULL
);

CREATE TABLE quarto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL, 
    tipo TINYINT(1) NOT NULL DEFAULT 0, -- define o tipo do quarto : simples, duplo ou suite (flag / boolean)
    `status` TINYINT(1) NOT NULL DEFAULT 0, -- define o estado do quarto : livre, ocupado ou manutenção (flag / boolean)
    reserva_id INT NOT NULL,
    reserva_hospede_id INT NOT NULL,
    FOREIGN KEY (reserva_id) 
        REFERENCES reserva(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    FOREIGN KEY (reserva_hospede_id)
        REFERENCES reserva(hospede_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE reserva (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_entrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_saida TIMESTAMP NOT NULL,
    hospede_id INT NOT NULL,
    hospede_pagando TINYINT(1) NOT NULL DEFAULT 0, -- define se esse é o hospede que está pagando (flag / boolean)
    FOREIGN KEY (hospede_id) 
        REFERENCES hospede(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);




