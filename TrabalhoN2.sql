-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: edustream
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admcodigo` int(11) NOT NULL AUTO_INCREMENT,
  `admemail` varchar(50) DEFAULT NULL,
  `admsenha` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`admcodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'fulano@gmail.com','123');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula`
--

DROP TABLE IF EXISTS `aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aula` (
  `aulaid` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) DEFAULT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `video_url` varchar(200) DEFAULT NULL,
  `duracao` int(11) DEFAULT NULL,
  `thumb_url` varchar(100) DEFAULT NULL,
  `curcodigo` int(11) DEFAULT NULL,
  PRIMARY KEY (`aulaid`),
  KEY `fk_aula_cursos` (`curcodigo`),
  CONSTRAINT `fk_aula_cursos` FOREIGN KEY (`curcodigo`) REFERENCES `cursos` (`curcodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula`
--

LOCK TABLES `aula` WRITE;
/*!40000 ALTER TABLE `aula` DISABLE KEYS */;
INSERT INTO `aula` VALUES (1,'Banco de Dados MySQL','Fundamentos de MySQL: criacao de tabelas, consultas SQL e relacionamentos entre tabelas.','/videos/videoteste.mp4',2000,'/images/check_5610944.svg',2),(2,'Introducao ao Node.js','Aula introdutoria','video1.mp4',30,'thumb1.jpg',6),(3,'Express Basico','Configuracao do Express','video2.mp4',45,'thumb2.jpg',3),(4,'EJS e Templates','Uso do EJS para views','video3.mp4',40,'thumb3.jpg',3),(5,'MySQL com Node.js','Integracao com MySQL','video4.mp4',50,'thumb4.jpg',4),(6,'Rotas e Middlewares','Manipulando rotas','video5.mp4',35,'thumb5.jpg',1),(7,'Autenticacao','Login e sessoes','video6.mp4',60,'thumb6.jpg',2);
/*!40000 ALTER TABLE `aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursos` (
  `curcodigo` int(11) NOT NULL AUTO_INCREMENT,
  `curnome` varchar(255) NOT NULL,
  `curdescricao` varchar(500) DEFAULT NULL,
  `curcategoria` varchar(100) DEFAULT NULL,
  `curhoras` int(11) DEFAULT NULL,
  `curpreco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`curcodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'JavaScript Basico','Curso introdutorio de JavaScript','Programacao',40,199.90),(2,'React Avancado','Curso avancado de React','Programacao',60,299.90),(3,'Node.js Completo','Curso completo de Node.js','Programacao',80,399.90),(4,'Design UI/UX','Curso de Design de Interface','Design',50,249.90),(5,'Python do zero ao pro','Curso completo de Python','Programacao',70,350.00),(6,'CSS e HTML Basico','Fundamentos de desenvolvimento web','Programacao',30,150.00),(7,'teste','teste','teste',10,120.00),(15,'oiiii','iiiiiii','iiiii',12,10.00);
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progresso`
--

DROP TABLE IF EXISTS `progresso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progresso` (
  `proid` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_aula` int(11) DEFAULT NULL,
  `status` enum('concluido','em andamento','nao iniciado') DEFAULT NULL,
  `minutos_assistidos` int(11) DEFAULT NULL,
  PRIMARY KEY (`proid`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_aula` (`id_aula`),
  CONSTRAINT `progresso_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`usucodigo`),
  CONSTRAINT `progresso_ibfk_2` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`aulaid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progresso`
--

LOCK TABLES `progresso` WRITE;
/*!40000 ALTER TABLE `progresso` DISABLE KEYS */;
INSERT INTO `progresso` VALUES (1,33,1,'em andamento',15),(3,33,2,'em andamento',20),(4,33,4,'nao iniciado',0),(5,2,3,'em andamento',30),(6,2,4,'em andamento',30);
/*!40000 ALTER TABLE `progresso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_curso`
--

DROP TABLE IF EXISTS `usuario_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_curso` (
  `usucodigo` int(11) NOT NULL,
  `curcodigo` int(11) NOT NULL,
  PRIMARY KEY (`usucodigo`,`curcodigo`),
  KEY `curcodigo` (`curcodigo`),
  CONSTRAINT `usuario_curso_ibfk_1` FOREIGN KEY (`usucodigo`) REFERENCES `usuarios` (`usucodigo`),
  CONSTRAINT `usuario_curso_ibfk_2` FOREIGN KEY (`curcodigo`) REFERENCES `cursos` (`curcodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_curso`
--

LOCK TABLES `usuario_curso` WRITE;
/*!40000 ALTER TABLE `usuario_curso` DISABLE KEYS */;
INSERT INTO `usuario_curso` VALUES (2,1),(2,3),(2,5),(3,2),(3,4),(25,1),(25,2),(25,3),(25,6),(33,4),(33,5),(33,6);
/*!40000 ALTER TABLE `usuario_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `usucodigo` int(11) NOT NULL AUTO_INCREMENT,
  `usuemail` varchar(50) DEFAULT NULL,
  `ususenha` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`usucodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (2,'joao@gmail.com','123'),(3,'teste@gmail.com','1234'),(25,'rafael@gmail.com','123'),(33,'rafaelbandoch@gmail.com','1234');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-31 19:42:47
