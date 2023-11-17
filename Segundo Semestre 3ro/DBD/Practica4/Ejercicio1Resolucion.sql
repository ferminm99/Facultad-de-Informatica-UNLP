CREATE DATABASE `Ejercicio1`;
USE `Ejercicio1`;

CREATE TABLE IF NOT EXISTS `agencia` ( 
  `razon social` varchar(30) NOT NULL,
  `direccion` varchar(100) NULL,
  `telefono` varchar(50) NULL,
  `email` varchar(50) NULL,
  PRIMARY KEY (`razon social`));
 
CREATE TABLE IF NOT EXISTS `ciudad` ( 
  `codigo postal` int(30) NOT NULL,
  `nombreCiudad` varchar(50) NULL,
  `añoCreacion` year,
  PRIMARY KEY (`codigo postal`));
 
 CREATE TABLE IF NOT EXISTS `cliente` ( 
  `dni` int(8) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(50) NULL,
  `direccion` varchar(50) NULL,
  PRIMARY KEY (`dni`));
  
 CREATE TABLE IF NOT EXISTS `viaje` ( 
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `dni` int(8) NOT NULL,
  `cpOrigen` int(30) NOT NULL,
  `cpDestino` int(30) NOT NULL,
  `razonSocial` varchar(30) NOT NULL,
  `descripcion` varchar(100) NULL,
  PRIMARY KEY (`fecha`,`hora`,`dni`),
  FOREIGN KEY (`cpOrigen`) REFERENCES ciudad(`codigo postal`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  FOREIGN KEY (`cpDestino`) REFERENCES ciudad(`codigo postal`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  FOREIGN KEY (`razonSocial`) REFERENCES agencia(`razon social`) ON DELETE RESTRICT ON UPDATE NO ACTION
  );
  
INSERT INTO agencia (`razon social`, direccion, telefono, email) 
VALUES ('ViajesPepito', 'Selarrallan 1584', '1154785474', 'pepito@arnet.com'), 
('ViajesJuan', 'AlgunLado 2658', '1147586524', 'juan@gmail.com'), 
('ViajesMalisimos', 'Calle 5 965', '2215478796', 'malisimo@live.com'), 
('ViajesBarbara', 'Sagastisaval 4785', '1122336655', 'barbara@hotmail.com'), 
('MetoUnViaje', 'Rivadavia 96587', '2231458796', 'metounviaje@gmail.com');
  
  --Los valores de año van de 1901 a 2155 un bajon
  
INSERT INTO ciudad (`codigo postal`, nombreCiudad, añoCreacion) 
VALUES ('1900', 'La Plata',  '1901'), 
('1800', 'Ensenada', '1902'), 
('1500', 'Berisso', '1903'), 
('1315', 'Lobos', '2000'), 
('1400', 'CapitalFederal', '1954');

INSERT INTO cliente (dni, nombre, apellido, telefono, direccion) 
VALUES ('25478689', 'Juan', 'Garcia', '1145879632', 'Calle 58 4785'), 
('25485699', 'Juan', 'Gomez', '1144521432', 'Calle 57 477'), 
('26478989', 'Jose', 'Garcia', '1145865432', 'Calle 56 785'), 
('24785189', 'Raul', 'Gomez', '1187965432', 'Calle 55 475'), 
('25478446', 'Cosme', 'Fulanito', '1148775789', 'Calle 51 485');
  
INSERT INTO viaje (fecha, hora, dni, cpOrigen, cpDestino, razonSocial, descripcion) 
VALUES ('2020-10-28', '23:00:02', '25485699', '1900', '1315', 'ViajesMalisimos','fue muy malo el viaje'), 
('2020-10-28', '23:01:03', '25478689', '1400', '1315', 'ViajesPepito','me dormi y me levante en otro lado'), 
('2020-10-25', '02:40:02', '26478989', '1800', '1900', 'ViajesBarbara','llovia y me moje al orto'), 
('2020-09-28', '03:04:02', '24785189', '1900', '1500', 'ViajesMalisimos','habia un olor a chivo en el bondi'), 
('2020-08-02', '05:04:02', '25478446', '1315', '1900', 'MetoUnViaje','safo');


INSERT INTO cliente (dni, nombre, apellido, telefono, direccion) 
VALUES ('25478333', 'Juan', 'Roma', '1145879632', 'Calle 58 4785');

INSERT INTO viaje (fecha, hora, dni, cpOrigen, cpDestino, razonSocial, descripcion) 
VALUES ('2020-10-23', '23:00:02', '25478333', '1900', '1315', 'ViajesPepito','fue muy malo el viaje'),
('2020-10-22', '23:00:02', '25478333', '1900', '1800', 'ViajesJuan','fue muy malo el viaje'),
('2020-10-21', '23:00:02', '25478333', '1900', '1800', 'ViajesBarbara','fue muy malo el viaje'),
('2020-10-20', '23:00:02', '25478333', '1900', '1800', 'MetoUnViaje','fue muy malo');

INSERT INTO cliente (dni, nombre, apellido, telefono, direccion) 
VALUES ('38495444', 'Juan', 'Gonzalez', '1145879632', 'Calle 58 4785');


--1. Listar razón social, dirección y teléfono de agencias que realizaron viajes desde la ciudad de
--‘La Plata’ (ciudad origen) y que el cliente tenga apellido ‘Roma’. Ordenar por razón social y
--luego por teléfono.

INSERT INTO cliente (dni, nombre, apellido, telefono, direccion) 
VALUES ('25478333', 'Juan', 'Roma', '1145879632', 'Calle 58 4785');
INSERT INTO viaje (fecha, hora, dni, cpOrigen, cpDestino, razonSocial, descripcion) 
VALUES ('2020-10-28', '23:00:02', '25478333', '1900', '1315', 'ViajesMalisimos','fue muy malo el viaje');

SELECT agencia.`razon social`, agencia.direccion, agencia.telefono  FROM agencia INNER JOIN viaje ON (agencia.`razon social` = viaje.razonSocial)
INNER JOIN cliente ON (viaje.dni = cliente.dni) INNER JOIN ciudad ON (viaje.cpOrigen = ciudad.`codigo postal`) 
WHERE (viaje.cpOrigen = ciudad.`codigo postal` AND ciudad.nombreCiudad = 'La Plata' AND cliente.apellido = 'Roma');

SELECT a.`razon social`, a.direccion, a.telefono  FROM agencia a INNER JOIN viaje v ON (a.`razon social` = v.razonSocial)
INNER JOIN cliente c ON (v.dni = c.dni) INNER JOIN ciudad ciu ON (v.cpOrigen = ciu.`codigo postal`) 
WHERE (v.cpOrigen = ciu.`codigo postal` AND ciu.nombreCiudad = 'La Plata' AND c.apellido = 'Roma') ORDER BY `razon social`, telefono;

--2. Listar fecha, hora, datos personales del cliente, ciudad origen y destino de viajes realizados
--en enero de 2019 donde la descripción del viaje contenga el String ‘demorado’.

create view viajesEnero2019 as select * from viaje where (fecha between 20190101 and 20190131) and ( viaje.descripcion like '%demorado%');
create view viajesCasi as select v19.dni, v19.fecha, v19.hora, c.nombreCiudad as ciudadOrigen, ciu.nombreCiudad as ciudadDestino from viajesEnero2019 v19 inner join ciudad c on(v19.cpOrigen = c.`codigo postal`) inner join ciudad ciu on(v19.cpDestino = ciu.`codigo postal`);
select fecha, hora, c.dni, nombre, apellido, telefono, direccion, ciudadOrigen, ciudadDestino from cliente c inner join viajesCasi v on(c.dni = v.dni);

--3. Reportar información de agencias que realizaron viajes durante 2019 o que tengan dirección
--de mail que termine con ‘@jmail.com’.
drop view viajes2019;
create view viajes2019 as 
select `razon social`, direccion, telefono, email
from viaje v inner join agencia a on (v.razonSocial = a.`razon social`) 
where (v.fecha between 20190101 and 20191231) and (a.email like '%@jmail.com');

--4. Listar datos personales de clientes que viajaron solo con destino a la ciudad de ‘Coronel
--Brandsen’

select dni, nombre, apellido, telefono, direccion
from viaje v inner join ciudad ciu on (v.cpDestino = ciu.`codido Postal`) inner join cliente c on (c.dni = v.dni)
where ciu.nombreCiudad = 'Coronel Brandsen';

--5. Informar cantidad de viajes de la agencia con razón social ‘TAXI Y’ realizados a ‘Villa Elisa’.

select count(*)
from viaje v inner join agencia a on (v.razonSocial = a.`razon social`) 
inner join ciudad ciu on (v.cpDestino = ciu.`codigo postal`)
where (ciu.nombreCiudad = 'Villa Elisa') and (a.`razon social` = 'TAXI Y');

--6. Listar nombre, apellido, dirección y teléfono de clientes que viajaron con todas las agencias.

select nombre, apellido, telefono, direccion
from cliente c
where not exists (select * from agencia a
where not exists (select * from viaje v 
where (c.dni = v.dni) and (v.razonSocial = a.`razon social`)));

--7. Modificar el cliente con DNI: 38495444 actualizando el teléfono a: 221-4400897.

update cliente
set telefono = '221-4400897'
where dni = 38495444;


--8. Listar razon_social, dirección y teléfono de la/s agencias que tengan mayor cantidad de
--viajes realizados.
drop view cantidades;

create view cantidades as
select `razon social`, direccion, telefono, count(*) as cantidad
from viaje v inner join agencia a on(v.razonSocial = a.`razon social`)
group by a.`razon social`;

select `razon social`, direccion, telefono
from cantidades c
where c.cantidad = (select max(cantidad) from cantidades);

--9. Reportar nombre, apellido, dirección y teléfono de clientes con al menos 10 viajes.

create view cli as
select nombre, apellido, direccion, telefono, count(*) as cantidades
from viaje v inner join cliente c on(v.dni = c.dni)
group by c.dni;

select nombre, apellido, direccion, telefono
from cli
where cli.cantidades >= 10;

--10. Borrar al cliente con DNI 40325692.
INSERT INTO cliente (dni, nombre, apellido, telefono, direccion) 
VALUES ('40325692', 'Pepito', 'Pistolero', '1145879632', 'Calle 58 4785');

delete 
from cliente 
where dni = 40325692;



