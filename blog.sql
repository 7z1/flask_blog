-- MySQL dump 10.13  Distrib 5.7.18, for macos10.12 (x86_64)
--
-- Host: localhost    Database: blog_site
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('e9ef002095cd');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_adminuser`
--

DROP TABLE IF EXISTS `info_adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_adminuser` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `description` varchar(256) NOT NULL,
  `keywords` varchar(256) NOT NULL,
  `email` varchar(64) NOT NULL,
  `wxid` varchar(64) NOT NULL,
  `wxcode` varchar(64) NOT NULL,
  `butoom_title` varchar(64) NOT NULL,
  `beian` varchar(64) NOT NULL,
  `about_me` text NOT NULL,
  `card_about` varchar(64) NOT NULL,
  `card_job` varchar(64) NOT NULL,
  `card_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `card_avatar` varchar(64) NOT NULL,
  `logo_image` varchar(64) NOT NULL,
  `logo_name` varchar(64) NOT NULL,
  `tags` varchar(256) NOT NULL,
  `qq` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_adminuser`
--

LOCK TABLES `info_adminuser` WRITE;
/*!40000 ALTER TABLE `info_adminuser` DISABLE KEYS */;
INSERT INTO `info_adminuser` VALUES ('2018-09-27 15:13:02','2018-10-02 16:49:59',1,'棋子个人博客 - 码农直男癌 - 个人博客网站','棋子个人博客，码农直男癌，python','个人博客,棋子个人博客,个人博客模板,7z1','krosy@china.com','De4thNote','http://blog.xiaosankexing.com/FgUTby20kFXE4F40ge0DeyEAMRsN','棋子个人博客','暂无备案','<p style=\"text-align:center\">这个人很懒，什么都没有留下。</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">测试数据</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">本站点基于Flask实现</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">前端代码是百度找来的博客源码，下载地址：</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">下载地址忘记了，是一个叫杨青的博主写的/[手动黑脸]</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">自行集成以下功能</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">文章推荐 ---- 设置文章是否首页推荐，banner推荐，top图推荐</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">文章管理 ---- 逻辑删除，真实删除与恢复</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">留言管理 --- 集成第三方留言插件在前端页面留言，后台回复或删除留言</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">新增文章，编辑文章 ----- 采用CkEditor文本编辑插件，方便上传文件</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">回收站&nbsp; ----&nbsp; 对逻辑删除的留言或者文章，采取进一步操作，恢复或删除</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">系统管理 --- 新增管理员/账号管理/修改管理员账号密码</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">查询服务器运行状态，内存CPU使用量</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">数据库备份恢复 -----&nbsp; 数据导出 / 导入</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">程序地址：</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n\n<p style=\"text-align:center\">等所有功能写完在上传吧</p>\n\n<p style=\"text-align:center\">&nbsp;</p>\n','一个90后草根码农！09年入行。一直潜心研究web网络安全技术，目前一边工作一边积累经验，记录一些个人经验。','Python、码农、直男癌','7z1 | 棋子','http://blog.xiaosankexing.com/FkYTTlB4LR8g0RT2tq_xcpk5aRIy','','7z\'s Blog','爬虫,Django,flask,Python,sec,灰帽,web安全,数据统计,佛系程序员,wooyun,搬砖,apt,个人博客,web渗透,内网渗透,数据分析,伪黑阔,黑盒测试,灰盒测试,内网apt攻击','administrator@china.com');
/*!40000 ALTER TABLE `info_adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_category`
--

DROP TABLE IF EXISTS `info_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_category` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_category`
--

LOCK TABLES `info_category` WRITE;
/*!40000 ALTER TABLE `info_category` DISABLE KEYS */;
INSERT INTO `info_category` VALUES ('2018-09-29 01:54:35','2018-10-03 19:45:09',1,'All'),('2018-09-29 01:56:51','2018-10-03 19:44:52',2,'Python'),('2018-09-29 01:57:08','2018-10-03 19:44:56',3,'Bug List'),('2018-10-03 19:44:29','2018-10-03 19:45:03',4,'Other');
/*!40000 ALTER TABLE `info_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_comment`
--

DROP TABLE IF EXISTS `info_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_comment` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `like_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `info_comment_ibfk_3` FOREIGN KEY (`news_id`) REFERENCES `info_news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `info_comment_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `info_comment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_comment`
--

LOCK TABLES `info_comment` WRITE;
/*!40000 ALTER TABLE `info_comment` DISABLE KEYS */;
INSERT INTO `info_comment` VALUES ('2018-09-30 10:49:54','2018-09-30 10:49:54',1,7,'1111',NULL,0),('2018-09-30 10:49:57','2018-09-30 10:50:17',2,7,'111',NULL,0),('2018-09-30 10:50:01','2018-09-30 10:50:01',3,7,'111',2,0),('2018-09-30 10:50:02','2018-09-30 10:50:02',4,7,'111',2,0),('2018-09-30 10:50:12','2018-09-30 10:50:12',5,7,'111',2,0),('2018-09-30 10:50:21','2018-09-30 10:50:21',6,7,'333',1,0),('2018-10-02 00:30:13','2018-10-02 00:30:13',7,7,'111',NULL,0),('2018-10-02 00:30:16','2018-10-02 00:30:16',8,7,'333',7,0),('2018-10-02 00:30:27','2018-10-02 00:30:27',9,7,'123',NULL,0),('2018-10-02 00:30:32','2018-10-02 00:30:32',10,7,'456',9,0),('2018-10-02 00:34:43','2018-10-02 00:34:43',11,7,'1111',NULL,0),('2018-10-02 00:34:51','2018-10-02 00:34:51',12,7,'1234',11,0),('2018-10-02 00:36:53','2018-10-02 00:36:53',13,7,'3333',NULL,0),('2018-10-02 00:36:56','2018-10-02 00:36:56',14,7,'123',13,0),('2018-10-02 00:37:54','2018-10-02 00:37:54',15,7,'333',NULL,0),('2018-10-02 00:37:57','2018-10-02 00:38:51',16,7,'444',15,1),('2018-10-03 01:30:48','2018-10-03 01:30:48',17,11,'文章评论emoji测试👿🐑',NULL,0),('2018-10-03 16:17:06','2018-10-03 16:17:06',18,11,'xss测试<script>alert(\'ceshi\')</script>',NULL,0);
/*!40000 ALTER TABLE `info_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_gbook`
--

DROP TABLE IF EXISTS `info_gbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_gbook` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `replyName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `son_id` int(11) DEFAULT NULL,
  `beReplyName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `os_name` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `son_id` (`son_id`),
  CONSTRAINT `info_gbook_ibfk_1` FOREIGN KEY (`son_id`) REFERENCES `info_gbook` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_gbook`
--

LOCK TABLES `info_gbook` WRITE;
/*!40000 ALTER TABLE `info_gbook` DISABLE KEYS */;
INSERT INTO `info_gbook` VALUES ('2018-09-30 19:07:07','2018-09-30 19:07:12',1,NULL,NULL,'测试留言','测试者',NULL,'',NULL,NULL),('2018-09-30 19:07:34','2018-09-30 19:07:41',2,NULL,NULL,'测试留言2',NULL,NULL,NULL,NULL,NULL),('2018-09-30 19:08:00','2018-09-30 19:08:05',3,NULL,NULL,'33333',NULL,NULL,NULL,NULL,NULL),('2018-09-30 23:44:30','2018-09-30 23:44:35',4,NULL,NULL,'44444','帅大叔',NULL,'',NULL,NULL),('2018-10-01 01:31:08','2018-10-01 01:31:08',5,NULL,NULL,'dddd','匿名',NULL,'',NULL,NULL),('2018-10-01 01:35:44','2018-10-01 01:35:44',6,NULL,NULL,'dddd','匿名',NULL,NULL,NULL,NULL),('2018-10-01 01:56:29','2018-10-01 01:56:29',7,NULL,NULL,'dasda1111','匿名',NULL,NULL,NULL,NULL),('2018-10-01 02:20:17','2018-10-01 02:20:17',8,NULL,'krosy@qq.com','测试留言','匿名',NULL,NULL,NULL,NULL),('2018-10-01 02:20:58','2018-10-01 02:20:58',9,NULL,NULL,'对对对','匿名',NULL,NULL,NULL,NULL),('2018-10-01 02:23:39','2018-10-01 02:23:39',10,NULL,NULL,'222','匿名',NULL,NULL,NULL,NULL),('2018-10-01 02:24:18','2018-10-01 02:24:18',11,NULL,NULL,'1212121','测试',NULL,NULL,NULL,NULL),('2018-10-01 02:25:30','2018-10-01 02:25:30',12,NULL,NULL,'测试数据','留言测试',NULL,NULL,NULL,NULL),('2018-10-01 02:25:47','2018-10-01 02:25:47',13,NULL,NULL,'呵呵','哈哈',NULL,NULL,NULL,NULL),('2018-10-01 02:28:16','2018-10-01 02:28:16',14,NULL,NULL,'321','123',NULL,NULL,NULL,NULL),('2018-10-01 02:29:28','2018-10-01 02:29:28',15,NULL,NULL,'哈哈？','匿名',NULL,NULL,NULL,NULL),('2018-10-01 02:30:01','2018-10-01 02:30:01',16,NULL,NULL,'测试测试','匿名',NULL,NULL,NULL,NULL),('2018-10-01 04:02:54','2018-10-01 04:02:54',25,'127.0.0.1',NULL,'删除回复测试','测试',NULL,NULL,NULL,NULL),('2018-10-01 04:03:05','2018-10-01 04:03:05',26,'127.0.0.1',NULL,'删除回复测试','热心网民',NULL,NULL,NULL,NULL),('2018-10-01 04:03:15','2018-10-01 04:03:15',27,'127.0.0.1',NULL,'测试留言','热心网民',NULL,NULL,NULL,NULL),('2018-10-01 04:04:26','2018-10-01 04:04:26',28,'127.0.0.1',NULL,'测试数据','test',NULL,NULL,NULL,NULL),('2018-10-01 04:05:42','2018-10-01 04:20:23',29,'127.0.0.1',NULL,'cdsacasdas','test',NULL,NULL,NULL,NULL),('2018-10-01 04:06:01','2018-10-01 04:06:01',30,NULL,NULL,'回复测试','admin',NULL,'test',NULL,NULL),('2018-10-02 00:55:29','2018-10-02 00:55:29',31,'127.0.0.1',NULL,'ddd','热心网民',NULL,NULL,NULL,NULL),('2018-10-02 00:55:58','2018-10-02 00:55:58',32,'127.0.0.1',NULL,'ddd','热心网民',NULL,NULL,NULL,NULL),('2018-10-02 00:57:47','2018-10-02 01:30:30',33,'127.0.0.1',NULL,'ddd','热心网民',41,NULL,NULL,NULL),('2018-10-02 01:15:22','2018-10-02 01:15:22',34,'127.0.0.1',NULL,'ceshi','热心网民',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:18:56','2018-10-02 01:18:56',35,'127.0.0.1',NULL,'浏览器测试','热心网民',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:20:44','2018-10-02 01:20:44',36,'127.0.0.1','krosy@qq.com','11111','a4demon',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:20:54','2018-10-02 01:20:54',37,'127.0.0.1','krosy@qq.com','11111','a4demon',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:22:37','2018-10-02 01:22:37',38,'127.0.0.1','krosy@qq.com','3333','18888888888',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:23:47','2018-10-02 01:23:47',39,'127.0.0.1','krosy@qq.com','dsds','test',NULL,NULL,'Chrome','OS X'),('2018-10-02 01:25:55','2018-10-02 01:35:34',40,'127.0.0.1','krosy@qq.com','323232','👿',42,NULL,'Chrome','OS X'),('2018-10-02 01:30:30','2018-10-02 01:30:30',41,NULL,NULL,'回复测试','admin',NULL,'热心网民',NULL,NULL),('2018-10-02 01:35:34','2018-10-02 01:35:34',42,NULL,NULL,'回复测试','👿',NULL,'👿',NULL,NULL),('2018-10-03 01:29:51','2018-10-03 01:29:51',43,'127.0.0.1','krosy@qq.com','🐑测试emoji','🐑🐑🐑',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:21:35','2018-10-03 16:21:35',50,'127.0.0.1',NULL,'xss防御测试','(script>alert(\'test\')</script>',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:22:19','2018-10-03 16:22:19',51,'127.0.0.1',NULL,'对对对','(script>alert(\'test\')</script>',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:25:13','2018-10-03 16:25:13',52,'127.0.0.1',NULL,'ddd','(script>alert(\'test\')</script>',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:43:00','2018-10-03 16:43:00',55,'127.0.0.1',NULL,'xss(script)alert(\'test\')(/script)','(script)alert(\'test\')(/script)',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:44:58','2018-10-03 16:44:58',56,'127.0.0.1',NULL,'(script)alert(\'test\')(/script)','(script)alert(\'test\')(/script)',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:46:01','2018-10-03 16:46:01',57,'127.0.0.1',NULL,'(script)alert(\'test\')(/script)','(script)alert(\'test\')(/script)',NULL,NULL,'Chrome','OS X'),('2018-10-03 16:47:13','2018-10-03 16:47:13',58,'127.0.0.1',NULL,'(script)alert(\'test\')(/script)','(script)alert(\'test\')(/script)',NULL,NULL,'Chrome','OS X'),('2018-10-03 21:01:18','2018-10-03 21:01:18',59,'127.0.0.1',NULL,'(script)alert(\'test\')(/script)','(script)alert(\'test\')(/script)',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:16','2018-10-10 01:33:16',60,'127.0.0.1',NULL,'1','1',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:39','2018-10-10 01:33:39',61,'127.0.0.1',NULL,'2','2',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:45','2018-10-10 01:33:45',62,'127.0.0.1',NULL,'3','3',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:48','2018-10-10 01:33:48',63,'127.0.0.1',NULL,'4','4',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:50','2018-10-10 01:33:50',64,'127.0.0.1',NULL,'5','5',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:53','2018-10-10 01:33:53',65,'127.0.0.1',NULL,'6','6',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:57','2018-10-10 01:33:57',66,'127.0.0.1',NULL,'7','7',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:33:59','2018-10-10 01:33:59',67,'127.0.0.1',NULL,'8','8',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:34:02','2018-10-10 01:34:02',68,'127.0.0.1',NULL,'9','9',NULL,NULL,'Chrome','OS X'),('2018-10-10 01:34:07','2018-10-10 01:34:07',69,'127.0.0.1',NULL,'10','10',NULL,NULL,'Chrome','OS X');
/*!40000 ALTER TABLE `info_gbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_link`
--

DROP TABLE IF EXISTS `info_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_link` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `url` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_link`
--

LOCK TABLES `info_link` WRITE;
/*!40000 ALTER TABLE `info_link` DISABLE KEYS */;
INSERT INTO `info_link` VALUES ('2018-10-06 03:36:00','2018-10-06 03:36:02',1,'y3\'s 个人博客','http://www.yangyanying.xin/'),('2018-10-06 03:36:40','2018-10-06 03:36:46',2,'7z\'s 个人博客','http://www.7z1.xyz/'),('2018-10-06 04:27:27','2018-10-06 04:46:48',3,'新浪','http://www.sina.com.cn/');
/*!40000 ALTER TABLE `info_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_news`
--

DROP TABLE IF EXISTS `info_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_news` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(64) CHARACTER SET utf8 NOT NULL,
  `digest` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `clicks` int(11) DEFAULT NULL,
  `index_image_url` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `like_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `info_news_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `info_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_news`
--

LOCK TABLES `info_news` WRITE;
/*!40000 ALTER TABLE `info_news` DISABLE KEYS */;
INSERT INTO `info_news` VALUES ('2018-09-29 22:47:45','2018-10-02 00:29:45',4,'CKEditor 提示图片上传成功，但却不能预览解决办法之一','棋子。','问题起因：  config.js文件都配置好了，页面上也显示了富文本编辑器，点击图片上传，上传到服务器，提示上传也成功了，本地文件夹里也没有有图片。但是预览块就是没有图片，只有一个红色的错误提示图片。','<p><strong>问题起因：</strong></p>\n\n<p>config.js文件都配置好了，页面上也显示了富文本编辑器，点击图片上传，上传到服务器，提示上传也成功了，本地文件夹里也没有有图片。但是预览块就是没有图片，只有一个红色的错误提示图片。</p>\n\n<p>&nbsp;</p>\n\n<p><strong>解决思路：</strong></p>\n\n<p>各种百度查资料，大部分都是说文件配置问题，但是，我这里以前也使用过配置是没问题的。所以我就从图片路径上找问题。上传没问题，就找回显到预览的路径。发现，富文本编辑器里已经有了img标签，图片也是本地的路径。但是我把图片地址复制到浏览器中打开，也显示不出来，后来在pycharm中打印filepath，发现中间少了个文件夹，原来是我BASE_DIR路径指定错了，重新指定上传路径，图片就出来了。</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"/static/upload/201809292247348395.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p><strong>最后总结：</strong></p>\n\n<p>其实图片预览时会拿当前文件之前的路径加到图片路径之前，如果这之前多了个文件夹就会干扰图片的预览，导致找不到图片。讲真，我在解决问题之前，一直在找配置文件的问题。好了，问题解决了，希望能帮助到遇到这问题的人。</p>\n',117,'http://blog.xiaosankexing.com/FrCOTng3iQEgcccbXzO6GBMa3u44',3,0,0),('2018-09-29 22:57:08','2018-10-02 17:27:35',5,'CKEditor 4.10.1 上传图片提示“不正确的服务器响应” 问题解决','棋子。','最近项目采用CKEditor 4 富文本编辑器，上传图片时提示\"不正确的服务器响应\" , 查看官方文档要求返回json格式，官方示例：','<p>最近项目采用CKEditor 4 富文本编辑器，上传图片时提示&quot;不正确的服务器响应&quot; , 查看官方文档要求返回json格式，官方示例：</p>\n\n<p>Response: File Uploaded Successfully&nbsp;</p>\n\n<p>上传成功返回：</p>\n\n<p>{<br />\n&nbsp; &nbsp; &quot;uploaded&quot;: 1,<br />\n&nbsp; &nbsp; &quot;fileName&quot;: &quot;foo.jpg&quot;,<br />\n&nbsp; &nbsp; &quot;url&quot;: &quot;/files/foo.jpg&quot;<br />\n}</p>\n\n<p>{<br />\n&nbsp; &nbsp; &quot;uploaded&quot;: 1,<br />\n&nbsp; &nbsp; &quot;fileName&quot;: &quot;foo(2).jpg&quot;,<br />\n&nbsp; &nbsp; &quot;url&quot;: &quot;/files/foo(2).jpg&quot;,<br />\n&nbsp; &nbsp; &quot;error&quot;: {<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &quot;message&quot;: &quot;A file with the same name already exists. The uploaded file was renamed to \\&quot;foo(2).jpg\\&quot;.&quot;<br />\n&nbsp; &nbsp; }<br />\n}</p>\n\n<p>Response: File Could Not Be Uploaded</p>\n\n<p>上传失败返回：</p>\n\n<p>{<br />\n&nbsp; &nbsp; &quot;uploaded&quot;: 0,<br />\n&nbsp; &nbsp; &quot;error&quot;: {<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &quot;message&quot;: &quot;The file is too big.&quot;<br />\n&nbsp; &nbsp; }<br />\n}</p>\n\n<p>地址：<a href=\"https://ckeditor.com/docs/ckeditor4/latest/guide/dev_file_upload.html\" rel=\"nofollow\" target=\"_blank\">https://ckeditor.com/docs/ckeditor4/latest/guide/dev_file_upload.html</a></p>\n\n<p>&nbsp;</p>\n\n<pre>\nreturn jsonify({&quot;uploaded&quot;: 1, &quot;fileName&quot;: rnd_name, &quot;url&quot;: url})</pre>\n',155,'http://blog.xiaosankexing.com/FrCOTng3iQEgcccbXzO6GBMa3u44',2,0,0),('2018-09-30 02:08:32','2018-10-02 00:29:59',6,'ckeditor上传图片时与后端的csrfToken验证','棋子。','ckeditor上传图片时会提交自己的csrf token，名字叫“ckCsrfToken“。  如果后端配置有csrf校验，这会产生冲突，解决办法有两种，一种是是对指定的表单提交添加csrfToken的HTML的代码，第二种是修改csrf的cookie名称方法。','<p>ckeditor上传图片时会提交自己的csrf token，名字叫&ldquo;ckCsrfToken&ldquo;。<br />\n如果后端配置有csrf校验，这会产生冲突，解决办法有两种，一种是是对指定的表单提交添加csrfToken的HTML的代码，第二种是修改csrf的cookie名称方法。</p>\n\n<p>1、设定ckeditor的默认值，如果是通过接口拿数据，这需要等ckeditor实例构建完成后设置</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>editor.on(\"instanceReady\", function(ev) {\n  self.$http.get(url)\n    .then(function(response) {\n      if (response.body.success) {\n        ev.editor.setData(response.body.content);\n      }\n    });\n});\n</code></pre>\n\n<p>&nbsp;</p>\n\n<p>2、采用第一种方式，通过在上传图片表单中插入html代码</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>&lt;input type=\"hidden\" name=\"csrfmiddlewaretoken\" value=getCookie(\"csrftoken\")&gt;</code></pre>\n\n<p>&nbsp;</p>\n\n<p>chrome和IE都有效，但是该方法在firefox中无效。</p>\n\n<p>2、采用第二种方式，修改ckcsrfToken的取值和名称与后端需要的token名称和取值一致，通过修改ckeditor.js的源码</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>getCsrfToken:function(){\nvar a=CKEDITOR.tools.getCookie(\"ckCsrfToken\"); if(!a||40!=a.length){\nvar a=[],b=\"\"; \nif(window.crypto&amp;&amp;window.crypto.getRandomValues)\na=new Uint8Array(40),</code></pre>\n\n<p>&nbsp;</p>\n\n<p>改为</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>getCsrfToken:function(){\nvar a=CKEDITOR.tools.getCookie(\"csrftoken\"); if(!a||32!=a.length){\nvar a=[],b=\"\"; \nif(window.crypto&amp;&amp;window.crypto.getRandomValues)\na=new Uint8Array(32),</code></pre>\n\n<p>&nbsp;</p>\n\n<p>&ldquo;csrftoken&rdquo;为cookie中需要认证的csrftoken名称，32为csrftoken的长度，根据实际情况进行修改；</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>a=new CKEDITOR.dom.element(\"input\"), a.setAttributes({name:\"ckCsrfToken\",type:\"hidden\"}),</code></pre>\n\n<p>&nbsp;</p>\n\n<p>改为</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>a=new CKEDITOR.dom.element(\"input\"), a.setAttributes({name:\"csrfmiddlewaretoken\",type:\"hidden\"}),</code></pre>\n\n<p>&nbsp;</p>\n\n<p>该方法在firefox中成功执行，同时也兼容其它浏览器。</p>\n',142,'http://blog.xiaosankexing.com/FrCOTng3iQEgcccbXzO6GBMa3u44',4,0,0),('2018-09-30 02:13:13','2018-10-10 01:59:17',7,'关于CKEditor代码高亮设置--懒人版','棋子。','最近在做自己的个人博客站点，关于博客的在线编辑器最终选择了CKEditor，在公司用过，刚好可以利用这个机会再深入了解下。     由于博客的定位是技术博客，所以贴代码是必不可少的，而CKEditor默认是没有这个功能的。因此找了相关资料，发现其实CKEditor有这样的插件，而且配置起来非常简单，我就简单分享下，并作为记录。','<p>最近在做自己的个人博客站点，关于博客的在线编辑器最终选择了CKEditor，在公司用过，刚好可以利用这个机会再深入了解下。</p>\n\n<p>&nbsp; &nbsp; 由于博客的定位是技术博客，所以贴代码是必不可少的，而CKEditor默认是没有这个功能的。因此找了相关资料，发现其实CKEditor有这样的插件，而且配置起来非常简单，我就简单分享下，并作为记录。</p>\n\n<p>---------------------------------------------------------------------------------</p>\n\n<p>&nbsp; &nbsp; CKEditor关于代码高亮的插件叫做Code Snippet（下载地址<a href=\"http://ckeditor.com/addon/codesnippet\" rel=\"nofollow\" target=\"_blank\">http://ckeditor.com/addon/codesnippet</a>）</p>\n\n<p>&nbsp; &nbsp; 网上有不少关于这个插件配置的介绍，但作为懒人，更喜欢快速的获取现成工具，而CKEditor也满足了 需求。</p>\n\n<p>首先，登录到下载地址，可以看到有两个按钮，分别是【Add to my editor】和【Download】，肯定不少人第一反应是【Download】，但别着急，直接下载的话还需要自己配置，多麻烦啊。所以我们选择【Add to my editor】，字面上的意思就是添加我的编辑器。</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174229_w3cb_2653731.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p>点击完会发现按钮变了，变成【remove】了，但没出现任何东西，别急，看看右边是不是有个【Build my editor】按钮，猛击它，大力出奇迹。</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174418_xTi2_2653731.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p>马上就跳转界面了，这就是传说中的配置界面，这里1，2，3项都可根据个人需求去配置插件等设置，配置完最下面的【Download】就是我们要的了，接下来就跟使用普通的CKEditor一样配置了，把它放到你得项目文件里。</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174646_Pf3n_2653731.png\" /></p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174656_iapK_2653731.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p>放好了就运行看看，是不是就有了？</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174747_d4al_2653731.png\" /></p>\n\n<p><img alt=\"\" src=\"https://static.oschina.net/uploads/space/2016/1011/174759_dncE_2653731.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p>是不是很简单？</p>\n\n<p>&nbsp;</p>\n',124,'http://blog.xiaosankexing.com/FrCOTng3iQEgcccbXzO6GBMa3u44',4,0,2),('2018-10-01 17:28:21','2018-10-01 17:28:21',8,'js replace全部替换的方法','棋子。','在写前端代码的时候，我们有时希望替换掉一个字符串中的一部分，理所当然的想到了replace这个方法。','<p>在写前端代码的时候，我们有时希望替换掉一个字符串中的一部分，理所当然的想到了replace这个方法。</p>\n\n<p>&nbsp;</p>\n\n<p>但是在实践中发现javascript中的replace方法只替换字符串中第一次出现的目标，比如：</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-javascript\">var str=\'我是生长在中国南方的纯正中国人\';\nvar newstr=str.replace(\'中国\',\'天朝\');\nalert(newstr);</code></pre>\n\n<p><img alt=\"\" src=\"https://images0.cnblogs.com/blog/636960/201501/281019232222727.png\" /></p>\n\n<p>结果是：我是生长在<strong>天朝</strong>南方的纯正<strong>中国</strong>人，而不是：我是生长在<strong>天朝</strong>南方的纯正<strong>天朝</strong>人。</p>\n\n<p>&nbsp;</p>\n\n<p>第一个目标&ldquo;中国&rdquo;被替换了，但是第二个没有被替换掉。怎么办呢？</p>\n\n<p>&nbsp;</p>\n\n<p>我们的解决方案就是用正则表达式，如下：</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-javascript\">var str = \'我是生长在中国南方的纯正中国人\';\nvar reg = new RegExp( \'中国\' , \"g\" )\nvar newstr = str.replace( reg , \'天朝\' );\nalert(newstr);\n</code></pre>\n\n<p>&nbsp;</p>\n\n<p>结果就成了我们想要的：我是生长在<strong>天朝</strong>南方的纯正<strong>天朝</strong>人。</p>\n\n<p>&nbsp;</p>\n\n<p>目的是达到了，但是每次都这样写的话似乎有点麻烦，我们把他封装一下。</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-javascript\">String.prototype.myReplace=function(f,e){//吧f替换成e\n    var reg=new RegExp(f,\"g\"); //创建正则RegExp对象   \n    return this.replace(reg,e); \n}\n\n//应用示例\nvar str=\'我是生长在中国南方的纯正中国人\';\nvar newstr=str.myReplace(\'中国\',\'天朝\');\nalert(newstr);</code></pre>\n\n<p>&nbsp;</p>\n\n<p>到此我们对javascript替换不完全的问题就完美解决了！</p>\n',109,'http://blog.xiaosankexing.com/FojBI5JJ8S6Qqv_9U9iz_ze4oEiW',4,0,0),('2018-10-01 17:30:46','2018-10-02 00:20:13',9,'JS 对象(Object)和字符串(String)互转方法','棋子。','JS 对象(Object)和字符串(String)互转方法','<p><strong>JS 对象(Object)和字符串(String)互转方法</strong></p>\n\n<p>&nbsp;</p>\n\n<p>利用原生JSON对象，将对象转为字符串</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>    // 字符串转化为 对象\n    var jsonString = \'[{\"name\":\"天鸽\"},{\"name\":\"梅花\"},{\"name\":\"台风\"}]\';\n\n    // console.log(JSON.parse(jsonString));\n    var jsArr = JSON.parse(jsonString);\n\n    jsArr.push({\"name\":\"帕卡\"});\n\n    console.log(jsArr);\n</code></pre>\n\n<p>&nbsp;</p>\n\n<p>从JSON字符串转为对象</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>    // 把js对象 数组 转化为 JSON格式的字符串\n    var result = JSON.stringify(jsArr);\n\n    console.log(result);</code></pre>\n\n<p>&nbsp;</p>\n',113,'http://blog.xiaosankexing.com/FojBI5JJ8S6Qqv_9U9iz_ze4oEiW',4,0,0),('2018-10-02 00:23:28','2018-10-10 01:59:25',10,'前端页面代码高亮显示','棋子。','前面讲了怎么在后台编辑器中使用CKEditor代码高亮显示(代码并色)插件Code Snippet的安装及使用方法。','<p>前面讲了怎么在后台编辑器中使用CKEditor代码高亮显示(代码并色)插件Code Snippet的安装及使用方法。</p>\n\n<p>&nbsp;</p>\n\n<h2>那么如何让代码片段在普通页面上显示高亮？</h2>\n\n<p>我们会发现，虽然在编辑器中添加的代码片段有高亮效果，但是将编辑器里的代码片段放到页面中却没有高亮的效果。这是因为编辑器的插件已经默认集成了highlight.js这个代码高亮库，所以我们要在页面上显示高亮就得重新引用和添加highlight.js库。</p>\n\n<p>我们先看下编辑器中的高亮代码：</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-html\">&lt;pre&gt;\n&lt;code class=\"language-html\"&gt;&amp;lt;!DOCTYPE html&amp;gt;\n \n&amp;lt;html lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\"&amp;gt;\n&amp;lt;head&amp;gt;\n    &amp;lt;meta charset=\"utf-8\" /&amp;gt;\n    &amp;lt;title&amp;gt;测试页面&amp;lt;/title&amp;gt;\n&amp;lt;/head&amp;gt;\n&amp;lt;body&amp;gt;\n&amp;lt;div&amp;gt;代码片段高亮效果&amp;lt;/div&amp;gt;\n&amp;lt;/body&amp;gt;\n&amp;lt;/html&amp;gt;&lt;/code&gt;&lt;/pre&gt;\n</code></pre>\n\n<pre>\n\n可以看到&nbsp;高亮的效果主要是根据&lt;pre&gt;标签和 &lt;code class=&quot;language-html&quot;&gt;这两个标签来显示的，其中language-html表示的显示高亮语言为HTML。 highlight.js就是根据这两个标签来显示高亮效果。</pre>\n\n<p>我们首先要将highlight.js下载下来（<a href=\"http://highlightjs.org/download/\" rel=\"nofollow\" target=\"_blank\">下载地址</a>，可以选择要高亮的编程语言种类），然后在需要代码高亮的页面添加下面的代码：</p>\n\n<pre>\n\n\n&nbsp;</pre>\n\n<pre>\n<code class=\"language-html\">&lt;!--开头这里的样式为默认的风格，可以根据自己的喜好更换风格--&gt;\n&lt;!--我的高亮效果是Androidstudio--&gt;\n&lt;link rel=\"stylesheet\" href=\"styles/default.css\"&gt;\n&lt;script src=\"highlight.pack.js\"&gt;&lt;/script&gt;\n&lt;script&gt;hljs.initHighlightingOnLoad();&lt;/script&gt;\n</code></pre>\n\n<pre>\n\n\n\n要注意更改css样式和JS的引用地址，地址以自己网站中highlight.js的存放地址为准。另外高亮库默认使用的是default.css的高亮风格，这里是highlightjs的各种代码高亮风格的显示效果，大家可以到上面测试选择自己喜欢的高亮风格：<a href=\"http://highlightjs.org/static/test.html\" rel=\"nofollow\" style=\"font-family: sans-serif, Arial, Verdana, &quot;Trebuchet MS&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;\" target=\"_blank\">http://highlightjs.org/static/test.html</a><span style=\"font-family:sans-serif,Arial,Verdana,&quot;Trebuchet MS&quot;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;\">。highlightjs的具体使用方法可以看官网的文档：</span><a href=\"http://highlightjs.org/usage/\" rel=\"nofollow\" style=\"font-family: sans-serif, Arial, Verdana, &quot;Trebuchet MS&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;;\" target=\"_blank\">http://highlightjs.org/usage/</a><span style=\"font-family:sans-serif,Arial,Verdana,&quot;Trebuchet MS&quot;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;\">。</span></pre>\n\n<p>到这里就可以完整的将代码片段进行高亮显示了。</p>\n\n<p>关于效果，大家可以看一下本文的效果。</p>\n',135,'http://blog.xiaosankexing.com/FojBI5JJ8S6Qqv_9U9iz_ze4oEiW',4,0,0),('2018-10-02 15:54:27','2018-10-03 16:16:41',11,'博客图片点击放大，再点恢复原状','棋子。','js代码控制图片点击放大，再次点击恢复原状','<h2><strong>1. js代码部分放于页脚HTML代码</strong></h2>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-javascript\">&lt;script type=\"text/javascript\"&gt; \n    //图片放大  \n    $(\"#outerdiv\").hide();\n    $(function(){  \n    $(\"img\").mouseover(function(){\n        $(this).css(\"cursor\",\"pointer\");\n    });\n\n    $(\"img\").click(function(){  \n        var _this = $(this);//将当前的pimg元素作为_this传入函数    \n        imgShow(\"#outerdiv\", \"#bigimg\", _this);    \n      });     \n    });    \n\n    function imgShow(outerdiv, bigimg, _this){  \n        var src = _this.attr(\"src\");//获取当前点击的pimg元素中的src属性    \n        $(\'#outerdiv\').attr(\'display\',\'block\');  \n        $(bigimg).attr(\"src\", src);//设置#bigimg元素的src属性    \n         $(outerdiv).fadeIn(\"fast\");  \n        \n    $(outerdiv).click(function(){//再次点击淡出消失弹出层    \n        $(this).fadeOut(\"fast\");    \n    });    \n&lt;/script&gt;  </code></pre>\n\n<p>&nbsp;</p>\n\n<h2><strong>2. html代码部分也放于页脚HTML代码</strong></h2>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-html\">&lt;div id=\"outerdiv\" style=\"text-align: center;position: fixed;z-index: 1000;top: 0;left: 0;\n    width: 100%;height: 100%;background-color: rgba(255,255,255,.9);\"&gt;\n    &lt;img id=\"bigimg\" style=\"height: auto;width: 46.6325%;border: 0; \n        margin: auto;position: absolute;top: 0;bottom: 0;left: 0;right: 0;\" src=\"\" /&gt;\n&lt;/div&gt; </code></pre>\n\n<p>&nbsp;</p>\n',4,'http://blog.xiaosankexing.com/FojBI5JJ8S6Qqv_9U9iz_ze4oEiW',4,0,0),('2018-10-03 18:40:48','2018-10-09 21:45:54',12,'当MySQL遇到emoji表情🤣','棋子。','在数据库中插入emoji表情时报错，mysql的UTF-8只支持三个字节的存储，而一般字符是三个字节，但是emoji表情是4个字节，所以存储不了。','<p>&nbsp;</p>\n\n<p>&nbsp;</p>\n\n<p>在数据库中插入emoji表情时报错，mysql的UTF-8只支持三个字节的存储，而一般字符是三个字节，但是emoji表情是4个字节，所以存储不了。</p>\n\n<p>&nbsp;</p>\n\n<p>而mysql为了解决这个问题，在5.5.3版本之后转而支持了存储4个字节的utf8字符，字符集为utf8mb4.这个相当于windowsX64和windowsX86的区别，64位是兼容32位的，也就是说utf8mb4存取utf8都是没有问题的。</p>\n\n<p>&nbsp;</p>\n\n<p>那么在有表情的字段上就应该这样做,将该字段设置为utf8mb4</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code> ALTER TABLE table_name MODIFY  colum_name  VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci</code></pre>\n\n<p>&nbsp;</p>\n\n<p>然而你还需要设置下表的字符集</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code> ALTER TABLE table_name CHARSET=utf8mb4;</code></pre>\n\n<p>&nbsp;</p>\n\n<p>当然你可能还需要设置本数据库为utf8mb4啊</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code> SET NAMES utf8mb4</code></pre>\n\n<p>&nbsp;</p>\n\n<p>然后重启mysql。</p>\n\n<p>&nbsp;</p>\n\n<p>查看数据库编码类型</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-sql\">show variables like \'character%\'; </code></pre>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-sql\">mysql&gt; show variables like \'character%\';\n+--------------------------+-----------------------------------------------------------+\n| Variable_name            | Value                                                     |\n+--------------------------+-----------------------------------------------------------+\n| character_set_client     | utf8mb4                                                   |\n| character_set_connection | utf8mb4                                                   |\n| character_set_database   | utf8mb4                                                   |\n| character_set_filesystem | binary                                                    |\n| character_set_results    | utf8mb4                                                   |\n| character_set_server     | utf8mb4                                                   |\n| character_set_system     | utf8                                                      |\n| character_sets_dir       | /usr/local/mysql-5.7.18-macos10.12-x86_64/share/charsets/ |\n+--------------------------+-----------------------------------------------------------+\n8 rows in set (0.00 sec)</code></pre>\n\n<p>&nbsp;</p>\n\n<p>然后就是在连接数据库的代码处设置</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-sql\">SQLALCHEMY_DATABASE_URI = \"mysql://root:passwd@127.0.0.1:3306/databasename?charset=utf8mb4\"</code></pre>\n\n<p>&nbsp;</p>\n\n<p>另外不要忘了模型类</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code class=\"language-sql\">设置数据库表编码方式为utf8mb4\nclass User(Base):    \n    __tablename__ = \'tb_user’		\n    id = Column(Integer,primary_key = True,autoincrement=True)    \n    name = Column(String(250),nullable=False,unique = True,comment=u\"姓名\")    \n    __table_args__ = {        \n        \"mysql_charset\" : \"utf8mb4\"\n    }</code></pre>\n\n<p>&nbsp;</p>\n\n<p>那么，这样就可以在提交数据的时候插入emoji表情了，并且取出的也不会报错，就好像这样🐑👀👿</p>\n',3,'http://blog.xiaosankexing.com/FiEL1PcKh8m913z0rpAJkDowWcjs',4,0,0),('2018-10-03 19:12:26','2018-10-03 21:58:50',13,'评论留言XSS防御','棋子。','昨晚准备睡觉的时候突然想起，我好像没有过滤留言和评论，那岂不是能够xss','<p>昨晚准备睡觉的时候突然想起，我好像没有过滤留言和评论，那岂不是能够xss</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"/static/upload/201810031855122343.png\" /></p>\n\n<p>&nbsp;</p>\n\n<p>打开电脑一测试，果然，存储型xss</p>\n\n<p>&nbsp;</p>\n\n<p>数据入库的时候和取出展示的时候没有进行过滤</p>\n\n<p>&nbsp;</p>\n\n<p>三种方法，一是在前端提交时过滤，一是在后端存入数据库的过滤</p>\n\n<p>&nbsp;</p>\n\n<p>还有就是在提交给前端展示时过滤，然而我把三种都加上了👿</p>\n\n<p>&nbsp;</p>\n\n<p>直接在三处加上过滤&lt;&gt;尖括号的代码，简单粗暴</p>\n',6,'http://blog.xiaosankexing.com/FhYkQ41ywqoap1fiO-USDwi8GK8x',4,0,0),('2018-10-03 23:14:58','2018-10-03 23:29:01',14,'使用 Python 和 Flask 设计 RESTful API','棋子。','近些年来 REST (REpresentational State Transfer) 已经变成了 web services 和 web APIs 的标配。  在本文中我将向你展示如何简单地使用 Python 和 Flask 框架来创建一个 RESTful 的 web service。','<p>近些年来 REST (REpresentational State Transfer) 已经变成了 web services 和 web APIs 的标配。</p>\n\n<p>在本文中我将向你展示如何简单地使用 Python 和 Flask 框架来创建一个 RESTful 的 web service。</p>\n\n<h2>什么是 REST？</h2>\n\n<p>六条设计规范定义了一个 REST 系统的特点:</p>\n\n<ul>\n	<li><strong>客户端-服务器</strong>: 客户端和服务器之间隔离，服务器提供服务，客户端进行消费。</li>\n	<li><strong>无状态</strong>: 从客户端到服务器的每个请求都必须包含理解请求所必需的信息。换句话说， 服务器不会存储客户端上一次请求的信息用来给下一次使用。</li>\n	<li><strong>可缓存</strong>: 服务器必须明示客户端请求能否缓存。</li>\n	<li><strong>分层系统</strong>: 客户端和服务器之间的通信应该以一种标准的方式，就是中间层代替服务器做出响应的时候，客户端不需要做任何变动。</li>\n	<li><strong>统一的接口</strong>: 服务器和客户端的通信方法必须是统一的。</li>\n	<li><strong>按需编码</strong>: 服务器可以提供可执行代码或脚本，为客户端在它们的环境中执行。这个约束是唯一一个是可选的。</li>\n</ul>\n\n<h2>什么是一个 RESTful 的 web service？</h2>\n\n<p>REST 架构的最初目的是适应万维网的 HTTP 协议。</p>\n\n<p>RESTful web services 概念的核心就是&ldquo;资源&rdquo;。 资源可以用&nbsp;<a href=\"https://en.wikipedia.org/wiki/Uniform_resource_identifier\">URI</a>&nbsp;来表示。客户端使用 HTTP 协议定义的方法来发送请求到这些 URIs，当然可能会导致这些被访问的&rdquo;资源&ldquo;状态的改变。</p>\n\n<p>HTTP 标准的方法有如下:</p>\n\n<pre>\n<code>==========  =====================  ==================================\nHTTP 方法   行为                   示例\n==========  =====================  ==================================\nGET         获取资源的信息         http://example.com/api/orders\nGET         获取某个特定资源的信息 http://example.com/api/orders/123\nPOST        创建新资源             http://example.com/api/orders\nPUT         更新资源               http://example.com/api/orders/123\nDELETE      删除资源               http://example.com/api/orders/123\n==========  ====================== ==================================</code></pre>\n\n<p>REST 设计不需要特定的数据格式。在请求中数据可以以&nbsp;<a href=\"http://en.wikipedia.org/wiki/JSON\">JSON</a>&nbsp;形式, 或者有时候作为 url 中查询参数项。</p>\n\n<h2>设计一个简单的 web service</h2>\n\n<p>坚持 REST 的准则设计一个 web service 或者 API 的任务就变成一个标识资源被展示出来以及它们是怎样受不同的请求方法影响的练习。</p>\n\n<p>比如说，我们要编写一个待办事项应用程序而且我们想要为它设计一个 web service。要做的第一件事情就是决定用什么样的根 URL 来访问该服务。例如，我们可以通过这个来访问:</p>\n\n<p><a href=\"http://[hostname]/todo/api/v1.0/\">http://[hostname]/todo/api/v1.0/</a></p>\n\n<p>在这里我已经决定在 URL 中包含应用的名称以及 API 的版本号。在 URL 中包含应用名称有助于提供一个命名空间以便区分同一系统上的其它服务。在 URL 中包含版本号能够帮助以后的更新，如果新版本中存在新的和潜在不兼容的功能，可以不影响依赖于较旧的功能的应用程序。</p>\n\n<p>下一步骤就是选择将由该服务暴露(展示)的资源。这是一个十分简单地应用，我们只有任务，因此在我们待办事项中唯一的资源就是任务。</p>\n\n<p>我们的任务资源将要使用 HTTP 方法如下:</p>\n\n<pre>\n<code>==========  ===============================================  =============================\nHTTP 方法   URL                                              动作\n==========  ===============================================  ==============================\nGET         http://[hostname]/todo/api/v1.0/tasks            检索任务列表\nGET         http://[hostname]/todo/api/v1.0/tasks/[task_id]  检索某个任务\nPOST        http://[hostname]/todo/api/v1.0/tasks            创建新任务\nPUT         http://[hostname]/todo/api/v1.0/tasks/[task_id]  更新任务\nDELETE      http://[hostname]/todo/api/v1.0/tasks/[task_id]  删除任务\n==========  ================================================ =============================</code></pre>\n\n<p>我们定义的任务有如下一些属性:</p>\n\n<ul>\n	<li><strong>id</strong>: 任务的唯一标识符。数字类型。</li>\n	<li><strong>title</strong>: 简短的任务描述。字符串类型。</li>\n	<li><strong>description</strong>: 具体的任务描述。文本类型。</li>\n	<li><strong>done</strong>: 任务完成的状态。布尔值。</li>\n</ul>\n\n<p>目前为止关于我们的 web service 的设计基本完成。剩下的事情就是实现它！</p>\n\n<h2>Flask 框架的简介</h2>\n\n<p>如果你读过&nbsp;<a href=\"http://www.pythondoc.com/flask-mega-tutorial/index.html\">Flask Mega-Tutorial 系列</a>，就会知道 Flask 是一个简单却十分强大的 Python web 框架。</p>\n\n<p>在我们深入研究 web services 的细节之前，让我们回顾一下一个普通的 Flask Web 应用程序的结构。</p>\n\n<p>我会首先假设你知道 Python 在你的平台上工作的基本知识。 我将讲解的例子是工作在一个类 Unix 操作系统。简而言之，这意味着它们能工作在 Linux，Mac OS X 和 Windows(如果你使用Cygwin)。 如果你使用 Windows 上原生的 Python 版本的话，命令会有所不同。</p>\n\n<p>让我们开始在一个虚拟环境上安装 Flask。如果你的系统上没有 virtualenv，你可以从&nbsp;<a href=\"https://pypi.python.org/pypi/virtualenv\">https://pypi.python.org/pypi/virtualenv</a>&nbsp;上下载:</p>\n\n<pre>\n<code>$ mkdir todo-api\n$ cd todo-api\n$ virtualenv flask\nNew python executable in flask/bin/python\nInstalling setuptools............................done.\nInstalling pip...................done.\n$ flask/bin/pip install flask</code></pre>\n\n<p>既然已经安装了 Flask，现在开始创建一个简单地网页应用，我们把它放在一个叫 app.py 的文件中:</p>\n\n<pre>\n<code>#!flask/bin/python\nfrom flask import Flask\n\napp = Flask(__name__)\n\n@app.route(\'/\')\ndef index():\n    return \"Hello, World!\"\n\nif __name__ == \'__main__\':\n    app.run(debug=True)</code></pre>\n\n<p>为了运行这个程序我们必须执行 app.py:</p>\n\n<pre>\n<code>$ chmod a+x app.py\n$ ./app.py\n * Running on http://127.0.0.1:5000/\n * Restarting with reloader</code></pre>\n\n<p>现在你可以启动你的网页浏览器，输入&nbsp;<a href=\"http://localhost:5000/\">http://localhost:5000</a>&nbsp;看看这个小应用程序的效果。</p>\n\n<p>简单吧？现在我们将这个应用程序转换成我们的 RESTful service！</p>\n\n<h2>使用 Python 和 Flask 实现 RESTful services</h2>\n\n<p>使用 Flask 构建 web services 是十分简单地，比我在&nbsp;<a href=\"http://www.pythondoc.com/flask-mega-tutorial/index.html\">Mega-Tutorial</a>&nbsp;中构建的完整的服务端的应用程序要简单地多。</p>\n\n<p>在 Flask 中有许多扩展来帮助我们构建 RESTful services，但是在我看来这个任务十分简单，没有必要使用 Flask 扩展。</p>\n\n<p>我们 web service 的客户端需要添加、删除以及修改任务的服务，因此显然我们需要一种方式来存储任务。最直接的方式就是建立一个小型的数据库，但是数据库并不是本文的主体。学习在 Flask 中使用合适的数据库，我强烈建议阅读&nbsp;<a href=\"http://www.pythondoc.com/flask-mega-tutorial/index.html\">Mega-Tutorial</a>。</p>\n\n<p>这里我们直接把任务列表存储在内存中，因此这些任务列表只会在 web 服务器运行中工作，在结束的时候就失效。 这种方式只是适用我们自己开发的 web 服务器，不适用于生产环境的 web 服务器， 这种情况一个合适的数据库的搭建是必须的。</p>\n\n<p>我们现在来实现 web service 的第一个入口:</p>\n\n<pre>\n<code>#!flask/bin/python\nfrom flask import Flask, jsonify\n\napp = Flask(__name__)\n\ntasks = [\n    {\n        \'id\': 1,\n        \'title\': u\'Buy groceries\',\n        \'description\': u\'Milk, Cheese, Pizza, Fruit, Tylenol\',\n        \'done\': False\n    },\n    {\n        \'id\': 2,\n        \'title\': u\'Learn Python\',\n        \'description\': u\'Need to find a good Python tutorial on the web\',\n        \'done\': False\n    }\n]\n\n@app.route(\'/todo/api/v1.0/tasks\', methods=[\'GET\'])\ndef get_tasks():\n    return jsonify({\'tasks\': tasks})\n\nif __name__ == \'__main__\':\n    app.run(debug=True)</code></pre>\n\n<p>正如你所见，没有多大的变化。我们创建一个任务的内存数据库，这里无非就是一个字典和数组。数组中的每一个元素都具有上述定义的任务的属性。</p>\n\n<p>取代了首页，我们现在拥有一个 get_tasks 的函数，访问的 URI 为 /todo/api/v1.0/tasks，并且只允许 GET 的 HTTP 方法。</p>\n\n<p>这个函数的响应不是文本，我们使用 JSON 数据格式来响应，Flask 的 jsonify 函数从我们的数据结构中生成。</p>\n\n<p>使用网页浏览器来测试我们的 web service 不是一个最好的注意，因为网页浏览器上不能轻易地模拟所有的 HTTP 请求的方法。相反，我们会使用 curl。如果你还没有安装 curl 的话，请立即安装它。</p>\n\n<p>通过执行 app.py，启动 web service。接着打开一个新的控制台窗口，运行以下命令:</p>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 294\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 04:53:53 GMT\n\n{\n  \"tasks\": [\n    {\n      \"description\": \"Milk, Cheese, Pizza, Fruit, Tylenol\",\n      \"done\": false,\n      \"id\": 1,\n      \"title\": \"Buy groceries\"\n    },\n    {\n      \"description\": \"Need to find a good Python tutorial on the web\",\n      \"done\": false,\n      \"id\": 2,\n      \"title\": \"Learn Python\"\n    }\n  ]\n}\n</code></pre>\n\n<pre>\n我们已经成功地调用我们的 RESTful service 的一个函数！</pre>\n\n<p>现在我们开始编写 GET 方法请求我们的任务资源的第二个版本。这是一个用来返回单独一个任务的函数:</p>\n\n<pre>\n<code>from flask import abort\n\n@app.route(\'/todo/api/v1.0/tasks/&lt;int:task_id&gt;\', methods=[\'GET\'])\ndef get_task(task_id):\n    task = filter(lambda t: t[\'id\'] == task_id, tasks)\n    if len(task) == 0:\n        abort(404)\n    return jsonify({\'task\': task[0]})</code></pre>\n\n<p>第二个函数有些意思。这里我们得到了 URL 中任务的 id，接着 Flask 把它转换成 函数中的 task_id 的参数。</p>\n\n<p>我们用这个参数来搜索我们的任务数组。如果我们的数据库中不存在搜索的 id，我们将会返回一个类似 404 的错误，根据 HTTP 规范的意思是 &ldquo;资源未找到&rdquo;。</p>\n\n<p>如果我们找到相应的任务，那么我们只需将它用 jsonify 打包成 JSON 格式并将其发送作为响应，就像我们以前那样处理整个任务集合。</p>\n\n<p>调用 curl 请求的结果如下:</p>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks/2\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 151\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 05:21:50 GMT\n\n{\n  \"task\": {\n    \"description\": \"Need to find a good Python tutorial on the web\",\n    \"done\": false,\n    \"id\": 2,\n    \"title\": \"Learn Python\"\n  }\n}\n$ curl -i http://localhost:5000/todo/api/v1.0/tasks/3\nHTTP/1.0 404 NOT FOUND\nContent-Type: text/html\nContent-Length: 238\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 05:21:52 GMT\n\n&lt;!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\"&gt;\n&lt;title&gt;404 Not Found&lt;/title&gt;\n&lt;h1&gt;Not Found&lt;/h1&gt;\n&lt;p&gt;The requested URL was not found on the server.&lt;/p&gt;&lt;p&gt;If you     entered the URL manually please check your spelling and try again.&lt;/p&gt;</code></pre>\n\n<p>当我们请求 id #2 的资源时候，我们获取到了，但是当我们请求 #3 的时候返回了 404 错误。有关错误奇怪的是返回的是 HTML 信息而不是 JSON，这是因为 Flask 按照默认方式生成 404 响应。由于这是一个 Web service 客户端希望我们总是以 JSON 格式回应，所以我们需要改善我们的 404 错误处理程序:</p>\n\n<pre>\n<code>from flask import make_response\n\n@app.errorhandler(404)\ndef not_found(error):\n    return make_response(jsonify({\'error\': \'Not found\'}), 404)\n</code></pre>\n\n<pre>\n我们会得到一个友好的错误提示:</pre>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks/3\nHTTP/1.0 404 NOT FOUND\nContent-Type: application/json\nContent-Length: 26\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 05:36:54 GMT\n\n{\n  \"error\": \"Not found\"\n}</code></pre>\n\n<p>接下来就是 POST 方法，我们用来在我们的任务数据库中插入一个新的任务:</p>\n\n<pre>\n<code>from flask import request\n\n@app.route(\'/todo/api/v1.0/tasks\', methods=[\'POST\'])\ndef create_task():\n    if not request.json or not \'title\' in request.json:\n        abort(400)\n    task = {\n        \'id\': tasks[-1][\'id\'] + 1,\n        \'title\': request.json[\'title\'],\n        \'description\': request.json.get(\'description\', \"\"),\n        \'done\': False\n    }\n    tasks.append(task)\n    return jsonify({\'task\': task}), 201</code></pre>\n\n<p>添加一个新的任务也是相当容易地。只有当请求以 JSON 格式形式，request.json 才会有请求的数据。如果没有数据，或者存在数据但是缺少 title 项，我们将会返回 400，这是表示请求无效。</p>\n\n<p>接着我们会创建一个新的任务字典，使用最后一个任务的 id + 1 作为该任务的 id。我们允许 description 字段缺失，并且假设 done 字段设置成 False。</p>\n\n<p>我们把新的任务添加到我们的任务数组中，并且把新添加的任务和状态 201 响应给客户端。</p>\n\n<p>使用如下的 curl 命令来测试这个新的函数:</p>\n\n<pre>\n<code>$ curl -i -H \"Content-Type: application/json\" -X POST -d \'{\"title\":\"Read a book\"}\' http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 201 Created\nContent-Type: application/json\nContent-Length: 104\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 05:56:21 GMT\n\n{\n  \"task\": {\n    \"description\": \"\",\n    \"done\": false,\n    \"id\": 3,\n    \"title\": \"Read a book\"\n  }\n}</code></pre>\n\n<p>注意：如果你在 Windows 上并且运行 Cygwin 版本的 curl，上面的命令不会有任何问题。然而，如果你使用原生的 curl，命令会有些不同:</p>\n\n<pre>\n<code>curl -i -H \"Content-Type: application/json\" -X POST -d \"{\"\"\"title\"\"\":\"\"\"Read a book\"\"\"}\" http://localhost:5000/todo/api/v1.0/tasks</code></pre>\n\n<p>当然在完成这个请求后，我们可以得到任务的更新列表:</p>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 423\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 05:57:44 GMT\n\n{\n  \"tasks\": [\n    {\n      \"description\": \"Milk, Cheese, Pizza, Fruit, Tylenol\",\n      \"done\": false,\n      \"id\": 1,\n      \"title\": \"Buy groceries\"\n    },\n    {\n      \"description\": \"Need to find a good Python tutorial on the web\",\n      \"done\": false,\n      \"id\": 2,\n      \"title\": \"Learn Python\"\n    },\n    {\n      \"description\": \"\",\n      \"done\": false,\n      \"id\": 3,\n      \"title\": \"Read a book\"\n    }\n  ]\n}</code></pre>\n\n<p>剩下的两个函数如下所示:</p>\n\n<pre>\n<code>@app.route(\'/todo/api/v1.0/tasks/&lt;int:task_id&gt;\', methods=[\'PUT\'])\ndef update_task(task_id):\n    task = filter(lambda t: t[\'id\'] == task_id, tasks)\n    if len(task) == 0:\n        abort(404)\n    if not request.json:\n        abort(400)\n    if \'title\' in request.json and type(request.json[\'title\']) != unicode:\n        abort(400)\n    if \'description\' in request.json and type(request.json[\'description\']) is not unicode:\n        abort(400)\n    if \'done\' in request.json and type(request.json[\'done\']) is not bool:\n        abort(400)\n    task[0][\'title\'] = request.json.get(\'title\', task[0][\'title\'])\n    task[0][\'description\'] = request.json.get(\'description\', task[0][\'description\'])\n    task[0][\'done\'] = request.json.get(\'done\', task[0][\'done\'])\n    return jsonify({\'task\': task[0]})\n\n@app.route(\'/todo/api/v1.0/tasks/&lt;int:task_id&gt;\', methods=[\'DELETE\'])\ndef delete_task(task_id):\n    task = filter(lambda t: t[\'id\'] == task_id, tasks)\n    if len(task) == 0:\n        abort(404)\n    tasks.remove(task[0])\n    return jsonify({\'result\': True})</code></pre>\n\n<p>delete_task 函数没有什么特别的。对于 update_task 函数，我们需要严格地检查输入的参数以防止可能的问题。我们需要确保在我们把它更新到数据库之前，任何客户端提供我们的是预期的格式。</p>\n\n<p>更新任务 #2 的函数调用如下所示:</p>\n\n<pre>\n<code>$ curl -i -H \"Content-Type: application/json\" -X PUT -d \'{\"done\":true}\' http://localhost:5000/todo/api/v1.0/tasks/2\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 170\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 07:10:16 GMT\n\n{\n  \"task\": [\n    {\n      \"description\": \"Need to find a good Python tutorial on the web\",\n      \"done\": true,\n      \"id\": 2,\n      \"title\": \"Learn Python\"\n    }\n  ]\n}</code></pre>\n\n<h2>优化 web service 接口</h2>\n\n<p>目前 API 的设计的问题就是迫使客户端在任务标识返回后去构造 URIs。这对于服务器是十分简单的，但是间接地迫使客户端知道这些 URIs 是如何构造的，这将会阻碍我们以后变更这些 URIs。</p>\n\n<p>不直接返回任务的 ids，我们直接返回控制这些任务的完整的 URI，以便客户端可以随时使用这些 URIs。为此，我们可以写一个小的辅助函数生成一个 &ldquo;公共&rdquo; 版本任务发送到客户端:</p>\n\n<pre>\n<code>from flask import url_for\n\ndef make_public_task(task):\n    new_task = {}\n    for field in task:\n        if field == \'id\':\n            new_task[\'uri\'] = url_for(\'get_task\', task_id=task[\'id\'], _external=True)\n        else:\n            new_task[field] = task[field]\n    return new_task</code></pre>\n\n<p>这里所有做的事情就是从我们数据库中取出任务并且创建一个新的任务，这个任务的 id 字段被替换成通过 Flask 的 url_for 生成的 uri 字段。</p>\n\n<p>当我们返回所有的任务列表的时候，在发送到客户端之前通过这个函数进行处理:</p>\n\n<pre>\n<code>@app.route(\'/todo/api/v1.0/tasks\', methods=[\'GET\'])\ndef get_tasks():\n    return jsonify({\'tasks\': map(make_public_task, tasks)})</code></pre>\n\n<p>这里就是客户端获取任务列表的时候得到的数据:</p>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 406\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 18:16:28 GMT\n\n{\n  \"tasks\": [\n    {\n      \"title\": \"Buy groceries\",\n      \"done\": false,\n      \"description\": \"Milk, Cheese, Pizza, Fruit, Tylenol\",\n      \"uri\": \"http://localhost:5000/todo/api/v1.0/tasks/1\"\n    },\n    {\n      \"title\": \"Learn Python\",\n      \"done\": false,\n      \"description\": \"Need to find a good Python tutorial on the web\",\n      \"uri\": \"http://localhost:5000/todo/api/v1.0/tasks/2\"\n    }\n  ]\n}\n</code></pre>\n\n<pre>\n我们将会把上述的方式应用到其它所有的函数上以确保客户端一直看到 URIs 而不是 ids。</pre>\n\n<h2>加强 RESTful web service 的安全性</h2>\n\n<p>我们已经完成了我们 web service 的大部分功能，但是仍然有一个问题。我们的 web service 对任何人都是公开的，这并不是一个好主意。</p>\n\n<p>我们有一个可以管理我们的待办事项完整的 web service，但在当前状态下的 web service 是开放给所有的客户端。 如果一个陌生人弄清我们的 API 是如何工作的，他或她可以编写一个客户端访问我们的 web service 并且毁坏我们的数据。</p>\n\n<p>大部分初级的教程会忽略这个问题并且到此为止。在我看来这是一个很严重的问题，我必须指出。</p>\n\n<p>确保我们的 web service 安全服务的最简单的方法是要求客户端提供一个用户名和密码。在常规的 web 应用程序会提供一个登录的表单用来认证，并且服务器会创建一个会话为登录的用户以后的操作使用，会话的 id 以 cookie 形式存储在客户端浏览器中。然而 REST 的规则之一就是 &ldquo;无状态&rdquo;， 因此我们必须要求客户端在每一次请求中提供认证的信息。</p>\n\n<p>我们一直试着尽可能地坚持 HTTP 标准协议。既然我们需要实现认证我们需要在 HTTP 上下文中去完成，HTTP 协议提供了两种认证机制:&nbsp;<a href=\"http://www.ietf.org/rfc/rfc2617.txt\">Basic 和 Digest</a>。</p>\n\n<p>有一个小的 Flask 扩展能够帮助我们，我们可以先安装 Flask-HTTPAuth:</p>\n\n<pre>\n<code>$ flask/bin/pip install flask-httpauth</code></pre>\n\n<p>比方说，我们希望我们的 web service 只让访问用户名 miguel 和密码 python 的客户端访问。 我们可以设置一个基本的 HTTP 验证如下:</p>\n\n<pre>\n<code>from flask.ext.httpauth import HTTPBasicAuth\nauth = HTTPBasicAuth()\n\n@auth.get_password\ndef get_password(username):\n    if username == \'miguel\':\n        return \'python\'\n    return None\n\n@auth.error_handler\ndef unauthorized():\n    return make_response(jsonify({\'error\': \'Unauthorized access\'}), 401)</code></pre>\n\n<p>get_password 函数是一个回调函数，Flask-HTTPAuth 使用它来获取给定用户的密码。在一个更复杂的系统中，这个函数是需要检查一个用户数据库，但是在我们的例子中只有单一的用户因此没有必要。</p>\n\n<p>error_handler 回调函数是用于给客户端发送未授权错误代码。像我们处理其它的错误代码，这里我们定制一个包含 JSON 数据格式而不是 HTML 的响应。</p>\n\n<p>随着认证系统的建立，所剩下的就是把需要认证的函数添加 @auth.login_required 装饰器。例如:</p>\n\n<pre>\n<code>@app.route(\'/todo/api/v1.0/tasks\', methods=[\'GET\'])\n@auth.login_required\ndef get_tasks():\n    return jsonify({\'tasks\': tasks})</code></pre>\n\n<p>如果现在要尝试使用 curl 调用这个函数我们会得到:</p>\n\n<pre>\n<code>$ curl -i http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 401 UNAUTHORIZED\nContent-Type: application/json\nContent-Length: 36\nWWW-Authenticate: Basic realm=\"Authentication Required\"\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 06:41:14 GMT\n\n{\n  \"error\": \"Unauthorized access\"\n}</code></pre>\n\n<p>为了能够调用这个函数我们必须发送我们的认证凭据:</p>\n\n<pre>\n<code>$ curl -u miguel:python -i http://localhost:5000/todo/api/v1.0/tasks\nHTTP/1.0 200 OK\nContent-Type: application/json\nContent-Length: 316\nServer: Werkzeug/0.8.3 Python/2.7.3\nDate: Mon, 20 May 2013 06:46:45 GMT\n\n{\n  \"tasks\": [\n    {\n      \"title\": \"Buy groceries\",\n      \"done\": false,\n      \"description\": \"Milk, Cheese, Pizza, Fruit, Tylenol\",\n      \"uri\": \"http://localhost:5000/todo/api/v1.0/tasks/1\"\n    },\n    {\n      \"title\": \"Learn Python\",\n      \"done\": false,\n      \"description\": \"Need to find a good Python tutorial on the web\",\n      \"uri\": \"http://localhost:5000/todo/api/v1.0/tasks/2\"\n    }\n  ]\n}</code></pre>\n\n<p>认证扩展给予我们很大的自由选择哪些函数需要保护，哪些函数需要公开。</p>\n\n<p>为了确保登录信息的安全应该使用 HTTP 安全服务器(例如:&nbsp;<a href=\"https:\">https://</a>...)，这样客户端和服务器之间的通信都是加密的，以防止传输过程中第三方看到认证的凭据。</p>\n\n<p>让人不舒服的是当请求收到一个 401 的错误，网页浏览都会跳出一个丑陋的登录框，即使请求是在后台发生的。因此如果我们要实现一个完美的 web 服务器的话，我们就需要禁止跳转到浏览器显示身份验证对话框，让我们的客户端应用程序自己处理登录。</p>\n\n<p>一个简单的方式就是不返回 401 错误。403 错误是一个令人青睐的替代，403 错误表示 &ldquo;禁止&rdquo; 的错误:</p>\n\n<pre>\n<code>@auth.error_handler\ndef unauthorized():\n    return make_response(jsonify({\'error\': \'Unauthorized access\'}), 403)</code></pre>\n\n<h2>可能的改进</h2>\n\n<p>我们编写的小型的 web service 还可以在不少的方面进行改进。</p>\n\n<p>对于初学者来说，一个真正的 web service 需要一个真实的数据库进行支撑。我们现在使用的内存数据结构会有很多限制不应该被用于真正的应用。</p>\n\n<p>另外一个可以提高的领域就是处理多用户。如果系统支持多用户的话，不同的客户端可以发送不同的认证凭证获取相应用户的任务列表。在这样一个系统中的话，我们需要第二个资源就是用户。在用户资源上的 POST 的请求代表注册换一个新用户。一个 GET 请求表示客户端获取一个用户的信息。一个 PUT 请求表示更新用户信息，比如可能是更新邮箱地址。一个 DELETE 请求表示删除用户账号。</p>\n\n<p>GET 检索任务列表请求可以在几个方面进行扩展。首先可以携带一个可选的页的参数，以便客户端请求任务的一部分。另外，这种扩展更加有用：允许按照一定的标准筛选。比如，用户只想要看到完成的任务，或者只想看到任务的标题以 A 字母开头。所有的这些都可以作为 URL 的一个参数项。</p>\n',12,'http://blog.xiaosankexing.com/FpqBoRmFB_JEEB1nMSaUas8K-v2b',4,0,0),('2018-10-03 21:54:04','2018-10-03 23:13:00',15,'关于flask request留言获取用户真实ip','棋子。','部署完程序到服务器后发现，每次留言获取到的用户ip都是127.0.0.1','<p>部署完程序到服务器后发现，每次留言获取到的用户ip都是127.0.0.1</p>\n\n<p>&nbsp;</p>\n\n<p>想了想，因为是用nginx做的端口转发，所以用户是访问到nginx的80端口</p>\n\n<p>&nbsp;</p>\n\n<p>然后由本地nginx转发到程序运行的5000端口</p>\n\n<p>&nbsp;</p>\n\n<p>这样一来request.remote_addr获取到肯定就是127.0.0.1了</p>\n\n<p>&nbsp;</p>\n\n<p>修改nginx配置</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>proxy_set_header Host $host:80; \nproxy_set_header X-Real-IP $remote_addr; \nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; </code></pre>\n\n<p>&nbsp;</p>\n\n<p>然后通过</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>ip=request.headers[\'X-Real-IP\'] \n</code></pre>\n\n<p>&nbsp;</p>\n\n<p>就可以获取真实 ip了</p>\n\n<p>&nbsp;</p>\n\n<p><img alt=\"\" src=\"/static/upload/201810032153433324.png\" /></p>\n',11,'http://blog.xiaosankexing.com/FpqBoRmFB_JEEB1nMSaUas8K-v2b',4,0,0),('2018-10-04 01:35:02','2018-10-04 02:29:55',16,'关于Flask-SQLAlchemy对关联数据表清除','棋子。','关于Flask-SQLAlchemy对关联数据表清除','<p>一对多关系，User为一，Task为多。</p>\n\n<p>&nbsp;</p>\n\n<p>一的一方通过relationship关联到多的一方，多的一方设置ForeignKey关联到一的一方。</p>\n\n<p>&nbsp;</p>\n\n<p>relationship中设置cascade=&#39;all, delete-orphan&#39; 与 passive_deletes = True，</p>\n\n<p>&nbsp;</p>\n\n<p>ForeignKey中设置ondelete = &#39;CASCADE&#39;。</p>\n\n<p>&nbsp;</p>\n\n<p>即可完成删除User的同时，删除与该user对象相关的task对象。</p>\n\n<p>&nbsp;</p>\n\n<p>例如：</p>\n\n<p>&nbsp;</p>\n\n<p>user的id为1，同时任务列表中，任务id为1和2的两个任务的user_id为1，即user中id为1的用户拥有任务id为1和2的两个任务。通过删除id为1的</p>\n\n<p>&nbsp;</p>\n\n<p>user，任务表中id为1和2的两个task对象也会同时删除。</p>\n\n<p>&nbsp;</p>\n\n<pre>\n<code>from . import db\n\nclass User(db.Model):\n    __tablesname__ = \'users\'\n    \n    id = db.Column(db.Integer, primary_key = True)\n    username = db.Column(db.String(64), unique = True)\n\n    tasks = db.relationship(\'Task\', backref=\'user\', lazy=\'dynamic\', cascade=\'all, delete-orphan\', passive_deletes = True)\n\n    def __repr__(self):\n        return \'&lt;User %r&gt;\' % self.username\n\nclass Task(db.Model):\n    __tablesname__ = \'tasks\'\n    \n    id = db.Column(db.Integer, primary_key = True)\n    taskname = db.Column(db.String(64), unique = True)\n    user_id = db.Column(db.Integer, db.ForeignKey(\'users.id\', ondelete=\'CASCADE\'))\n\n    def __repr__(self):\n        return \'&lt;Task %r&gt;\' % self.taskname</code></pre>\n\n<p>&nbsp;</p>\n\n<h1><strong>注意：</strong></h1>\n\n<ul>\n	<li>\n	<h2><strong>自关联级联删除直接在外键设置增加ondelete=&#39;CASCADE&#39;</strong></h2>\n	</li>\n	<li>\n	<h2><strong>如果字段设置了relationship则无法使用级联删除</strong></h2>\n\n	<pre>\n\n&nbsp;</pre>\n	</li>\n</ul>\n',0,'http://blog.xiaosankexing.com/FpqBoRmFB_JEEB1nMSaUas8K-v2b',2,0,0);
/*!40000 ALTER TABLE `info_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_news_action`
--

DROP TABLE IF EXISTS `info_news_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_news_action` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) DEFAULT NULL,
  `is_banner` tinyint(1) DEFAULT NULL,
  `is_top` tinyint(1) DEFAULT NULL,
  `is_tuijian` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  CONSTRAINT `info_news_action_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `info_news` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_news_action`
--

LOCK TABLES `info_news_action` WRITE;
/*!40000 ALTER TABLE `info_news_action` DISABLE KEYS */;
INSERT INTO `info_news_action` VALUES ('2018-10-03 19:58:58','2018-10-03 19:58:59',6,13,1,1,1),('2018-10-03 21:54:48','2018-10-03 21:54:49',7,15,1,1,1),('2018-10-04 01:36:11','2018-10-04 01:36:15',12,16,1,0,1),('2018-10-09 21:45:43','2018-10-09 21:45:44',13,12,1,0,1);
/*!40000 ALTER TABLE `info_news_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_user`
--

DROP TABLE IF EXISTS `info_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_user` (
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(32) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `avatar_url` varchar(256) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `signature` varchar(512) DEFAULT NULL,
  `gender` enum('MAN','WOMAN') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `nick_name` (`nick_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_user`
--

LOCK TABLES `info_user` WRITE;
/*!40000 ALTER TABLE `info_user` DISABLE KEYS */;
INSERT INTO `info_user` VALUES ('2018-09-25 10:59:23','2018-10-10 02:26:57',1,'admin','pbkdf2:sha256:50000$glpyrhca$4b8b8ec1b2175fe591958c51124e6c8ee77c982540bd3baf85a1e95d08fe8cac','18888888888','http://blog.xiaosankexing.com/FkYTTlB4LR8g0RT2tq_xcpk5aRIy','2018-09-25 10:59:23',1,'测试账号','MAN');
/*!40000 ALTER TABLE `info_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-10  2:28:06
