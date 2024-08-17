-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 16-08-2024 a las 23:14:56
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bankapp_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `rol` varchar(12) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  `cedula` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `rol`, `correo`, `edad`, `nombre`, `cedula`) VALUES
(1, 'cliente', 'stivenchoo@gmail.com', 22, 'stiven', 123123);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones`
--

CREATE TABLE `opciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(155) DEFAULT NULL,
  `codigo_servicio` int(11) DEFAULT NULL,
  `atencion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opciones`
--

INSERT INTO `opciones` (`id`, `nombre`, `codigo_servicio`, `atencion`) VALUES
(1, 'Robo de cuenta', 1, 'asesor'),
(2, 'Movimientos inesperados', 1, 'asesor'),
(3, 'Perdida de tarjeta / hurto', 1, 'sistema'),
(4, 'apertura de cuenta', 2, NULL),
(5, 'Cierre de cuenta', 2, NULL),
(6, 'prestamos', 2, NULL),
(7, 'Hipoteca', 2, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `descripcion` varchar(120) DEFAULT NULL,
  `icono` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `descripcion`, `icono`) VALUES
(1, 'Atencion urgente', '¿Tu informacion esta en riesgo?', '⚠️'),
(2, 'Gestiones bancarias', 'podras realizar apertura/cierre de cuentas, prestamos..', '💳'),
(3, 'Servicios comunes', 'Pago de facturas, consultas..', '🛟'),
(4, 'Mi perfil', 'Actualizar informacion', '👋');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_opciones`
--

CREATE TABLE `servicios_opciones` (
  `id` int(11) NOT NULL,
  `codigo_servicio` int(11) DEFAULT NULL,
  `codigo_opcion` int(11) DEFAULT NULL,
  `codigo_cliente` int(11) DEFAULT NULL,
  `fecha_hora` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `fecha_hora` date DEFAULT NULL,
  `estado` varchar(12) DEFAULT NULL,
  `codigo_asesor` int(11) DEFAULT NULL,
  `codigo_servicio_opcion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_servicio` (`codigo_servicio`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicios_opciones`
--
ALTER TABLE `servicios_opciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_servicio` (`codigo_servicio`),
  ADD KEY `codigo_opcion` (`codigo_opcion`),
  ADD KEY `codigo_cliente` (`codigo_cliente`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_servicio_opcion` (`codigo_servicio_opcion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `opciones`
--
ALTER TABLE `opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `servicios_opciones`
--
ALTER TABLE `servicios_opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD CONSTRAINT `opciones_ibfk_1` FOREIGN KEY (`codigo_servicio`) REFERENCES `servicios` (`id`);

--
-- Filtros para la tabla `servicios_opciones`
--
ALTER TABLE `servicios_opciones`
  ADD CONSTRAINT `servicios_opciones_ibfk_1` FOREIGN KEY (`codigo_servicio`) REFERENCES `servicios` (`id`),
  ADD CONSTRAINT `servicios_opciones_ibfk_2` FOREIGN KEY (`codigo_opcion`) REFERENCES `opciones` (`id`),
  ADD CONSTRAINT `servicios_opciones_ibfk_3` FOREIGN KEY (`codigo_cliente`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`codigo_servicio_opcion`) REFERENCES `servicios_opciones` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
