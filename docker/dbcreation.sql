-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: devops
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add question',1,'add_question'),(2,'Can change question',1,'change_question'),(3,'Can delete question',1,'delete_question'),(4,'Can view question',1,'view_question'),(5,'Can add quiz',2,'add_quiz'),(6,'Can change quiz',2,'change_quiz'),(7,'Can delete quiz',2,'delete_quiz'),(8,'Can view quiz',2,'view_quiz'),(9,'Can add grade',3,'add_grade'),(10,'Can change grade',3,'change_grade'),(11,'Can delete grade',3,'delete_grade'),(12,'Can view grade',3,'view_grade'),(13,'Can add log entry',4,'add_logentry'),(14,'Can change log entry',4,'change_logentry'),(15,'Can delete log entry',4,'delete_logentry'),(16,'Can view log entry',4,'view_logentry'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add permission',7,'add_permission'),(26,'Can change permission',7,'change_permission'),(27,'Can delete permission',7,'delete_permission'),(28,'Can view permission',7,'view_permission'),(29,'Can add content type',8,'add_contenttype'),(30,'Can change content type',8,'change_contenttype'),(31,'Can delete content type',8,'delete_contenttype'),(32,'Can view content type',8,'view_contenttype'),(33,'Can add session',9,'add_session'),(34,'Can change session',9,'change_session'),(35,'Can delete session',9,'delete_session'),(36,'Can view session',9,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$DyE0cSjteqYy$zRFCYqtYBZMh+i5J00wY1yp5hJc64LTVsr5StoAVn9w=','2018-10-07 21:14:44.104212',1,'gcallah','','','gcallah@mac.com',1,1,'2018-08-25 20:41:00.068000'),(2,'pbkdf2_sha256$120000$82PPBOtFz61c$mXRpAHwDW3199evD3mtqGmJPVuDzUhFYkrUVK04w2Sw=','2018-09-19 01:58:18.532000',0,'robot_worker','Robot','Worker','noreply@nyu.edu',0,1,'2018-09-12 17:24:16.000000'),(3,'pbkdf2_sha256$120000$owtlrITQE8HO$xFkjOFRxZoo62a5alpSJk+i+qZLGMzTLkSYroaUK98M=','2018-09-20 21:06:56.631000',1,'felix','','','fab310@nyu.edu',1,1,'2018-09-20 20:59:42.023000'),(4,'pbkdf2_sha256$120000$fOKbNVF140GC$ZZJa14zo1RDLSuYNX1LOYIUnScP9G+2RknDx43YiJ9U=',NULL,0,'denis_petelin','','','',0,1,'2018-10-07 21:14:53.256522');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devops_grade`
--

DROP TABLE IF EXISTS `devops_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devops_grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` decimal(5,2) NOT NULL,
  `record_date` datetime(6) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `quiz_name` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `devops_grade_participant_id_28b5fdbb_fk_auth_user_id` (`participant_id`),
  KEY `devops_grade_quiz_id_317c3f35_fk_devops_quiz_id` (`quiz_id`),
  CONSTRAINT `devops_grade_participant_id_28b5fdbb_fk_auth_user_id` FOREIGN KEY (`participant_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `devops_grade_quiz_id_317c3f35_fk_devops_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `devops_quiz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devops_grade`
--

LOCK TABLES `devops_grade` WRITE;
/*!40000 ALTER TABLE `devops_grade` DISABLE KEYS */;
INSERT INTO `devops_grade` VALUES (1,36.36,'2018-09-19 01:46:58.155000',1,2,'work'),(2,36.36,'2018-09-19 01:58:40.507000',2,2,'work'),(3,100.00,'2018-09-20 20:21:00.139000',1,2,'work'),(4,14.29,'2018-09-20 20:39:18.384000',1,3,'incr'),(5,33.33,'2018-09-20 21:41:13.164000',1,1,'build'),(6,36.36,'2018-09-20 22:00:28.965000',3,2,'work'),(7,20.00,'2018-09-20 22:01:00.948000',3,4,'comm'),(8,42.86,'2018-09-20 22:01:48.370000',3,3,'incr'),(9,0.00,'2018-09-20 22:02:09.225000',3,1,'build'),(10,0.00,'2018-09-20 22:02:26.607000',3,7,'infra'),(11,0.00,'2018-09-20 22:02:33.119000',3,8,'cloud'),(12,100.00,'2018-09-20 22:04:24.456000',3,7,'infra'),(13,27.27,'2018-09-20 22:08:09.764000',1,2,'work'),(14,28.57,'2018-09-20 22:08:50.808000',1,3,'incr'),(15,10.00,'2018-09-20 23:17:24.177000',1,4,'comm'),(16,100.00,'2018-09-21 16:09:26.628000',1,1,'build'),(17,70.00,'2018-09-22 00:44:56.031000',1,4,'comm');
/*!40000 ALTER TABLE `devops_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devops_question`
--

DROP TABLE IF EXISTS `devops_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devops_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(16) NOT NULL,
  `text` varchar(256) NOT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `qtype` varchar(10) NOT NULL,
  `correct` varchar(1) NOT NULL,
  `answerA` varchar(128) DEFAULT NULL,
  `answerB` varchar(128) DEFAULT NULL,
  `answerC` varchar(128) DEFAULT NULL,
  `answerD` varchar(128) DEFAULT NULL,
  `answerE` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devops_question`
--

LOCK TABLES `devops_question` WRITE;
/*!40000 ALTER TABLE `devops_question` DISABLE KEYS */;
INSERT INTO `devops_question` VALUES (1,'build','Which of the following is an automated build tool?',1,'MCHOICE','C','git','slack','make','Docker',NULL),(2,'cloud','Which of the following is a cloud service provider?',1,'MCHOICE','d','AWS','Azure','Google Cloud Services','All of the above',NULL),(3,'comm','What is our main tool for communication in our course?',1,'MCHOICE','d','git','Docker','Kubernetes','Slack',NULL),(4,'work','Lean and agile development displaced the ____ model of development?',1,'MCHOICE','d','unicorn','silo','all-at-once','waterfall',NULL),(5,'incr','We develop incrementally because it....?',2,'MCHOICE','d','increases programmer satisfaction','produces less buggy software','delivers value to the customers faster','all of the above',NULL),(6,'incr','Version control is an important part of incremental development because...?',1,'MCHOICE','a','it allows us to roll back changes easily','it permits auditors to see how much work has been done','\"if you don\'t know your past you won\'t know your future.\"','all of the above',NULL),(7,'build','We want to automate our builds because...?',1,'MCHOICE','d','it reduces errors','it documents the build process','it allows engineers to do more interesting work','all of the above',NULL),(8,'build','An advantage of documenting a process by automating it versus writing a document about how it is done is that...?',1,'MCHOICE','c','scripts are easier to read than prose','it gives programmers an edge over tech writers in producing the documentation','the script can\'t be out of date with the process, while a text description can be','all of the above',NULL),(9,'infra','We want to regard our infrastructure as software because...?',1,'MCHOICE','b','that is what Bill Gates would do','that allows us to automate that provisioning of infrastructure','software is cool, while hardware is not','all of the above',NULL),(10,'infra','Containers can best be conceived as...?',1,'MCHOICE','c','a new sort of thread','a different way to test software','lightweight virtual machines','all of the above',NULL),(11,'work','The division of labor is cited by Adam Smith as...?',1,'MCHOICE','a','increasing productivity','decreasing productivity','make workers smarter','making jobs more enjoyable',NULL),(12,'work','One of the reasons the Waterfall Model often fails is...?',1,'MCHOICE','c','not enough advanced planning','the stages are not separated clearly enough in the model','we often only realize what software we need to build in the process of building it','none of the above',NULL),(13,'work','The DevOps idea of incremental development can be seen as an extension of...?',1,'MCHOICE','b','monolithic mainframe applications','the UNIX style of development','an all-at-once development style','all of the above',NULL),(14,'work','When we set out to develop software, we...?',1,'MCHOICE','d','usually know all we need to know at the start','can easily plan everything in advance','should lock down all requirements right away','rarely know all we need to know at the start',NULL),(15,'work','In software engineering, \"MVP\" stands for...?',1,'MCHOICE','a','minimum viable product','maximum value produced','major vehicle production','none of the above',NULL),(16,'work','In the Lean paradigm of development, decisions about the product should be made...?',1,'MCHOICE','c','right at the start','as soon as possible','as late as possible','none of the above',NULL),(17,'work','The term \"DevOps\" was created by combining the terms...?',1,'MCHOICE','a','development and operations','deviance and opacity','devilish and operatic','none of the above',NULL),(18,'work','DevOps can be understood as the need for _____ to keep up with ______ development practices.',1,'MCHOICE','d','Lean and Agile, operations','development, Lean and Agile','development, operations','operations, Lean and Agile',NULL),(19,'work','The advantages of incremental development include...?',1,'MCHOICE','d','value is delivered to customers more rapidly','testing becomes easier','programmer job satisfaction increases','all of the above',NULL),(20,'work','Automated testing is an important part of DevOps because...?',1,'MCHOICE','a','It enables rapid deployment of new software','\"Automated\" has a nice sound to it','It saves money in hiring testers.','none of the above',NULL),(21,'comm','Testing should be done on...?',1,'MCHOICE','c','only the most crucial code in the application','all of the application code','all of the application code AND all of the infrastructure code','none of the above',NULL),(22,'comm','In DevOps, \"silos\" refers to the fact that...?',1,'MCHOICE','a','departments in organizations often seemed sealed off from each other','good software should be divided into \"silos\"','granaries are major users of software','all of the above',NULL),(23,'comm','We want to script our environment so that...?',2,'MCHOICE','d','environments are always in a known state','we lessen the chance that knowledge is locked in team members\' heads','deployments are more predictable and repeatable','all of the above',NULL),(24,'comm','\"Chaos Monkey\" is...?',1,'MCHOICE','a','a tool Netflix developed to intentionally crash their servers','a description of who is in charge of most software projects','the state of infrastructure before DevOps','none of the above',NULL),(25,'comm','The right artifacts of a project to put under version control are...?',2,'MCHOICE','d','project source code','scripts to build the project infrastructure','project documentation','all of the above',NULL),(26,'comm','If we version control everything about our project, we...?',1,'MCHOICE','c','create a big mess no one could understand','waste a lot of time','establish a single source of truth for the system','clog our version control system with trivial stuff',NULL),(27,'comm','Who should have \"ownership\" (be able to change) parts of a product in an agile team?',2,'MCHOICE','b','only the creator of that part','anyone on the team','only the project supervisor','only the system administrator',NULL),(28,'comm','A poly-skilled engineer',1,'MCHOICE','c','graduated from NYU Poly','knows several languages','knows all parts of the technology their team uses','all of the above',NULL),(29,'comm','An advantage Slack has over email threads is',1,'MCHOICE','d','people can join and leave threads as they need to','people won\'t forget to include someone who needs to see a message','it is easy to bring in a new person and have them pick up on the whole conversation','all of the above',NULL),(30,'incr','git and GitHub are...?',1,'MCHOICE','b','just different names for the same software','very different: git is the basic version control software, while GitHub is a place to store git repos','entirely unrelated','none of the above',NULL),(31,'incr','Commit messages in git are...?',1,'MCHOICE','a','important to communicate to team members what you are up to','unimportant and should be ignored','can be the same for every commit','generated automatically',NULL),(32,'incr','We use \"git clone\" to...?',1,'MCHOICE','c','add a clone of a file to a repo','turn one repo into two repos','make a local copy of a repo','all of the above',NULL),(33,'incr','If we see text like \"<<<<< HEAD:file.txt\" inserted into a file, that is...?',1,'MCHOICE','c','the header for the file','a UNIX command accidentally inserted in the file','git showing us where a conflict is in file.txt','none of the above',NULL),(34,'incr','If you type \'git pull origin master\' then master is...?',1,'MCHOICE','a','the branch you are pulling','the level of difficulty of the pull','the repo you are pulling from','how much git should try to force the pull',NULL),(35,'incr','Incremental and iterative development were a response to failures in...?',1,'MCHOICE','b','functional programming','the waterfall model','test-driven development','resume-driven development',NULL),(36,'incr','The problem with describing a server setup in a detailed document is...?',1,'MCHOICE','d','an engineer has to manually do the setup','the document will get out of date','the document is likely to miss some \"obvious\" step','all of the above',NULL),(37,'incr','Automated deployment should be coupled with...?',1,'MCHOICE','a','automated tests','manual steps to make sure the sys admin is on their toes','manual configuration','none of the above',NULL);
/*!40000 ALTER TABLE `devops_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devops_quiz`
--

DROP TABLE IF EXISTS `devops_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devops_quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(16) NOT NULL,
  `minpass` double NOT NULL,
  `numq` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devops_quiz`
--

LOCK TABLES `devops_quiz` WRITE;
/*!40000 ALTER TABLE `devops_quiz` DISABLE KEYS */;
INSERT INTO `devops_quiz` VALUES (1,'build',80,10),(2,'work',80,11),(3,'incr',80,7),(4,'comm',80,10),(5,'flow',80,10),(6,'test',80,10),(7,'infra',80,10),(8,'cloud',80,10),(9,'micro',80,10),(10,'monit',80,10),(11,'secur',80,10),(12,'sum',80,10);
/*!40000 ALTER TABLE `devops_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-08-28 06:24:59.158000','1','Quiz for build',1,'[{\"added\": {}}]',8,1),(2,'2018-08-28 06:26:17.236000','1','Which of the following is an automated build tool?',1,'[{\"added\": {}}]',7,1),(3,'2018-08-28 06:50:15.393000','2','Which of the following is a cloud service provider?',1,'[{\"added\": {}}]',7,1),(4,'2018-08-28 07:31:04.353000','3','What is our main tool for communication in our course?',1,'[{\"added\": {}}]',7,1),(5,'2018-08-29 04:45:05.584000','4','Lean and agile development displaced the ____ model of development?',1,'[{\"added\": {}}]',7,1),(6,'2018-08-29 04:47:07.266000','5','We develop incrementally because it....?',1,'[{\"added\": {}}]',7,1),(7,'2018-08-29 04:49:25.947000','6','Version control is an important part of incremental development because...?',1,'[{\"added\": {}}]',7,1),(8,'2018-08-29 04:52:28.601000','7','We want to automate our builds because...?',1,'[{\"added\": {}}]',7,1),(9,'2018-08-29 05:03:14.268000','8','An advantage of documenting a process by automating it versus writing a document about how it is done is that...?',1,'[{\"added\": {}}]',7,1),(10,'2018-08-29 07:14:41.506000','9','We want to regard our infrastructure as software because...?',1,'[{\"added\": {}}]',7,1),(11,'2018-08-29 07:17:52.730000','10','Containers can best be conceived as...\"',1,'[{\"added\": {}}]',7,1),(12,'2018-08-29 07:18:27.121000','10','Containers can best be conceived as...?',2,'[{\"changed\": {\"fields\": [\"text\"]}}]',7,1),(13,'2018-08-30 04:51:58.613000','11','The division of labor is cited by Adam Smith as...?',1,'[{\"added\": {}}]',7,1),(14,'2018-08-30 04:53:33.605000','12','One of the reasons the Waterfall Model often fails is...?',1,'[{\"added\": {}}]',7,1),(15,'2018-08-30 04:55:22.991000','13','The DevOps idea of incremental development can be seen as an extension of...?',1,'[{\"added\": {}}]',7,1),(16,'2018-08-30 05:17:19.404000','14','When we set out to develop software, we...?',1,'[{\"added\": {}}]',7,1),(17,'2018-08-30 05:30:05.885000','15','In software engineering, \"MVP\" stands for...?',1,'[{\"added\": {}}]',7,1),(18,'2018-08-30 05:37:32.742000','16','In the Lean paradigm of development, decisions about the product should be made...?',1,'[{\"added\": {}}]',7,1),(19,'2018-08-30 05:56:31.643000','17','The term \"DevOps\" was created by combining the terms...?',1,'[{\"added\": {}}]',7,1),(20,'2018-08-30 06:04:49.481000','18','DevOps can be understood as the need for _____ to keep up with ______ development practices.',1,'[{\"added\": {}}]',7,1),(21,'2018-08-30 06:23:47.626000','19','The advantages of incremental development include...?',1,'[{\"added\": {}}]',7,1),(22,'2018-08-31 04:56:35.195000','20','Automated testing is an important part of DevOps because...?',1,'[{\"added\": {}}]',7,1),(23,'2018-09-03 04:50:49.174000','21','Testing should be done on...?',1,'[{\"added\": {}}]',7,1),(24,'2018-09-03 04:55:03.692000','22','In DevOps, \"silos\" refers to the fact that...?',1,'[{\"added\": {}}]',7,1),(25,'2018-09-03 04:57:32.675000','23','We want to script our environment so that...?',1,'[{\"added\": {}}]',7,1),(26,'2018-09-03 05:08:16.050000','24','\"Chaos Monkey\" is...?',1,'[{\"added\": {}}]',7,1),(27,'2018-09-03 05:09:47.608000','25','The right artifacts of a project to put under version control are...?',1,'[{\"added\": {}}]',7,1),(28,'2018-09-03 05:10:35.265000','23','We want to script our environment so that...?',2,'[{\"changed\": {\"fields\": [\"answerD\"]}}]',7,1),(29,'2018-09-03 05:12:25.277000','26','If we version control everything about our project, we...?',1,'[{\"added\": {}}]',7,1),(30,'2018-09-03 05:18:36.862000','27','Who should have \"ownership\" (be able to change) parts of a product in an agile team?',1,'[{\"added\": {}}]',7,1),(31,'2018-09-03 05:19:58.519000','28','A poly-skilled engineer',1,'[{\"added\": {}}]',7,1),(32,'2018-09-03 05:38:53.385000','29','An advantage Slack has over email threads is',1,'[{\"added\": {}}]',7,1),(33,'2018-09-04 13:07:38.908000','30','git and GitHub are...?',1,'[{\"added\": {}}]',7,1),(34,'2018-09-04 13:09:29.611000','31','Commit messages in git are...?',1,'[{\"added\": {}}]',7,1),(35,'2018-09-04 13:31:15.066000','32','We use \"git clone\" to...?',1,'[{\"added\": {}}]',7,1),(36,'2018-09-12 17:24:16.451000','2','test_user',1,'[{\"added\": {}}]',4,1),(37,'2018-09-12 17:25:26.132000','2','robot_worker',2,'[{\"changed\": {\"fields\": [\"username\", \"first_name\", \"last_name\", \"email\", \"last_login\"]}}]',4,1),(38,'2018-09-19 01:43:57.962000','2','Quiz for work',1,'[{\"added\": {}}]',8,1),(39,'2018-09-20 20:14:09.062000','33','If we see text like \"<<<<< HEAD:file.txt\" inserted into a file, that is...?',1,'[{\"added\": {}}]',7,1),(40,'2018-09-20 20:17:21.066000','34','If you type \"git pull origin master\" then master is...?',1,'[{\"added\": {}}]',7,1),(41,'2018-09-20 20:27:06.784000','34','If you type \'git pull origin master\' then master is...?',2,'[{\"changed\": {\"fields\": [\"text\"]}}]',7,1),(42,'2018-09-20 20:33:15.514000','3','Quiz for incr',1,'[{\"added\": {}}]',8,1),(43,'2018-09-20 21:25:13.326000','4','Quiz for comm',1,'[{\"added\": {}}]',8,3),(44,'2018-09-20 21:26:05.489000','5','Quiz for flow',1,'[{\"added\": {}}]',8,3),(45,'2018-09-20 21:26:22.683000','6','Quiz for test',1,'[{\"added\": {}}]',8,3),(46,'2018-09-20 21:26:30.926000','7','Quiz for infra',1,'[{\"added\": {}}]',8,3),(47,'2018-09-20 21:26:36.815000','8','Quiz for cloud',1,'[{\"added\": {}}]',8,3),(48,'2018-09-20 21:26:42.218000','9','Quiz for micro',1,'[{\"added\": {}}]',8,3),(49,'2018-09-20 21:26:47.750000','10','Quiz for monit',1,'[{\"added\": {}}]',8,3),(50,'2018-09-20 21:26:53.755000','11','Quiz for secur',1,'[{\"added\": {}}]',8,3),(51,'2018-09-20 21:26:59.428000','12','Quiz for sum',1,'[{\"added\": {}}]',8,3),(52,'2018-09-23 04:17:11.874000','35','Incremental and iterative development were a response to failures in...?',1,'[{\"added\": {}}]',7,1),(53,'2018-09-23 04:21:07.523000','36','The problem with describing a server setup in a detailed document is...?',1,'[{\"added\": {}}]',7,1),(54,'2018-09-23 04:23:40.322000','37','Automated deployment should be coupled with...?',1,'[{\"added\": {}}]',7,1),(55,'2018-10-07 21:14:53.400940','4','denis_petelin',1,'[{\"added\": {}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (4,'admin','logentry'),(5,'auth','group'),(7,'auth','permission'),(6,'auth','user'),(8,'contenttypes','contenttype'),(3,'devops','grade'),(1,'devops','question'),(2,'devops','quiz'),(9,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-09-25 02:16:34.300402'),(2,'auth','0001_initial','2018-09-25 02:16:34.469042'),(3,'admin','0001_initial','2018-09-25 02:16:34.512890'),(4,'admin','0002_logentry_remove_auto_add','2018-09-25 02:16:34.523240'),(5,'admin','0003_logentry_add_action_flag_choices','2018-09-25 02:16:34.549900'),(6,'contenttypes','0002_remove_content_type_name','2018-09-25 02:16:34.586882'),(7,'auth','0002_alter_permission_name_max_length','2018-09-25 02:16:34.593205'),(8,'auth','0003_alter_user_email_max_length','2018-09-25 02:16:34.604736'),(9,'auth','0004_alter_user_username_opts','2018-09-25 02:16:34.614436'),(10,'auth','0005_alter_user_last_login_null','2018-09-25 02:16:34.637054'),(11,'auth','0006_require_contenttypes_0002','2018-09-25 02:16:34.639982'),(12,'auth','0007_alter_validators_add_error_messages','2018-09-25 02:16:34.649698'),(13,'auth','0008_alter_user_username_max_length','2018-09-25 02:16:34.666171'),(14,'auth','0009_alter_user_last_name_max_length','2018-09-25 02:16:34.678201'),(15,'devops','0001_initial','2018-09-25 02:16:34.705961'),(16,'devops','0002_grade','2018-09-25 02:16:34.752818'),(17,'devops','0003_grade_quiz_name','2018-09-25 02:16:34.775651'),(18,'devops','0004_auto_20180917_1759','2018-09-25 02:16:34.802217'),(19,'sessions','0001_initial','2018-09-25 02:16:34.816957');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2ta4mtd5y9ejrmtb03ts53qxwhzglbzy','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-04 20:31:08.300000'),('atp0n5zdy8w5vdagpjidglawznhfbsat','ZDc3OTg2YTRmNmI4NGE2MWZiNzkyNDIyMzNjYzYxZmEzOGNhMmJhYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiYzhmNjZhZGEwYWE4YWNhZDM2ODJjZDQ5ZGFkZjlhMTRjM2ZjZDk4In0=','2018-09-08 20:41:21.915000'),('efug1rns7dj76jptnfx0ebimbvdipyc4','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-07 04:13:24.885000'),('jah2gqivddmp1zlg479bpod7zdf098j0','M2RhM2UwMjU1MmJiZWVhZjIyZDZkODM1YzhhNmMyMDA3Y2E3MzljNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGIyZjg5YjYxMDk4N2FkYjFiODY0NDk1Njk4ZjE1ZWM0ZWJjNGY2ZSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2018-10-07 19:13:32.371000'),('klfq0kdzxj2ksnlud9wy09p6xx5ftj8l','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-21 21:14:44.107682'),('ni3qvaol2bso6l5c8iwaglfo9qwwbz3y','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-02 01:21:07.920000'),('npm37ofnrujkdfisartump9wkag6s38u','Y2ZjODQ1ZWFjNzI4ODFmNWU1Y2ExMTZmNTJlNTg1ZDgwYjljOGViYTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkZjU5ZjQ5NjhjYmVmZGU3MmNjMjQzMTMwYjFlNTY5YzExYTFhNmZkIn0=','2018-10-04 21:06:56.659000'),('v13dzrsp3tu8srcrp77tyia1p6e1ju4u','ZWEwZjgyZDA0YmZhZjNlN2VlYjVkOTJlZTI5YmQ0MmVjZWM3NWI3Njp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNWY4YTRkYTFlMGI2OTQ4YTNlZDA3ZjUyYzI4OGZmMTU4MWQ5ZjVmIn0=','2018-09-26 19:52:25.245000'),('wgsmgs207ac357xa2fxplar0et597tdr','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-03 01:42:35.639000'),('xz16k87gg0zfmf9iz32f07ueh2jh7blt','MmVjMWUxZmNkMDg5ZTg5Y2QyMDQ1Y2NlZmNjYjM3Yjg5MGFhNzY1ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjJmODliNjEwOTg3YWRiMWI4NjQ0OTU2OThmMTVlYzRlYmM0ZjZlIn0=','2018-10-04 20:08:15.838000');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-07 18:21:29
