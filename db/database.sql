-- Active: 1746842592259@@127.0.0.1@3306@medicamentos
CREATE DATABASE medicamentos;

USE medicamentos;
CREATE TABLE medicamentos (
  id		       INT                                   PRIMARY KEY AUTO_INCREMENT,
  tipo		     ENUM('oral','topica','inyectable')    NOT NULL ,
  nombre     	 VARCHAR(120)                          NOT NULL,
  nomcomercial VARCHAR(40)                           NULL ,
  presentacion ENUM('solida','semisolida','liquida') NOT NULL,
  receta  	   ENUM('S','N')                         NOT NULL DEFAULT 'N',
  precio	     DECIMAL(7,2)                          NOT NULL
) ENGINE = INNODB;


INSERT INTO medicamentos (tipo, nombre, nomcomercial, presentacion, receta, precio) VALUES
('oral', 'Paracetamol 500mg', 'Tylenol', 'solida', 'N', 35.50),
('inyectable', 'Penicilina G Sódica 1M UI', 'Pen-G', 'liquida', 'S', 120.00),
('topica', 'Clotrimazol 1%', 'Canesten', 'semisolida', 'N', 55.75),
('oral', 'Ibuprofeno 400mg', 'Advil', 'solida', 'N', 42.00),
('inyectable', 'Dexametasona 4mg/ml', 'Dexasone', 'liquida', 'S', 60.25),
('topica', 'Hidrocortisona 1%', 'Cortaid', 'semisolida', 'N', 48.90),
('oral', 'Amoxicilina 500mg', 'Amoxil', 'solida', 'S', 68.00),
('oral', 'Loratadina 10mg', 'Claritin', 'solida', 'N', 25.40),
('inyectable', 'Vitamina B12 1000mcg/ml', 'Bedoyecta', 'liquida', 'N', 90.00),
('topica', 'Diclofenaco Sódico 1%', 'Voltaren', 'semisolida', 'N', 59.10),
('oral', 'Omeprazol 20mg', 'Losec', 'solida', 'N', 33.20),
('inyectable', 'Ketorolaco Trometamina 30mg/ml', 'Toradol', 'liquida', 'S', 85.75);

CREATE VIEW vwMedicamentos AS
SELECT * FROM medicamentos;

-- select * from vwmedicamentos;
DELIMITER $$
CREATE PROCEDURE spGetMedicamentoById(
  IN _id INT
)
BEGIN
  SELECT * FROM medicamentos WHERE id = _id;
END $$

DELIMITER $$
CREATE PROCEDURE spGetMedicamentosByReceta(
  IN _receta ENUM('S','N')
)
BEGIN
  SELECT * FROM medicamentos WHERE receta = _receta;
END$$

DELIMITER $$
CREATE PROCEDURE spGetMedicamentosByTipo(
  IN _tipo ENUM('oral','topica','inyectable')
)
BEGIN
  SELECT * FROM medicamentos WHERE tipo = _tipo;
END $$

DELIMITER $$
CREATE PROCEDURE spRegisterMedicamento(
  IN _tipo ENUM('oral','topica','inyectable'),
  IN _nombre VARCHAR(120),
  IN _nomcomercial VARCHAR(40),
  IN _presentacion ENUM('solida','semisolida','liquida'),
  IN _receta ENUM('S','N'),
  IN _precio DECIMAL(7,2)
)
BEGIN
  INSERT INTO medicamentos (tipo, nombre, nomcomercial, presentacion, receta, precio)
  VALUES (_tipo, _nombre, NULLIF(_nomcomercial,''), _presentacion, _receta, _precio);
END $$

DELIMITER $$
CREATE PROCEDURE spUpdateMedicamento(
  IN _id INT,
  IN _tipo ENUM('oral','topica','inyectable'),
  IN _nombre VARCHAR(120),
  IN _nomcomercial VARCHAR(40),
  IN _presentacion ENUM('solida','semisolida','liquida'),
  IN _receta ENUM('S','N'),
  IN _precio DECIMAL(7,2)
)
BEGIN
  UPDATE medicamentos
  SET tipo = _tipo,
      nombre = _nombre,
      nomcomercial = _nomcomercial,
      presentacion = _presentacion,
      receta = _receta,
      precio = _precio
  WHERE id = _id;
END $$

