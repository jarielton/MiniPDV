/*
MySQL Data Transfer
Source Host: localhost
Source Database: banco
Target Host: localhost
Target Database: banco
Date: 07/08/2024 13:46:11
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for clientes
-- ----------------------------
CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `cidade` varchar(20) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pedidos
-- ----------------------------
CREATE TABLE `pedidos` (
  `numero_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime NOT NULL,
  `codigo_cliente` int(11) NOT NULL DEFAULT '0',
  `valor_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `codigo_cliente` (`codigo_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pedidos_produtos
-- ----------------------------
CREATE TABLE `pedidos_produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero_pedido` int(11) NOT NULL,
  `codigo_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numero_pedido` (`numero_pedido`),
  KEY `codigo_produto` (`codigo_produto`),
  CONSTRAINT `pedidos_produtos_ibfk_1` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`numero_pedido`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for produtos
-- ----------------------------
CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(20) NOT NULL,
  `preco_venda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `clientes` VALUES ('1', 'Ana Silva', 'São Paulo', 'SP');
INSERT INTO `clientes` VALUES ('2', 'Bruno Souza', 'Rio de Janeiro', 'RJ');
INSERT INTO `clientes` VALUES ('3', 'Carlos Oliveira', 'Belo Horizonte', 'MG');
INSERT INTO `clientes` VALUES ('4', 'Daniela Lima', 'Salvador', 'BA');
INSERT INTO `clientes` VALUES ('5', 'Eduardo Santos', 'Curitiba', 'PR');
INSERT INTO `clientes` VALUES ('6', 'Fernanda Costa', 'Fortaleza', 'CE');
INSERT INTO `clientes` VALUES ('7', 'Gabriel Almeida', 'Manaus', 'AM');
INSERT INTO `clientes` VALUES ('8', 'Helena Rocha', 'Porto Alegre', 'RS');
INSERT INTO `clientes` VALUES ('9', 'Igor Ferreira', 'Recife', 'PE');
INSERT INTO `clientes` VALUES ('10', 'Juliana Martins', 'Goiânia', 'GO');
INSERT INTO `clientes` VALUES ('11', 'Lucas Pereira', 'Belém', 'PA');
INSERT INTO `clientes` VALUES ('12', 'Mariana Azevedo', 'Florianópolis', 'SC');
INSERT INTO `clientes` VALUES ('13', 'Nathalia Ribeiro', 'Brasília', 'DF');
INSERT INTO `clientes` VALUES ('14', 'Otávio Lima', 'Vitória', 'ES');
INSERT INTO `clientes` VALUES ('15', 'Patrícia Mendes', 'Campo Grande', 'MS');
INSERT INTO `clientes` VALUES ('16', 'Rafael Costa', 'Natal', 'RN');
INSERT INTO `clientes` VALUES ('17', 'Sofia Almeida', 'João Pessoa', 'PB');
INSERT INTO `clientes` VALUES ('18', 'Thiago Rocha', 'Aracaju', 'SE');
INSERT INTO `clientes` VALUES ('19', 'Ursula Santos', 'Maceió', 'AL');
INSERT INTO `clientes` VALUES ('20', 'Vinícius Oliveira', 'Teresina', 'PI');
INSERT INTO `clientes` VALUES ('21', 'Wesley Souza', 'São Luís', 'MA');
INSERT INTO `clientes` VALUES ('22', 'Xavier Gomes', 'Palmas', 'TO');
INSERT INTO `clientes` VALUES ('23', 'Yasmin Ferreira', 'Macapá', 'AP');
INSERT INTO `clientes` VALUES ('24', 'Zoe Martins', 'Boa Vista', 'RR');
INSERT INTO `produtos` VALUES ('1', 'Arroz', '5.00');
INSERT INTO `produtos` VALUES ('2', 'Feijão', '4.50');
INSERT INTO `produtos` VALUES ('3', 'Macarrão', '3.00');
INSERT INTO `produtos` VALUES ('4', 'Açúcar', '2.50');
INSERT INTO `produtos` VALUES ('5', 'Sal', '1.00');
INSERT INTO `produtos` VALUES ('6', 'Óleo de Soja', '7.00');
INSERT INTO `produtos` VALUES ('7', 'Leite', '4.00');
INSERT INTO `produtos` VALUES ('8', 'Café', '8.00');
INSERT INTO `produtos` VALUES ('9', 'Farinha de Trigo', '3.50');
INSERT INTO `produtos` VALUES ('10', 'Manteiga', '6.00');
INSERT INTO `produtos` VALUES ('11', 'Pão de Forma', '5.50');
INSERT INTO `produtos` VALUES ('12', 'Queijo', '10.00');
INSERT INTO `produtos` VALUES ('13', 'Presunto', '9.00');
INSERT INTO `produtos` VALUES ('14', 'Frango', '12.00');
INSERT INTO `produtos` VALUES ('15', 'Carne Bovina', '20.00');
INSERT INTO `produtos` VALUES ('16', 'Peixe', '15.00');
INSERT INTO `produtos` VALUES ('17', 'Ovos', '6.50');
INSERT INTO `produtos` VALUES ('18', 'Tomate', '4.00');
INSERT INTO `produtos` VALUES ('19', 'Batata', '3.00');
INSERT INTO `produtos` VALUES ('20', 'Cebola', '2.00');
INSERT INTO `produtos` VALUES ('21', 'Alface', '1.50');
INSERT INTO `produtos` VALUES ('22', 'Maçã', '3.00');
INSERT INTO `produtos` VALUES ('23', 'Banana', '2.50');
INSERT INTO `produtos` VALUES ('24', 'Laranja', '3.50');
INSERT INTO `produtos` VALUES ('25', 'Uva', '5.00');
