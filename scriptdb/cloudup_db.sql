-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 24-06-2024 a las 09:42:13
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
-- Base de datos: `cloudup`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actualizacion_software`
--

CREATE TABLE `actualizacion_software` (
  `id_actualizacion` int(11) NOT NULL,
  `condiciones` varchar(200) NOT NULL,
  `id_programador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actualizacion_software`
--

INSERT INTO `actualizacion_software` (`id_actualizacion`, `condiciones`, `id_programador`) VALUES
(1, 'estable', 5),
(2, 'en proceso', 4),
(3, 'mejorable', 2),
(4, 'estable', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_administrador` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `clave_especial` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_administrador`, `nombre`, `apellido`, `ciudad`, `telefono`, `direccion`, `correo`, `contraseña`, `clave_especial`) VALUES
(1, 'Stiven Alexander', 'Alvarez', 'Medellin', '3002019587', 'Carrera 70 # 43-64', 'stiven@gmail.com', 'stiven123', '789'),
(2, 'Juan David', 'Urrego', 'Medellin', '3259874165', 'Calle 45 # 74-32', 'juan@gmail.com', 'juan123', '456'),
(3, 'Jose Carlos', 'Lindarte Cuello', 'Medellin', '3116328361', 'Carrera 55 # 78A-21', 'carlos@gmail.com', 'carlos123', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(128) NOT NULL,
  `contraseña` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `apellido`, `correo`, `contraseña`) VALUES
(1, 'Juan', 'Perez', 'juan.perez@example.com', '1234567890'),
(2, 'Maria', 'Rodriguez', 'maria.rodriguez@example.com', '9876543210'),
(3, 'Ana', 'Lopez', 'ana.lopez@example.com', '0987654321'),
(4, 'Pedro', 'Garcia', 'pedro.garcia@example.com', '1122334455'),
(5, 'Sofia', 'Sanchez', 'sofia.sanchez@example.com', '6789012345'),
(6, 'Isabella', 'Martin', 'isabella.martin@example.com', '2233445566'),
(7, 'Diego', 'Gonzalez', 'diego.gonzalez@example.com', '3344556677'),
(8, 'Andrea', 'Romero', 'andrea.romero@example.com', '4455667788'),
(9, 'Carlos', 'Flores', 'carlos.flores@example.com', '5566778899'),
(10, 'Laura', 'Mendez', 'laura.mendez@example.com', '6677889900'),
(11, 'vale', 'González Gómez', 'valegogo95@gmail.com', '1011510881Vg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL,
  `precio_compra` decimal(45,0) NOT NULL,
  `fecha_compra` varchar(45) NOT NULL,
  `caracteristicas` varchar(500) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_compra`, `precio_compra`, `fecha_compra`, `caracteristicas`, `id_cliente`) VALUES
(1, 120, '2024-05-20', 'Sistema operativo', 1),
(2, 80, '2024-05-15', 'Software de diseño gráfico', 2),
(3, 50, '2024-05-10', 'Software de contabilidad', 3),
(4, 150, '2024-05-05', 'Juego de PC', 4),
(5, 100, '2024-04-30', 'Software de aprendizaje de idiomas', 5),
(6, 75, '2024-05-25', 'Software de desarrollo web', 6),
(7, 130, '2024-05-22', 'Software de análisis de datos', 7),
(8, 60, '2024-05-18', 'Software de edición de fotos', 8),
(9, 180, '2024-05-12', 'Software de gestión de redes sociale', 9),
(10, 90, '2024-05-07', 'Software de seguridad para el hogar', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargo`
--

CREATE TABLE `encargo` (
  `id_tipo_software_encargado` int(11) NOT NULL,
  `precio_encargo` decimal(45,0) NOT NULL,
  `fecha_encargo` varchar(45) NOT NULL,
  `estado_software` varchar(500) NOT NULL,
  `id_encargo_software` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encargo`
--

INSERT INTO `encargo` (`id_tipo_software_encargado`, `precio_encargo`, `fecha_encargo`, `estado_software`, `id_encargo_software`, `id_cliente`) VALUES
(1, 1000, '2024-05-30', 'En desarrollo', 1, 1),
(2, 800, '2024-03-28', 'En pruebas', 2, 2),
(3, 500, '2024-01-25', 'Completado', 3, 3),
(4, 700, '2024-05-22', 'En espera de aprobación', 4, 4),
(5, 600, '2024-03-20', 'En desarrollo', 5, 5),
(6, 1200, '2024-02-17', 'En pruebas', 6, 6),
(7, 900, '2024-01-14', 'Completado', 7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `historial_movimiento_entrada_y_salida` varchar(400) NOT NULL,
  `cantidad_stock_de_cada_tipo_software` decimal(10,0) NOT NULL,
  `id_estado_software` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `historial_movimiento_entrada_y_salida`, `cantidad_stock_de_cada_tipo_software`, `id_estado_software`) VALUES
(1, '10-04-2024', 2, 1),
(2, '10-04-2024', 2, 2),
(3, '10-04-2024', 2, 2),
(4, '10-04-2024', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programador`
--

CREATE TABLE `programador` (
  `id_programador` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(128) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `programador`
--

INSERT INTO `programador` (`id_programador`, `nombre`, `apellido`, `correo`, `telefono`, `nombre_usuario`, `contraseña`, `activo`) VALUES
(1, 'juan', 'marin', 'juanmarin@gmail.com', '324345667', '', '', 0),
(2, 'manuel', 'zapata', 'manuel01@gmail.com', '322949557', '', '', 0),
(3, 'jhoana', 'suarez', 'suarejhoa@gmail.com', '34442727', '', '', 0),
(4, 'carlos', 'alvarez', 'carlitosal@gmail.com', '32055843', '', '', 0),
(5, 'manuela', 'martinez', 'manumartinez@gmail.com', '310334454', '', '', 0),
(6, 'carla', 'gomez', 'gomezgomez@gmail.com', '316334245', '', '', 0),
(7, 'marlon', 'lopez', 'marlon0818@gmail.com', '322364898', '', '', 0),
(10, 'Valeria', 'González Gómez', 'valegogo95@gmail.com', '3218077011', 'valegg', '1011', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicar`
--

CREATE TABLE `publicar` (
  `id_publicar` int(11) NOT NULL,
  `fecha_publicacion` varchar(45) NOT NULL,
  `caracteristicas` varchar(500) NOT NULL,
  `id_programador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicar`
--

INSERT INTO `publicar` (`id_publicar`, `fecha_publicacion`, `caracteristicas`, `id_programador`) VALUES
(1, '20-05-2024', 'software inventario', 1),
(2, '20-05-2024', 'software entretenimiento', 2),
(3, '20-05-2024', 'software registro', 3),
(4, '20-05-2024', 'software pedidos', 4),
(5, '20-05-2024', 'software inventario', 5),
(6, '20-05-2024', 'software facturas', 6);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `punto1`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `punto1` (
`nombre_programador` varchar(100)
,`apellido_programador` varchar(100)
,`software_publicado` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `punto2`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `punto2` (
`fecha_publicacion` varchar(45)
,`fecha_compra` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `punto3`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `punto3` (
`nombre` varchar(100)
,`apellido` varchar(100)
,`id_tipo_software` int(11)
,`precio_encargo` decimal(45,0)
,`fecha_encargo` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesion_programador`
--

CREATE TABLE `sesion_programador` (
  `id_sesion` int(11) NOT NULL,
  `id_programador` int(11) NOT NULL,
  `estado` enum('inicio_sesion','cierre_sesion') NOT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `sesion_programador`
--
DELIMITER $$
CREATE TRIGGER `actualizar_estado` AFTER INSERT ON `sesion_programador` FOR EACH ROW BEGIN
    DECLARE v_estado VARCHAR(50);
    
    IF NEW.estado = 'cierre_sesion' THEN
        SET v_estado = '0'; -- Inactivo
        UPDATE programador
        SET activo = v_estado
        WHERE id_programador = NEW.id_programador;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_estado_programador` AFTER INSERT ON `sesion_programador` FOR EACH ROW BEGIN
    DECLARE v_estado VARCHAR(50);
    
    IF NEW.estado = 'inicio_sesion' THEN
        SET v_estado = '1'; -- Activo
    ELSEIF NEW.estado = 'cierre_sesion' THEN
        SET v_estado = '0'; -- Inactivo
    END IF;
    
    UPDATE programador
    SET activo = v_estado
    WHERE id_programador = NEW.id_programador;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `software`
--

CREATE TABLE `software` (
  `id_tipo_software` int(11) NOT NULL,
  `precio_compra_o_encargo` decimal(45,0) NOT NULL,
  `id_estado_software` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `software`
--

INSERT INTO `software` (`id_tipo_software`, `precio_compra_o_encargo`, `id_estado_software`) VALUES
(1, 200000, NULL),
(2, 300000, NULL),
(3, 450000, NULL),
(4, 370000, NULL),
(5, 800000, NULL),
(6, 920000, NULL),
(7, 290000, NULL);

-- --------------------------------------------------------

--
-- Estructura para la vista `punto1`
--
DROP TABLE IF EXISTS `punto1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `punto1`  AS SELECT `p`.`nombre` AS `nombre_programador`, `p`.`apellido` AS `apellido_programador`, `pu`.`caracteristicas` AS `software_publicado` FROM (`programador` `p` join `publicar` `pu` on(`p`.`id_programador` = `pu`.`id_programador`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `punto2`
--
DROP TABLE IF EXISTS `punto2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `punto2`  AS SELECT `publicar`.`fecha_publicacion` AS `fecha_publicacion`, `compra`.`fecha_compra` AS `fecha_compra` FROM (`publicar` join `compra`) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `punto3`
--
DROP TABLE IF EXISTS `punto3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `punto3`  AS SELECT `c`.`nombre` AS `nombre`, `c`.`apellido` AS `apellido`, `s`.`id_tipo_software` AS `id_tipo_software`, `s`.`precio_compra_o_encargo` AS `precio_encargo`, `e`.`fecha_encargo` AS `fecha_encargo` FROM ((`cliente` `c` join `encargo` `e` on(`c`.`id_cliente` = `e`.`id_cliente`)) join `software` `s` on(`e`.`id_tipo_software_encargado` = `s`.`id_tipo_software`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actualizacion_software`
--
ALTER TABLE `actualizacion_software`
  ADD PRIMARY KEY (`id_actualizacion`),
  ADD KEY `id_programador` (`id_programador`);

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `encargo`
--
ALTER TABLE `encargo`
  ADD PRIMARY KEY (`id_tipo_software_encargado`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`);

--
-- Indices de la tabla `programador`
--
ALTER TABLE `programador`
  ADD PRIMARY KEY (`id_programador`);

--
-- Indices de la tabla `publicar`
--
ALTER TABLE `publicar`
  ADD PRIMARY KEY (`id_publicar`),
  ADD KEY `fk_id_programador` (`id_programador`);

--
-- Indices de la tabla `sesion_programador`
--
ALTER TABLE `sesion_programador`
  ADD PRIMARY KEY (`id_sesion`),
  ADD KEY `id_programador` (`id_programador`);

--
-- Indices de la tabla `software`
--
ALTER TABLE `software`
  ADD PRIMARY KEY (`id_tipo_software`),
  ADD KEY `id_estado_software` (`id_estado_software`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actualizacion_software`
--
ALTER TABLE `actualizacion_software`
  MODIFY `id_actualizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_administrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `encargo`
--
ALTER TABLE `encargo`
  MODIFY `id_tipo_software_encargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `programador`
--
ALTER TABLE `programador`
  MODIFY `id_programador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `publicar`
--
ALTER TABLE `publicar`
  MODIFY `id_publicar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sesion_programador`
--
ALTER TABLE `sesion_programador`
  MODIFY `id_sesion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `software`
--
ALTER TABLE `software`
  MODIFY `id_tipo_software` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actualizacion_software`
--
ALTER TABLE `actualizacion_software`
  ADD CONSTRAINT `actualizacion_software_ibfk_1` FOREIGN KEY (`id_programador`) REFERENCES `programador` (`id_programador`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `encargo`
--
ALTER TABLE `encargo`
  ADD CONSTRAINT `encargo_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `publicar`
--
ALTER TABLE `publicar`
  ADD CONSTRAINT `fk_id_programador` FOREIGN KEY (`id_programador`) REFERENCES `programador` (`id_programador`);

--
-- Filtros para la tabla `sesion_programador`
--
ALTER TABLE `sesion_programador`
  ADD CONSTRAINT `fk_sesion_programador_id_programador` FOREIGN KEY (`id_programador`) REFERENCES `programador` (`id_programador`);

--
-- Filtros para la tabla `software`
--
ALTER TABLE `software`
  ADD CONSTRAINT `software_ibfk_1` FOREIGN KEY (`id_estado_software`) REFERENCES `inventario` (`id_inventario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
