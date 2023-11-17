
CREATE DATABASE `Ejercicio2`;
USE `Ejercicio1`;

CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(11) unsigned NOT NULL AUTO_INCREMENT, 
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) not NULL,
  `dni` int(8) unsigned not NULL,
  `telefono` varchar(50) NULL,
  `direccion` varchar(50) NULL,
  PRIMARY KEY (`idCliente`));
 
CREATE TABLE IF NOT EXISTS `factura` ( 
  `nroTicket` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `total` real(15) not NULL,
  `fecha` date not null,
  `hora` time not null,
  `idCliente` int(11) unsigned NOT NULL,
  PRIMARY KEY (`nroTicket`),
  FOREIGN KEY (`idCliente`) REFERENCES cliente(`idCliente`) ON DELETE RESTRICT ON UPDATE NO ACTION);
 
 CREATE TABLE IF NOT EXISTS `producto` ( 
  `idProducto` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(70) NULL,
  `precio` int(6) NOT NULL,
  `nombreP` varchar(30) NULL,
  `stock` int(8) not NULL,
  PRIMARY KEY (`idProducto`));
  
 CREATE TABLE IF NOT EXISTS `detalle` ( 
  `nroTicket` int(11) unsigned NOT NULL,
  `idProducto` int(11) unsigned NOT NULL,
  `cantidad` int(8) NOT NULL,
  `precioUnitario` int(6) NOT NULL,
  PRIMARY KEY (`nroTicket`,`idProducto`),
  FOREIGN KEY (`nroTicket`) REFERENCES factura(`nroTicket`) ON DELETE RESTRICT ON UPDATE NO ACTION,
  FOREIGN KEY (`idProducto`) REFERENCES producto(`idProducto`) ON DELETE RESTRICT ON UPDATE NO ACTION
  );
  

INSERT INTO producto (`descripcion`, `precio`, `nombreP`, `stock`) 
VALUES ('metalica', 200,  'Tijera', 450),
('buen precio', 540,  'pegamento', 40),
('carisima', 450,  'black', 70),
('desartable', 40,  'regla', 30),
('baratisima', 40,  'voligoma', 550),
('metalica', 60,  'sacapintas', 0),
('metalica', 50,  'cartulina', 70),
('nada', 247,  'goma eva', 60),
('algo', 265,  'lapiz', 100),
('maso', 204,  'lapicera', 90),
('buenisima', 90,  'cartuchera', 80),
('horrible', 70,  'Tijera', 5),
('descartable', 270,  'plato', 7),
('malisima', 260,  'lapicera', 10),
('plastico', 230,  'tenedor', 20);

INSERT INTO cliente (nombre, apellido, dni, telefono, direccion) 
VALUES ('Santiago', 'Perez',  '11111111', '221-4658485', 'calle 6 665'),
('Diego', 'Gomez',  '22222222', '221-4854648', 'calle 2 564'),
('Daniel', 'Alvarez',  '33333333', '221-4584854', 'calle 78 987'),
('Rodolfo', 'Castro',  '55555555', '221-4231354', 'calle 45 156'),
('Nicolas', 'Burruchaga',  '88888888', '221-4564841', 'calle 6 945'),
('Beto', 'Acosta',  '77777777', '221-4848769', 'calle 9 375');

INSERT INTO factura (`total`, `fecha`, `hora`, `idCliente`) 
VALUES (5786.45, 20200728,  '13:00:00', 1),
(586.45, 20201029,  '16:51:50', 1),
(896.42, 20201028,  '12:45:00', 3),
(587.32, 20200328,  '16:16:00', 4),
(961.78, 20200528,  '16:56:00', 5),
(58960.96, 20200415,  '12:04:45', 6),
(1096.14, 20200904,  '12:00:00', 7),
(2016.36, 20200808,  '12:06:54', 8),
(6589.47, 20020628,  '12:06:56', 1),
(4657.45, 20180508,  '06:56:56', 3),
(3654.32, 20190119,  '12:00:50', 4),
(7896.98, 20191008,  '17:00:40', 5),
(152.47, 20171027,  '10:04:00', 6),
(63.40, 20181001,  '12:00:45', 1),
(476.45, 20191018,  '12:00:00', 1);

INSERT INTO detalle (`nroTicket`, `idProducto`, `cantidad`, `precioUnitario`) 
VALUES ( 1, 1, 4, 575 ),
( 2, 12, 4, 275 ),
( 3, 11, 5, 775 ),
( 4, 11, 9, 675 ),
( 5, 10, 65, 75 ),
( 6, 15, 41, 75 ),
( 7, 14, 3, 475 ),
( 8, 13, 4, 55 ),
( 9, 11, 7, 55 ),
( 11, 12, 32, 75 ),
( 10, 10, 96, 75 ),
( 12, 9, 74, 5 ),
( 13, 6, 36, 985 ),
( 14, 8, 58, 65 ),
( 15, 7, 4, 123 ),
( 16, 6, 9, 78 ),
( 1, 5, 3, 75 ),
( 2, 4, 1, 57 ),
( 3, 3, 2, 57 ),
( 4, 2, 7, 55 ),
( 1, 9, 3, 75 );

--1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por
--DNI

select nombre, apellido, DNI, telefono, direccion
from cliente
where apellido like 'Pe%'
order by dni;

--2. Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras
--solamente durante 2017.

select nombre, apellido, DNI, telefono, direccion
from cliente c inner join factura f on(f.idCliente = c.idCliente)
where f.fecha between 20170101 and 20171231;

--3. Listar nombreP, descripción, precio y stock de productos vendidos al cliente con
--DNI:45789456, pero que no fueron vendidos a clientes de apellido ‘Garcia’.

INSERT INTO cliente (nombre, apellido, dni, telefono, direccion) 
VALUES ('Sergio', 'Perez',  45789456, '221-4658485', 'calle 6 665'),
('Sancho', 'Garcia',  45756645, '221-46568465', 'calle 8 35');

INSERT INTO factura (`total`, `fecha`, `hora`, `idCliente`) 
VALUES (56.45, 20200728,  '13:00:00', 9),
(536.45, 20200728,  '13:00:00', 10);

INSERT INTO detalle (`nroTicket`, `idProducto`, `cantidad`, `precioUnitario`) 
VALUES ( 17, 5, 4, 575 ),
( 18, 9, 4, 275 ),

create view vendidoDni as
select p.descripcion, p.precio, p.nombreP, p.stock
from producto p inner join detalle d on (p.idProducto = d.idProducto)
inner join factura f on (d.nroTicket = f.nroTicket) inner join cliente c on(f.idCliente = c.idCliente)
where c.dni = 45789456;

create view vendidoGarcia as
select p.descripcion, p.precio, p.nombreP, p.stock
from producto p inner join detalle d on (p.idProducto = d.idProducto)
inner join factura f on (d.nroTicket = f.nroTicket) inner join cliente c on(f.idCliente = c.idCliente)
where c.apellido = 'Garcia';
--El except no funciona en la realidad no se porque pero es asi y estoy seguro porque con el union anda
select * 
from vendidoDni 
except 
select *
from vendidoGarcia;


--4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que
--tengan teléfono con característica: 221 (La característica está al comienzo del teléfono).
--Ordenar por nombre.

select p.descripcion, p.precio, p.nombreP, p.stock
from producto p inner join detalle d on (p.idProducto = d.idProducto)
inner join factura f on (d.nroTicket = f.nroTicket) inner join cliente c on(f.idCliente = c.idCliente)
where c.telefono like '221%'
order by p.nombreP;

--5. Listar para cada producto: nombre, descripción, precio y cuantas veces fué vendido.
--Tenga en cuenta que puede no haberse vendido nunca el producto.
INSERT INTO producto (`descripcion`, `precio`, `nombreP`, `stock`) 
VALUES ('azul', 10,  'Goma', 1000);--producto no vendido 

select descripcion, precio, nombreP, count(*) as vendido
from producto p left join detalle d on(p.idProducto = d.idProducto)
group by d.idProducto;
--no funciona porque no puedo hacer que count cuente 0

--6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los
--productos con nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre
--‘prod3’.

INSERT INTO producto (`descripcion`, `precio`, `nombreP`, `stock`) 
VALUES ('azul', 10,  'prod1', 1000),--id 17
('verde', 30,  'prod2', 1000),--id 18
('blanco', 40,  'prod3', 1000); -- id 19
INSERT INTO detalle (`nroTicket`, `idProducto`, `cantidad`, `precioUnitario`) 
VALUES ( 17, 17, 4, 55 ),
( 18, 18, 4, 25 ),
( 18, 17, 4, 25 ),
( 17, 19, 4, 25 );

create view compraronProd1yProd2 as
select c.nombre, c.apellido, c.dni, c.telefono, c.direccion
from cliente c inner join factura f on(c.idCliente = f.idCliente)
inner join detalle d on(f.nroTicket = d.nroTicket) inner join producto p on(d.idProducto = p.idProducto)
where p.nombreP = 'prod2' or p.nombreP = 'prod1';

create view compraronProd3 as
select c.nombre, c.apellido, c.dni, c.telefono, c.direccion
from cliente c inner join factura f on(c.idCliente = f.idCliente)
inner join detalle d on(f.nroTicket = d.nroTicket) inner join producto p on(d.idProducto = p.idProducto)
where p.nombreP = 'prod3';

select *
from compraronProd1yProd2
except
select *
from compraronProd3

--no anda porque no funca el except

--7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
--comprado el producto ‘prod38’ o la factura tenga fecha de 2019.

select f.nroTicket, f.total,f.fecha,f.hora,c.nombre
from cliente c inner join factura f on (c.idCliente = f.idCliente)
inner join detalle d on (f.nroTicket = d.nroTicket) inner join producto p on (d.idProducto = p.idProducto)
where (p.nombreP = 'prod38') or (f.fecha between 20190101 and 20191231);

--8. Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’,
--DNI:40578999, teléfono:221-4400789, dirección:’11 entre 500 y 501 nro:2587’ y el id de
--cliente: 500002. Se supone que el idCliente 500002 no existe.
iNSERT INTO cliente (nombre, apellido, dni, telefono, direccion) 
VALUES ('Jorge Luis', 'Castor',  40578999, '221-4400789', 'calle 11 entre 500 y 501');

--9. Listar nroTicket, total, fecha, hora para las facturas del cliente  ́Jorge Pérez ́ donde no
--haya comprado el producto  ́Z ́.

select f.nroTicket, f.total, f.fecha, f.hora
from cliente c inner join factura f on (c.idCliente = f.idCliente)
inner join detalle d on (f.nroTicket = d.nroTicket) inner join producto p on (d.idProducto = p.idProducto)
where (c.nombre = 'Jorge') and (c.apellido = 'Perez') and (p.nombreP <> 'Z');

--10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en
--cuenta todas sus facturas, supere $10.000.000.

create view cGastado as
select c.idCliente, sum(f.total) as gastado
from cliente c inner join factura f on(c.idCliente = f.idCliente)
group by c.idCliente;

select c.nombre, c.apellido, c.dni, cG.gastado
from cGastado cG inner join cliente c on(c.idCliente = cG.idCliente)
where cG.gastado > 10000;

