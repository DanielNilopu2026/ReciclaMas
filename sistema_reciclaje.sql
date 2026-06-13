-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2026 a las 05:16:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_reciclaje`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canjes`
--

CREATE TABLE `canjes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `recompensa_id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `puntos_descontados` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `canjes`
--

INSERT INTO `canjes` (`id`, `usuario_id`, `recompensa_id`, `fecha`, `puntos_descontados`) VALUES
(1, 3, 1, '2026-05-23 14:08:57', NULL),
(2, 3, 2, '2026-05-23 14:09:00', NULL),
(3, 3, 1, '2026-05-23 14:09:02', NULL),
(4, 3, 1, '2026-05-25 20:57:20', NULL),
(5, 3, 1, '2026-06-12 18:48:07', NULL),
(6, 3, 2, '2026-06-12 22:08:47', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `puntos_por_kg` double NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`id`, `nombre`, `puntos_por_kg`, `descripcion`, `activo`) VALUES
(1, 'Plástico', 10, 'Botellas PET, envases y recipientes plásticos', 1),
(2, 'Cartón', 5, 'Cajas de cartón, periódicos y papel corrugado', 1),
(3, 'Vidrio', 8, 'Botellas, frascos y recipientes de vidrio', 1),
(4, 'Metal', 15, 'Latas de aluminio y metales ferrosos', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reciclajes`
--

CREATE TABLE `reciclajes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `cantidad_kg` decimal(10,2) NOT NULL,
  `puntos_obtenidos` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reciclajes`
--

INSERT INTO `reciclajes` (`id`, `usuario_id`, `material_id`, `cantidad_kg`, `puntos_obtenidos`, `fecha`) VALUES
(1, 2, 1, 3.50, 35, '2025-05-01 09:30:00'),
(2, 2, 4, 2.00, 30, '2025-05-05 11:00:00'),
(3, 3, 3, 4.00, 32, '2025-05-02 10:00:00'),
(4, 3, 4, 5.00, 75, '2025-05-12 09:00:00'),
(5, 4, 2, 3.00, 15, '2025-05-03 12:30:00'),
(6, 3, 1, 5.00, 50, '2026-05-24 12:12:13'),
(7, 3, 2, 5.00, 25, '2026-05-25 20:56:37'),
(8, 3, 1, 5.00, 50, '2026-05-26 11:17:07'),
(9, 3, 1, 5.00, 50, '2026-06-12 18:47:54'),
(10, 3, 1, 5.00, 50, '2026-06-12 22:08:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recompensas`
--

CREATE TABLE `recompensas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `puntos_requeridos` int(11) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `activa` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recompensas`
--

INSERT INTO `recompensas` (`id`, `nombre`, `descripcion`, `puntos_requeridos`, `stock`, `activa`) VALUES
(1, 'Bolsa Ecológica', 'Bolsa reutilizable 100% algodón orgánico', 50, 96, 1),
(2, 'Vale Supermercado', 'Descuento de S/. 10 en tiendas participantes', 150, 48, 1),
(3, 'Árbol Nativo', 'Plantación de árbol nativo en tu nombre', 300, 30, 1),
(4, 'Kit Compostaje', 'Kit completo para compostaje doméstico con guía', 500, 20, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `puntos_total` int(11) DEFAULT 0,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `rol` enum('VECINO','ADMIN') DEFAULT 'VECINO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `puntos_total`, `fecha_registro`, `rol`) VALUES
(1, 'Alejandro Daniel Abanto Nilopu', 'alejandro@gmail.com', 'alejandro2026', 0, '2026-05-23 14:04:54', 'ADMIN'),
(2, 'Juan Pérez', 'juan@gmail.com', 'juan2026', 150, '2026-05-23 14:04:54', 'VECINO'),
(3, 'María López', 'maria@gmail.com', 'maria2026', 45, '2026-05-23 14:04:54', 'VECINO'),
(4, 'Carlos Ruiz', 'carlos@gmail.com', 'carlos2026', 85, '2026-05-23 14:04:54', 'VECINO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `canjes`
--
ALTER TABLE `canjes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `recompensa_id` (`recompensa_id`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reciclajes`
--
ALTER TABLE `reciclajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indices de la tabla `recompensas`
--
ALTER TABLE `recompensas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `canjes`
--
ALTER TABLE `canjes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `reciclajes`
--
ALTER TABLE `reciclajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `recompensas`
--
ALTER TABLE `recompensas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `canjes`
--
ALTER TABLE `canjes`
  ADD CONSTRAINT `canjes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `canjes_ibfk_2` FOREIGN KEY (`recompensa_id`) REFERENCES `recompensas` (`id`);

--
-- Filtros para la tabla `reciclajes`
--
ALTER TABLE `reciclajes`
  ADD CONSTRAINT `reciclajes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reciclajes_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materiales` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
