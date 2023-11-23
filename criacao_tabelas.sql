drop database if exists booking;
create schema booking;
use booking;

CREATE TABLE review (
    cod_review INT NOT NULL,
    review VARCHAR(200),
    local_review VARCHAR(50),
    cod_estadia INT NOT NULL,
    n_cliente INT NOT NULL,
    PRIMARY KEY (cod_review)
);

CREATE TABLE Cliente (
    n_cliente INT NOT NULL,
    nome VARCHAR(50),
    morada VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    palavra_passe VARCHAR(50) NOT NULL,
    telefone INT,
    nome_exibicao VARCHAR(50),
    data_nasc DATETIME,
    nacionalidade VARCHAR(50),
    sexo CHAR(1),
    CHECK (sexo IN ('F' , 'M')),
    n_passaporte INT,
    ultimo_login DATETIME NOT NULL,
    cod_review INT NOT NULL,
    PRIMARY KEY (n_cliente),
    FOREIGN KEY (cod_review)
        REFERENCES review (cod_review)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE estadias (
    cod_estadia INT NOT NULL,
    nome_estadia VARCHAR(50),
    local_estadia VARCHAR(50) NOT NULL,
    data_check_in DATETIME NOT NULL,
    n_adultos CHAR(2),
    n_criancas CHAR(2),
    n_quartos CHAR(2),
    motivo VARCHAR(100),
    rating NUMERIC(2 , 1 ),
    distancia_centro CHAR(3),
    sustentabilidade CHAR(1),
    cod_review INT NOT NULL,
    PRIMARY KEY (cod_estadia),
    FOREIGN KEY (cod_review)
        REFERENCES review (cod_review)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE parceiro (
    cod_parc INT NOT NULL,
    n_cliente INT NOT NULL,
    nome_parc VARCHAR(50),
    apelido_parc VARCHAR(50),
    telefone_parc INT,
    cod_estadia INT NOT NULL,
    PRIMARY KEY (cod_parc),
    FOREIGN KEY (n_cliente)
        REFERENCES cliente (n_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_estadia)
        REFERENCES estadias (cod_estadia)
        ON UPDATE CASCADE ON DELETE CASCADE
);
    
CREATE TABLE voos (
    cod_voo INT NOT NULL,
    preco_base DECIMAL(10 , 2 ),
    preco_final DECIMAL(10 , 2 ),
    companhia VARCHAR(50),
    hora_saida DATETIME,
    hora_chegada DATETIME,
    tipo_bagagem varchar (50),
    aeroporto_incial VARCHAR(50),
    aeroporto_final VARCHAR(50),
    PRIMARY KEY (cod_voo)
);

CREATE TABLE carro (
    cod_carro INT NOT NULL,
    modelo VARCHAR(50),
    n_lugares CHAR(1),
    transmissao CHAR(1)
		CHECK (transmissao IN ('A','M')),
    bagagem_carro VARCHAR(50),
    conta_quilómetros int(6),
    preco_por_dia DECIMAL(10 , 2 ),
    eletrico BOOLEAN,
    reviews DECIMAL (3 , 1 ),
    PRIMARY KEY (cod_carro)
);

CREATE TABLE aluguer (
    cod_aluguer INT NOT NULL,
    cod_carro INT NOT NULL,
    local_levantamento VARCHAR(50) NOT NULL,
    data_hora_levantamento DATETIME NOT NULL,
    data_hora_devolucao DATETIME NOT NULL,
    idade_condutor INT NOT NULL,
    local_devolucao VARCHAR(50) NOT NULL,
    PRIMARY KEY (cod_aluguer),
    FOREIGN KEY (cod_carro)
        REFERENCES carro (cod_carro)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE atracoes (
    cod_atracao INT NOT NULL,
    local_atracao VARCHAR(50) NOT NULL,
    data_atracao DATE NOT NULL,
    PRIMARY KEY (cod_atracao)
);

CREATE TABLE taxi (
    cod_taxi INT NOT NULL,
    tipo_taxi VARCHAR(10),
    local_levantamento_passageiros VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    data_hora_taxi DATETIME,
    n_pessoas CHAR(1),
    PRIMARY KEY (cod_taxi)
);

CREATE TABLE passaporte (
    n_passaporte INT NOT NULL,
    n_cliente INT NOT NULL,
    data_emissao DATE NOT NULL,
    pais_emissao VARCHAR(10),
    validade DATE NOT NULL,
    PRIMARY KEY (n_passaporte),
    FOREIGN KEY (n_cliente)
        REFERENCES cliente (n_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE booking (
    preco_final DECIMAL(10 , 2 ),
    n_cliente INT NOT NULL,
    cod_aluguer INT NOT NULL,
    cod_atracao INT NOT NULL,
    cod_taxi INT NOT NULL,
    cod_voo INT NOT NULL,
    cod_estadia INT NOT NULL,
    PRIMARY KEY (n_cliente , cod_aluguer),
    FOREIGN KEY (n_cliente)
        REFERENCES cliente (n_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_aluguer)
        REFERENCES aluguer (cod_aluguer)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_taxi)
        REFERENCES taxi (cod_taxi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_voo)
        REFERENCES voos (cod_voo)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cod_estadia)
        REFERENCES estadias (cod_estadia)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (cod_atracao)
		REFERENCES atracoes (cod_atracao)
        ON UPDATE CASCADE ON DELETE CASCADE
);