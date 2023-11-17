-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-12-2019 a las 16:13:54
-- Versión del servidor: 10.1.35-MariaDB
-- Versión de PHP: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ejercicio1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agencia`
--

CREATE TABLE `agencia` (
  `RAZON_SOCIAL` int(11) NOT NULL,
  `direccion` varchar(55) NOT NULL,
  `telef` varchar(55) NOT NULL,
  `mail` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `agencia`
--

INSERT INTO `agencia` (`RAZON_SOCIAL`, `direccion`, `telef`, `mail`) VALUES
(1, '', '', ''),
(2, '', '', ''),
(3, '', '', ''),
(4, '', '', ''),
(5, '', '', 'huggi@jmail.com'),
(6, '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `codigo_postal` int(11) NOT NULL,
  `nombreCiudad` varchar(55) NOT NULL,
  `anioCreacion` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`codigo_postal`, `nombreCiudad`, `anioCreacion`) VALUES
(1, 'nombre1', '1'),
(2, 'nombre2', '2'),
(3, 'nombre3', '3'),
(4, 'nombre4', '4'),
(5, 'la plata', ''),
(6, 'CoronelBrandsen', '1'),
(7, 'Villa Elisa', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `dni` int(8) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `apellido` varchar(55) NOT NULL,
  `telefono` varchar(55) NOT NULL,
  `direccion` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`dni`, `nombre`, `apellido`, `telefono`, `direccion`) VALUES
(1, 'cliente1', 'apellido1', 'telefono1', 'direccion1'),
(2, 'cliente2', 'apellido2', 'telefono2', 'direccion2'),
(3, 'cliente3', 'apellido3', 'telefono3', 'direccion3'),
(4, 'nombreRoma', 'roma', '', ''),
(5, 'cliente5', 'apellido5', 'telefono5', 'direccion5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `fecha` varchar(55) NOT NULL,
  `hora` varchar(55) NOT NULL,
  `dni` int(11) NOT NULL,
  `cpOrigen` int(11) NOT NULL,
  `cpDestino` int(11) NOT NULL,
  `razon_social` int(11) NOT NULL,
  `descripcion` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `viaje`
--

INSERT INTO `viaje` (`fecha`, `hora`, `dni`, `cpOrigen`, `cpDestino`, `razon_social`, `descripcion`) VALUES
('fecha1', 'hora1', 1, 1, 2, 1, ''),
('fecha1', 'hora1', 2, 2, 1, 1, ''),
('fecha1', 'hora1', 3, 2, 1, 1, 'esta demorado'),
('fecha1', 'hora1', 4, 1, 6, 1, ''),
('fecha1', 'hora1', 5, 1, 6, 1, ''),
('fecha2', 'hora2', 2, 1, 7, 1, ''),
('fecha2', 'hora2', 3, 1, 7, 1, ''),
('fecha2', 'hora2', 4, 5, 2, 2, ''),
('fecha2', 'hora3', 2, 1, 7, 1, ''),
('fecha2', 'hora3', 4, 1, 7, 1, ''),
('fecha5', 'hora1', 1, 1, 7, 1, ''),
('fecha5', 'hora2', 1, 1, 7, 2, ''),
('fecha5', 'hora3', 1, 1, 7, 3, ''),
('fecha5', 'hora4', 1, 1, 7, 4, ''),
('fecha5', 'hora5', 1, 1, 7, 5, ''),
('fecha5', 'hora5', 2, 1, 7, 1, ''),
('fecha5', 'hora5', 3, 1, 7, 2, ''),
('fecha5', 'hora5', 4, 1, 7, 3, ''),
('fecha5', 'hora6', 1, 1, 7, 6, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agencia`
--
ALTER TABLE `agencia`
  ADD PRIMARY KEY (`RAZON_SOCIAL`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`codigo_postal`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`fecha`,`hora`,`dni`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agencia`
--
ALTER TABLE `agencia`
  MODIFY `RAZON_SOCIAL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `codigo_postal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `dni` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
