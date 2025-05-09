-- Active: 1746797497505@@127.0.0.1@3306@medicamentos
create database medicamentos;

create table medicamentos (
  id		       int                                   primary key AUTO_INCREMENT,
  tipo		     enum('oral','topica','inyectable')    not null ,
  nombre     	 varchar(120)                          not null,
  nomcomercial varchar(40)                           null ,
  presentacion enum('solida','semisolida','liquida') not null,
  receta  	   enum('S','N')                         not null default 'N',
  precio	     decimal(7,2)                          not null
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

create view vwMedicamentos as
select * from medicamentos;

select * from vwmedicamentos;
create procedure spGetMedicamentoById(
  in _id INT
)
begin
  select * from medicamentos where id = _id;
end;

create procedure spGetMedicamentosByReceta(
  in _receta ENUM('S','N')
)
begin
  select * from medicamentos where receta = _receta;
end;

create procedure spGetMedicamentosByTipo(
  in _tipo ENUM('oral','topica','inyectable')
)
begin
  select * from medicamentos where tipo = _tipo;
end;

create Procedure spRegisterMedicamento(
  in _tipo ENUM('oral','topica','inyectable'),
  in _nombre VARCHAR(120),
  in _nomcomercial VARCHAR(40),
  in _presentacion ENUM('solida','semisolida','liquida'),
  in _receta ENUM('S','N'),
  in _precio DECIMAL(7,2)
)
begin
  insert into medicamentos (tipo, nombre, nomcomercial, presentacion, receta, precio)
  values (_tipo, _nombre, nullif(_nomcomercial,''), _presentacion, _receta, _precio);
end;

create procedure spUpdateMedicamento(
  in _id INT,
  in _tipo ENUM('oral','topica','inyectable'),
  in _nombre VARCHAR(120),
  in _nomcomercial VARCHAR(40),
  in _presentacion ENUM('solida','semisolida','liquida'),
  in _receta ENUM('S','N'),
  in _precio DECIMAL(7,2)
)
begin
  update medicamentos
  set tipo = _tipo,
      nombre = _nombre,
      nomcomercial = _nomcomercial,
      presentacion = _presentacion,
      receta = _receta,
      precio = _precio
  where id = _id;
end;

create procedure spDeleteMedicamento(
  in _id INT
)
begin
  delete from medicamentos where id = _id;
end;