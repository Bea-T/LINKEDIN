-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-08-2025 a las 14:41:21
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
-- Base de datos: `linkedin`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `logo`, `descripcion`) VALUES
(1, 'Tech Solutions', 'https://ui-avatars.com/api/?name=Tech+Solutions&background=random', 'Empresa de tecnología'),
(2, 'Consultora RH', 'https://ui-avatars.com/api/?name=Consultora+RH&background=random', 'Recursos Humanos'),
(3, 'Industrias ABC', 'https://ui-avatars.com/api/?name=Industrias+ABC&background=random', 'Fabricación de productos'),
(4, 'Creativa Studio', 'https://robohash.org/CreativaStudio.png?size=200x200', 'Agencia especializada en diseño UX/UI y branding digital'),
(5, 'HelpDesk Pro', 'https://robohash.org/HelpDeskPro.png?size=200x200', 'Soporte técnico y atención al cliente para empresas'),
(6, 'NetCorp', 'https://robohash.org/NetCorp.png?size=200x200', 'Proveedor de soluciones de redes y telecomunicaciones'),
(7, 'QualitySoft', 'https://robohash.org/QualitySoft.png?size=200x200', 'Compañía dedicada a pruebas de software y QA'),
(8, 'CloudWorks', 'https://robohash.org/CloudWorks.png?size=200x200', 'Servicios de DevOps y soluciones en la nube'),
(9, 'Finanzas Globales', 'https://robohash.org/FinanzasGlobales.png?size=200x200', 'Consultoría contable y financiera internacional'),
(10, 'Digital Media Group', 'https://robohash.org/DigitalMediaGroup.png?size=200x200', 'Agencia de marketing y gestión de redes sociales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llamados`
--

CREATE TABLE `llamados` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `llamados`
--

INSERT INTO `llamados` (`id`, `titulo`, `descripcion`, `fecha`, `tipo`, `empresa_id`) VALUES
(1, 'Desarrollador PHP', 'Buscamos desarrollador con experiencia en PHP', '2025-07-25', 'Remoto', 1),
(2, 'Analista de RRHH', 'Puesto para analista de recursos humanos', '2025-07-29', 'Presencial', 2),
(3, 'Operario de planta', 'Trabajo en línea de producción', '2025-07-30', 'Híbrido', 3),
(11, 'Diseñador UX/UI', 'Se busca diseñador con experiencia en interfaces web', '2025-08-11', 'Presencial', 4),
(12, 'Soporte Técnico', 'Atención a clientes y resolución de problemas técnicos', '2025-08-12', 'Híbrido', 5),
(13, 'Administrador de Redes', 'Mantenimiento y configuración de redes empresariales', '2025-08-13', 'Remoto', 6),
(14, 'Tester QA', 'Pruebas de software y control de calidad', '2025-08-14', 'Presencial', 7),
(15, 'Ingeniero DevOps', 'Automatización y despliegue continuo', '2025-08-15', 'Híbrido', 8),
(16, 'Contador Senior', 'Responsable de balances y estados contables', '2025-08-16', 'Remoto', 9),
(17, 'Community Manager', 'Gestión de redes sociales y campañas digitales', '2025-08-17', 'Presencial', 10),
(18, 'Programador Java', 'Desarrollo de aplicaciones empresariales con Java y Spring Boot', '2025-08-18', 'Híbrido', 1),
(19, 'Especialista en Ciberseguridad', 'Análisis de vulnerabilidades y protección de datos', '2025-08-19', 'Remoto', 1),
(20, 'Asistente Administrativo', 'Gestión de documentos y atención telefónica', '2025-08-20', 'Presencial', 2),
(21, 'Reclutador IT', 'Búsqueda y selección de perfiles tecnológicos', '2025-08-21', 'Híbrido', 2),
(22, 'Supervisor de Producción', 'Coordinación de procesos industriales y equipos de trabajo', '2025-08-05', 'Remoto', 3),
(23, 'Técnico Electromecánico', 'Mantenimiento de maquinaria y líneas de producción', '2025-08-06', 'Presencial', 3),
(24, 'Diseñador Gráfico', 'Creación de piezas gráficas y contenido visual', '2025-08-07', 'Híbrido', 4),
(25, 'Animador 3D', 'Modelado y animación para proyectos audiovisuales', '2025-08-09', 'Remoto', 4),
(26, 'Agente de Soporte Nivel 2', 'Resolución de problemas técnicos avanzados', NULL, NULL, 5),
(27, 'Coordinador de Call Center', 'Supervisión de equipo de soporte y métricas de calidad', NULL, NULL, 5),
(28, 'Ingeniero de Redes Senior', 'Diseño e implementación de infraestructura de red', NULL, NULL, 6),
(29, 'Especialista en Seguridad de Redes', 'Monitoreo y control de tráfico de red', NULL, NULL, 6),
(30, 'Tester Automatizado', 'Diseño de pruebas automáticas para software empresarial', NULL, NULL, 7),
(31, 'Líder de QA', 'Gestión de equipos de control de calidad de software', NULL, NULL, 7),
(32, 'Administrador de Sistemas Cloud', 'Gestión de entornos en la nube y despliegue de servicios', NULL, NULL, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postulaciones`
--

CREATE TABLE `postulaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `llamado_id` int(11) NOT NULL,
  `fecha_postulacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `postulaciones`
--

INSERT INTO `postulaciones` (`id`, `usuario_id`, `llamado_id`, `fecha_postulacion`) VALUES
(1, 1, 1, '2025-08-21 08:45:54'),
(2, 2, 2, '2025-08-21 08:45:54'),
(3, 3, 3, '2025-08-21 08:45:54'),
(4, 1, 2, '2025-08-21 08:45:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`) VALUES
(1, 'Juan Perez', 'juan@correo.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ=='),
(2, 'Ana Gomez', 'ana@correo.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye'),
(3, 'Carlos Ruiz', 'carlos@correo.com', '$2y$10$wHh6Q8QJQJQJQJQJQJQJQO');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_llamados_empresas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_llamados_empresas` (
`id` int(11)
,`titulo` varchar(100)
,`descripcion` text
,`fecha` date
,`tipo` varchar(50)
,`empresa_id` int(11)
,`empresa_nombre` varchar(100)
,`logo` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_llamados_empresas`
--
DROP TABLE IF EXISTS `vista_llamados_empresas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_llamados_empresas`  AS SELECT `llamados`.`id` AS `id`, `llamados`.`titulo` AS `titulo`, `llamados`.`descripcion` AS `descripcion`, `llamados`.`fecha` AS `fecha`, `llamados`.`tipo` AS `tipo`, `llamados`.`empresa_id` AS `empresa_id`, `empresas`.`nombre` AS `empresa_nombre`, `empresas`.`logo` AS `logo` FROM (`llamados` join `empresas` on(`llamados`.`empresa_id` = `empresas`.`id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `llamados`
--
ALTER TABLE `llamados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `postulaciones`
--
ALTER TABLE `postulaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `llamado_id` (`llamado_id`);

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
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `llamados`
--
ALTER TABLE `llamados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `postulaciones`
--
ALTER TABLE `postulaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `llamados`
--
ALTER TABLE `llamados`
  ADD CONSTRAINT `llamados_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `postulaciones`
--
ALTER TABLE `postulaciones`
  ADD CONSTRAINT `postulaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `postulaciones_ibfk_2` FOREIGN KEY (`llamado_id`) REFERENCES `llamados` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
