-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-08-2024 a las 23:16:41
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
(19, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 4545),
(20, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 1231234),
(21, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 444444),
(22, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 12312355),
(23, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 22222),
(24, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 123123),
(25, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 123123),
(26, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 123123),
(27, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 5555),
(28, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 421233),
(29, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 41223121),
(30, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 412231212),
(31, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 441123),
(32, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 5444),
(33, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 547899),
(34, 'no_registrado', 'anonimo@gmail.com', 18, 'anonimo', 778800);

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
(1, 1, 'Ingresa al portal www.example.com y busca tu perfil.', 'Paso 1', NULL),
(2, 1, 'Selecciona la opción \'Consultar Saldo\'.', 'Paso 2', NULL),
(3, 1, 'Visualiza o imprime los movimientos recientes de tu cuenta.', 'Paso 3', NULL),
(4, 2, 'Ingresa al portal www.example.com y selecciona \'Movimientos\'.', 'Paso 1', NULL),
(5, 2, 'Selecciona el rango de fechas para los movimientos que deseas ver.', 'Paso 2', NULL),
(6, 2, 'Imprime o descarga los movimientos seleccionados.', 'Paso 3', NULL),
(7, 3, 'Ingresa al portal www.example.com y selecciona \'Ayuda\'.', 'Paso 1', NULL),
(8, 3, 'Busca la información que necesitas en la sección de preguntas frecuentes (FAQs).', 'Paso 2', NULL),
(9, 4, 'Accede a tu cuenta en www.example.com.', 'Paso 1', NULL),
(10, 4, 'Ve a la sección de \'Configuración de Cuenta\'.', 'Paso 2', NULL),
(11, 4, 'Actualiza la información personal y guarda los cambios.', 'Paso 3', NULL),
(12, 5, 'Ingresa al portal www.example.com y selecciona \'Mis Cuentas\'.', 'Paso 1', NULL),
(13, 5, 'Elige la cuenta donde deseas actualizar los beneficiarios.', 'Paso 2', NULL),
(14, 5, 'Modifica los datos y confirma los cambios.', 'Paso 3', NULL),
(15, 6, 'Accede a tu cuenta en www.example.com.', 'Paso 1', NULL),
(16, 6, 'Ve a la sección \'Mis Productos\'.', 'Paso 2', NULL),
(17, 6, 'Selecciona el producto cuyas condiciones deseas modificar y guarda los cambios.', 'Paso 3', NULL),
(18, 7, 'Inicia sesión en www.example.com y selecciona \'Reclamos\'.', 'Paso 1', NULL),
(19, 7, 'Rellena el formulario con los detalles del reclamo.', 'Paso 2', NULL),
(20, 7, 'Envía el reclamo y recibirás una respuesta en un plazo de 24-48 horas.', 'Paso 3', NULL),
(21, 8, 'Ingresa al portal www.example.com y selecciona \'Soporte\'.', 'Paso 1', NULL),
(22, 8, 'Busca la información en la sección de soporte o utiliza el chat en línea.', 'Paso 2', NULL),
(23, 9, 'Ingresa al portal www.example.com y busca tu perfil.', 'Paso 1', NULL),
(24, 9, 'Ve a la sección \'Privacidad y Seguridad\'.', 'Paso 2', NULL),
(25, 9, 'Selecciona \'Bloqueo de Tarjeta\' y sigue las instrucciones para bloquearla.', 'Paso 3', NULL),
(26, 10, 'Ingresa al portal web de tu banco en www.example.com.', 'Paso 1', NULL),
(27, 10, 'Busca la sección de \'Consultas Generales\' en el menú principal.', 'Paso 2', NULL),
(28, 10, 'Selecciona el tema de tu consulta y sigue las instrucciones proporcionadas.', 'Paso 3', NULL),
(29, 11, 'Accede al sitio web del banco en www.example.com.', 'Paso 1', NULL),
(30, 11, 'Dirígete a la sección \'Ubicación y Horarios\' desde el menú principal.', 'Paso 2', NULL),
(31, 11, 'Consulta los horarios y ubicaciones de las sucursales más cercanas.', 'Paso 3', NULL),
(32, 12, 'Visita el portal web en www.example.com.', 'Paso 1', NULL),
(33, 12, 'Navega a la sección de \'Apertura de Cuenta\'.', 'Paso 2', NULL),
(34, 12, 'Consulta los requisitos necesarios y reúne la documentación requerida.', 'Paso 3', NULL),
(35, 13, 'Accede al sitio web del banco en www.example.com.', 'Paso 1', NULL),
(36, 13, 'Selecciona \'Productos Bancarios\' en el menú.', 'Paso 2', NULL),
(37, 13, 'Elige el producto de interés y consulta la información detallada.', 'Paso 3', NULL),
(38, 14, 'Ingresa a la página principal del banco en www.example.com.', 'Paso 1', NULL),
(39, 14, 'Busca la sección \'Preguntas Frecuentes\' en el menú de ayuda.', 'Paso 2', NULL),
(40, 14, 'Revisa las preguntas y respuestas frecuentes para encontrar la información que necesitas.', 'Paso 3', NULL),
(41, 15, 'Visita el portal web en www.example.com.', 'Paso 1', NULL),
(42, 15, 'Dirígete a la sección \'Reporte de Problemas Urgentes\'.', 'Paso 2', NULL),
(43, 15, 'Completa el formulario con la descripción del problema y envíalo para recibir asistencia urgente.', 'Paso 3', NULL);

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
(1, 'Retiros y Depósitos Simples: Retiros de efectivo en caja', 3, 'asesor'),
(2, 'Retiros y Depósitos Simples: Depósitos de efectivo o cheques en cuentas personales o empresariales', 3, 'asesor'),
(3, 'Pagos de Servicios: Pagos de facturas de servicios públicos (agua, luz, gas, teléfono)', 3, 'asesor'),
(4, 'Pagos de Servicios: Pagos de tarjetas de crédito', 3, 'asesor'),
(5, 'Consultas de Saldo y Movimientos: Solicitudes para ver saldos de cuentas', 3, 'sistema'),
(6, 'Consultas de Saldo y Movimientos: Impresión de movimientos recientes de cuenta', 3, 'sistema'),
(7, 'Solicitudes de Información General: Preguntas generales sobre horarios, ubicación de sucursales, o productos básicos', 3, 'sistema'),
(8, 'Actualización de Datos Personales Menores: Cambio de dirección, número de teléfono, o correo electrónico', 3, 'sistema'),
(9, 'Apertura de Cuentas Bancarias: Apertura de cuentas corrientes o de ahorro personales', 2, 'asesor'),
(10, 'Apertura de Cuentas Bancarias: Apertura de cuentas corrientes o de ahorro empresariales', 2, 'asesor'),
(11, 'Solicitudes de Productos Bancarios: Solicitud de tarjetas de crédito', 2, 'asesor'),
(12, 'Solicitudes de Productos Bancarios: Solicitud de préstamos personales de montos bajos o medianos', 2, 'asesor'),
(13, 'Solicitudes de Productos Bancarios: Solicitud de líneas de crédito', 2, 'asesor'),
(14, 'Asesoramiento Financiero Básico: Consultas sobre productos de ahorro o inversión básica', 2, 'asesor'),
(15, 'Asesoramiento Financiero Básico: Orientación sobre planes de ahorro o seguros simples', 2, 'asesor'),
(16, 'Actualización de Datos Importantes: Actualización de beneficiarios de cuentas', 2, 'sistema'),
(17, 'Actualización de Datos Importantes: Cambio de condiciones de productos bancarios existentes', 2, 'sistema'),
(18, 'Atención a Reclamos No Urgentes: Reclamos relacionados con cargos erróneos o consultas sobre comisiones', 2, 'sistema'),
(19, 'Atención a Reclamos No Urgentes: Resolución de dudas sobre el funcionamiento de productos no críticos', 2, 'sistema'),
(20, 'Bloqueo y Reemplazo de Tarjetas: Bloqueo de tarjetas por pérdida, robo o sospecha de fraude', 1, 'sistema'),
(21, 'Bloqueo y Reemplazo de Tarjetas: Reemplazo inmediato de tarjetas de débito o crédito', 1, 'asesor'),
(22, 'Resolución de Disputas Urgentes: Disputas por transacciones fraudulentas o incorrectas', 1, 'asesor'),
(23, 'Resolución de Disputas Urgentes: Problemas con pagos no autorizados o errores graves en la cuenta', 1, 'asesor'),
(24, 'Solicitudes de Créditos Importantes: Solicitud de créditos hipotecarios o de grandes sumas', 1, 'asesor'),
(25, 'Solicitudes de Créditos Importantes: Financiamiento para empresas que requieren aprobación rápida', 1, 'asesor'),
(26, 'Atención a Clientes de Alto Valor: Clientes VIP o de banca privada con necesidades urgentes o importantes', 1, 'asesor'),
(27, 'Casos de Emergencia Financiera: Solicitud de adelantos o liberación de fondos en situaciones de emergencia', 1, 'asesor'),
(28, 'Casos de Emergencia Financiera: Resolución de problemas con acceso a fondos en situaciones críticas (p. ej., bloqueo de cuentas por errores)', 1, 'asesor'),
(29, 'Consultas Generales sobre la Banca', 5, 'sistema'),
(30, 'Información sobre Horarios y Ubicación', 5, 'sistema'),
(31, 'Consulta de Requisitos para Apertura de Cuenta', 5, 'sistema'),
(32, 'Solicitudes de Información sobre Productos Bancarios', 5, 'sistema'),
(33, 'Preguntas Frecuentes (FAQs)', 5, 'sistema'),
(34, 'Reporte de Problemas Urgentes', 5, 'sistema'),
(35, '¿Requieres asesoramiento?, ingresa aqui para solicitar un turno.', 5, 'asesor');

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
(1, 5, 3, 'Puedes seguir los siguientes pasos para ver los saldos de tus cuentas.', 'Consultas de Saldo y Movimientos'),
(2, 6, 3, 'Puedes seguir los siguientes pasos para imprimir los movimientos recientes de tu cuenta.', 'Consultas de Saldo y Movimientos'),
(3, 7, 3, 'Puedes seguir los siguientes pasos para obtener información general sobre horarios, ubicación de sucursales, o productos básicos.', 'Solicitudes de Información General'),
(4, 8, 3, 'Puedes seguir los siguientes pasos para actualizar tu dirección, número de teléfono, o correo electrónico.', 'Actualización de Datos Personales Menores'),
(5, 16, 2, 'Puedes seguir los siguientes pasos para actualizar los beneficiarios de tus cuentas.', 'Actualización de Datos Importantes'),
(6, 17, 2, 'Puedes seguir los siguientes pasos para cambiar las condiciones de tus productos bancarios.', 'Actualización de Datos Importantes'),
(7, 18, 2, 'Puedes seguir los siguientes pasos para hacer un reclamo relacionado con cargos erróneos o consultas sobre comisiones.', 'Atención a Reclamos No Urgentes'),
(8, 19, 2, 'Puedes seguir los siguientes pasos para resolver dudas sobre el funcionamiento de productos no críticos.', 'Atención a Reclamos No Urgentes'),
(9, 20, 1, 'Puedes seguir los siguientes pasos para bloquear tu tarjeta por pérdida, robo o sospecha de fraude.', 'Bloqueo y Reemplazo de Tarjetas'),
(10, 29, 5, 'Puedes seguir los siguientes pasos para realizar consultas generales sobre la banca.', 'Consultas Generales sobre la Banca'),
(11, 30, 5, 'Puedes seguir los siguientes pasos para obtener información sobre horarios y ubicación de nuestras sucursales.', 'Información sobre Horarios y Ubicación'),
(12, 31, 5, 'Puedes seguir los siguientes pasos para conocer los requisitos necesarios para abrir una cuenta bancaria.', 'Consulta de Requisitos para Apertura de Cuenta'),
(13, 32, 5, 'Puedes seguir los siguientes pasos para solicitar información sobre nuestros productos bancarios.', 'Solicitudes de Información sobre Productos Bancarios'),
(14, 33, 5, 'Puedes seguir los siguientes pasos para acceder a nuestras preguntas frecuentes.', 'Preguntas Frecuentes (FAQs)'),
(15, 34, 5, 'Puedes seguir los siguientes pasos para reportar problemas urgentes.', 'Reporte de Problemas Urgentes');

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
(5, 'Atencion general', 'Realiza consultas y resuelve tus dudas e inquietudes', '💳', 'no_registrado');

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

--
-- Volcado de datos para la tabla `servicios_opciones`
--

INSERT INTO `servicios_opciones` (`id`, `codigo_servicio`, `codigo_opcion`, `codigo_cliente`, `fecha_hora`) VALUES
(1, 5, 29, 20, '2024-08-22 18:01:05'),
(2, 5, 29, 20, '2024-08-22 18:01:07'),
(3, 5, 30, 20, '2024-08-22 18:01:13'),
(4, 5, 31, 20, '2024-08-22 18:01:17'),
(5, 5, 31, 20, '2024-08-22 18:01:19'),
(6, 5, 32, 20, '2024-08-22 18:01:21'),
(7, 5, 33, 20, '2024-08-22 18:01:23'),
(8, 5, 34, 20, '2024-08-22 18:01:24'),
(9, 1, 20, 1, '2024-08-22 23:19:52'),
(10, 1, 20, 1, '2024-08-22 23:19:56'),
(11, 2, 17, 1, '2024-08-22 23:20:18'),
(12, 2, 17, 1, '2024-08-22 23:21:26'),
(13, 2, 17, 1, '2024-08-22 23:23:24'),
(14, 2, 17, 1, '2024-08-22 23:23:25'),
(15, 2, 17, 1, '2024-08-22 23:23:31'),
(16, 2, 17, 1, '2024-08-22 23:24:17'),
(17, 2, 17, 1, '2024-08-22 23:24:38'),
(18, 2, 17, 1, '2024-08-22 23:24:46'),
(19, 2, 17, 1, '2024-08-22 23:24:47'),
(20, 2, 17, 1, '2024-08-22 23:24:59'),
(21, 2, 17, 1, '2024-08-22 23:25:06'),
(22, 5, 29, 21, '2024-08-23 17:53:59'),
(23, 5, 32, 21, '2024-08-23 17:54:01'),
(24, 5, 33, 21, '2024-08-23 17:54:03'),
(25, 5, 30, 21, '2024-08-23 17:54:06'),
(26, 5, 31, 21, '2024-08-23 17:54:07'),
(27, 5, 33, 21, '2024-08-23 17:54:09'),
(28, 1, 20, 1, '2024-08-23 17:54:21'),
(29, 1, 22, 1, '2024-08-23 17:54:26'),
(30, 1, 22, 1, '2024-08-23 17:54:46'),
(31, 1, 22, 1, '2024-08-23 17:54:58'),
(32, 1, 22, 1, '2024-08-23 17:55:19'),
(33, 1, 22, 1, '2024-08-23 17:55:51'),
(34, 1, 22, 1, '2024-08-23 17:55:54'),
(35, 1, 22, 1, '2024-08-23 17:55:57'),
(36, 1, 21, 1, '2024-08-23 18:06:43'),
(37, 5, 32, 27, '2024-08-23 21:25:30'),
(38, 5, 32, 31, '2024-08-23 21:35:13'),
(39, 5, 35, 32, '2024-08-23 21:47:53'),
(40, 5, 30, 33, '2024-08-23 21:57:06'),
(41, 5, 30, 33, '2024-08-23 22:00:44'),
(42, 5, 30, 33, '2024-08-23 22:00:45'),
(43, 5, 30, 33, '2024-08-23 22:03:10'),
(44, 5, 30, 33, '2024-08-23 22:03:33'),
(45, 5, 30, 33, '2024-08-23 22:52:33'),
(46, 5, 35, 34, '2024-08-23 23:02:44');

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
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id`, `fecha_hora`, `estado`, `codigo_asesor`, `codigo_servicio_opcion`) VALUES
(1, '2024-08-23 17:54:26', 'atendido', NULL, 29),
(2, '2024-08-23 17:54:46', 'atendido', NULL, 30),
(3, '2024-08-23 17:54:58', 'atendido', NULL, 31),
(4, '2024-08-23 17:55:19', 'atendido', NULL, 32),
(5, '2024-08-23 17:55:51', 'atendido', NULL, 33),
(6, '2024-08-23 17:55:54', 'atendido', NULL, 34),
(7, '2024-08-23 17:55:57', 'activo', NULL, 35),
(8, '2024-08-23 18:06:43', 'activo', NULL, 36),
(9, '2024-08-23 21:47:53', 'activo', NULL, 39),
(10, '2024-08-23 23:02:44', 'activo', NULL, 46);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `detalle_respuestas`
--
ALTER TABLE `detalle_respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `opciones`
--
ALTER TABLE `opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `servicios_opciones`
--
ALTER TABLE `servicios_opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
