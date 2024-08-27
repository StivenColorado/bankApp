-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 22-08-2024 a las 16:33:09
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
  `rol` varchar(20) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  `cedula` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `rol`, `correo`, `edad`, `nombre`, `cedula`) VALUES
(1, 'cliente', 'stivenchoo@gmail.com', 22, 'stiven', 123123),
(12, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 4),
(13, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 3434),
(14, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 847474),
(15, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 5656),
(16, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 12356),
(17, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 89577),
(18, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 557788),
(19, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 4545);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_respuestas`
--

CREATE TABLE `detalle_respuestas` (
  `id` int(11) NOT NULL,
  `codigo_respuesta` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `titulo` varchar(120) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_respuestas`
--

INSERT INTO `detalle_respuestas` (`id`, `codigo_respuesta`, `descripcion`, `titulo`, `link`) VALUES
(1, 1, 'Ingresa a tu correo electronico, en la parte de tu perfil presiona configuraciones, ingresa a privacidad y seguridad y haz cambio de tu contraseña ', 'Paso 1 - cambio de contraseña', ''),
(2, 1, 'Ingresa a la aplicacion de bankapp, en la parte de tu perfil presiona tarjetas, ingresa a inactivar tarjeta debito/credito y desactiva tu tarjeta ', 'Paso 2 - inactiva / pausa tu tarjeta', ''),
(3, 1, 'Tu informacion esta a salvo, cualquier transaccion como (ingreso, retiros y compras en linea no se realizaran hasta que actives tu tarjeta ', 'Paso 3 - Dirigete a una sucursal', ''),
(6, 2, 'dirigete al siguiente url www.bankapp.com/registro, e ingresa tus datos ten tu cedula en mano', 'Paso 1 - ingresar al portal de bankapp', NULL),
(7, 2, 'acercate a una sucursal con tu cedula para reclamar tu tarjeta', 'Paso 2 - Reclama tu tarjeta ', NULL);

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
(4, 'apertura de cuenta', 2, 'asesor'),
(5, 'Cierre de cuenta', 2, 'asesor'),
(6, 'prestamos', 2, 'asesor'),
(7, 'Hipoteca', 2, 'asesor'),
(8, 'Apertura de cuenta', 5, 'sistema'),
(9, 'Asesoria', 5, 'asesor'),
(10, 'Retiros y Depósitos Simples: Retiros de efectivo en caja', 3, 'asesor'),
(11, 'Retiros y Depósitos Simples: Depósitos de efectivo o cheques en cuentas personales o empresariales', 3, 'asesor'),
(12, 'Pagos de Servicios: Pagos de facturas de servicios públicos (agua, luz, gas, teléfono)', 3, 'asesor'),
(13, 'Pagos de Servicios: Pagos de tarjetas de crédito', 3, 'asesor'),
(14, 'Consultas de Saldo y Movimientos: Solicitudes para ver saldos de cuentas', 3, 'asesor'),
(15, 'Consultas de Saldo y Movimientos: Impresión de movimientos recientes de cuenta', 3, 'asesor'),
(16, 'Solicitudes de Información General: Preguntas generales sobre horarios, ubicación de sucursales, o productos básicos', 3, 'asesor'),
(17, 'Actualización de Datos Personales Menores: Cambio de dirección, número de teléfono, o correo electrónico', 3, 'asesor'),
(18, 'Apertura de Cuentas Bancarias: Apertura de cuentas corrientes o de ahorro personales o empresariales', 2, 'asesor'),
(19, 'Solicitudes de Productos Bancarios: Solicitud de tarjetas de crédito, préstamos personales de montos bajos o medianos', 2, 'asesor'),
(20, 'Solicitudes de Productos Bancarios: Solicitud de líneas de crédito', 2, 'asesor'),
(21, 'Asesoramiento Financiero Básico: Consultas sobre productos de ahorro o inversión básica', 2, 'asesor'),
(22, 'Asesoramiento Financiero Básico: Orientación sobre planes de ahorro o seguros simples', 2, 'asesor'),
(23, 'Actualización de Datos Importantes: Actualización de beneficiarios de cuentas', 2, 'asesor'),
(24, 'Actualización de Datos Importantes: Cambio de condiciones de productos bancarios existentes', 2, 'asesor'),
(25, 'Atención a Reclamos No Urgentes: Reclamos relacionados con cargos erróneos o consultas sobre comisiones', 2, 'asesor'),
(26, 'Atención a Reclamos No Urgentes: Resolución de dudas sobre el funcionamiento de productos no críticos', 2, 'asesor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `codigo_opcion` int(11) DEFAULT NULL,
  `codigo_servicio` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `titulo` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `codigo_opcion`, `codigo_servicio`, `descripcion`, `titulo`) VALUES
(1, 3, 1, 'En estos casos es importante hacer lo mas pronto posible las siguientes instrucciones', 'Atencion sistema - perdida de tarjeta / hurto'),
(2, 8, 5, 'Para abrir tu cuenta debes de seguir los pasos a continuacion', 'Apertura de cuenta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `descripcion` varchar(120) DEFAULT NULL,
  `icono` varchar(10) DEFAULT NULL,
  `tipo_servicio` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `descripcion`, `icono`, `tipo_servicio`) VALUES
(1, 'Atencion urgente', '¿Tu informacion esta en riesgo?', '⚠️', 'cliente'),
(2, 'Gestiones bancarias', 'podras realizar apertura/cierre de cuentas, prestamos..', '💳', 'cliente'),
(3, 'Servicios comunes', 'Pago de facturas, consultas..', '🛟', 'cliente'),
(4, 'Mi perfil', 'Actualizar informacion', '👋', 'cliente'),
(5, 'Atencion general', 'Realiza consultas y resuelve tus dudas e inquietudes', '💳', 'no_registrado'),
(6, 'Mi perfil', 'Actualiza tu informacion', '🏅', 'no_registrado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_opciones`
--

CREATE TABLE `servicios_opciones` (
  `id` int(11) NOT NULL,
  `codigo_servicio` int(11) DEFAULT NULL,
  `codigo_opcion` int(11) DEFAULT NULL,
  `codigo_cliente` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `fecha_hora` datetime DEFAULT NULL,
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
-- Indices de la tabla `detalle_respuestas`
--
ALTER TABLE `detalle_respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_respuesta` (`codigo_respuesta`);

--
-- Indices de la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_servicio` (`codigo_servicio`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_opcion` (`codigo_opcion`),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `detalle_respuestas`
--
ALTER TABLE `detalle_respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `opciones`
--
ALTER TABLE `opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
-- Filtros para la tabla `detalle_respuestas`
--
ALTER TABLE `detalle_respuestas`
  ADD CONSTRAINT `detalle_respuestas_ibfk_1` FOREIGN KEY (`codigo_respuesta`) REFERENCES `respuestas` (`id`);

--
-- Filtros para la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD CONSTRAINT `opciones_ibfk_1` FOREIGN KEY (`codigo_servicio`) REFERENCES `servicios` (`id`);

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`codigo_opcion`) REFERENCES `opciones` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`codigo_servicio`) REFERENCES `servicios` (`id`);

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
