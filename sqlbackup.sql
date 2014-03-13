-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: BlogNagamemo
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,7,1,'嘿小吴！','2014-02-14 22:21:02','2014-02-14 22:21:02'),(2,9,1,'你说好门不行，你行你上啊！','2014-02-17 00:15:13','2014-02-17 00:15:13'),(3,9,1,'谁让你用IE啦！火狐的文本框是可以拖动的（','2014-02-17 00:17:00','2014-02-17 00:17:00');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_records`
--

DROP TABLE IF EXISTS `file_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_records`
--

LOCK TABLES `file_records` WRITE;
/*!40000 ALTER TABLE `file_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `viewed_times` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_posts_on_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'界面还是很丑的呀……嗯将就一下。\r\n总之这个博客终于是被我部署上来了，暂且算是beta版吧。\r\n博客的icon不知道放什么好，暂且随便抓一张メル的上去好了。到时候选定了再换。\r\n下一步是继续优化界面，以及给这个博客增加文件上传下载功能吧。不过带宽有限，下载速度可能比较差……\r\n再下一步也没啥打算，想加一个tag功能，类似菜单那样子，以及做一个有点趣味的小玩意，暂时想做一个抽卡小“游戏”，随便放在页面角落里拖动就抽出来卡片那种的，不过抽什么卡呢？还有图片怎么办呢，还没想好。\r\n对了，发帖的文本框是不是也要改一下，现在这个纯框框有点……太简朴了……？','2014-02-10 14:31:57','2014-02-10 14:31:57','博客上线，第一篇日志',0),(2,1,'我们现在这个项目之前是直接写crontab文件来执行定时任务的，在不同的服务器之间部署比较麻烦（由于许多原因，项目部署路径不一样，而且有些应用端口号也不一样，每次需要修改一些部署路径和配置文件），于是我就想至少把定时任务给用whenever做了吧，省得每次都cd到部署目录下，还要考虑到环境变量问题。\r\n然后我刚才写了这么一个任务：\r\n\r\nevery :day, at: \'3:00\' do\r\nrake \'sometask\'\r\nend\r\n\r\n由于定时任务有好多，而且终端不能滚屏（orz）所以也就随便扫了一眼，然后发现生成的cron是这样的\r\n0 15 * * * /bin/bash ........\r\n3:00被解析成了15点。\r\n推测是whenever或者是rails里涉及时间的某些机制导致的，于是由于现在是下午，就默认将3:00解析成下午三点了。\r\n不知道这个问题算不算bug，是不是其他gem中也会有类似问题。显式写成03:00就没有问题了。大家可以注意一下。\r\n\r\n更新： chronic的问题。whenever 用了 chronic 解析：','2014-02-10 18:47:34','2014-02-11 11:10:39','whenever 似乎存在默认上下午问题',0),(3,1,'早晨买早餐，平时吃的牛肉饼卖没了，我就买了个6块钱的鸡肉卷，结果很小且不好吃。中午因为某些原因没吃上饭。下午遇上乱七八糟的恶心问题，单双引号、斜杠转义，不同的脚本调用不同的脚本，传递不同的参数，来回调用+乱七八糟的替换，好容易给写好了，然后发现别人写的老代码有问题。跟原来写的人确认是写错了还是就那样，对方表示，哦应该是写错了。本来想早点走，然后又发现别的问题……恶心巴拉的解决了，一看九点。还没吃晚饭，然后骑车往地铁站走，结果在某个路口停着准备过马路，突然来一骑车小哥飞速撞在我身上，完了我还给人道歉……\r\n下了地铁寻思买俩巨无霸吧，结果麦当劳表示巨无霸卖没了，别的都有。卧槽，那个新汉堡其实不就是巨无霸威力加强版嘛……肉饼和面包都是一样的，比巨无霸多两根肠就卖八块钱，既然有那个新的，怎么可能没有巨无霸……\r\n那行，我不买巨无霸，我买那新汉堡，多花钱就多花了，没事儿\r\n买完了拿回来一看给错了，给了个麦辣鸡腿堡。','2014-02-13 00:09:54','2014-02-13 00:09:54','今天倒霉一整天',0),(4,1,'发现114DNS出了问题，似乎当且仅当查询域名为www.google.com且查询方式为tcp时很久都没反应。改为其他包含谷歌的域名或是使用udp查询www.google.com都没有这个问题，很奇怪……','2014-02-13 18:55:37','2014-02-13 18:55:37','2014-02-13随笔',0),(6,1,'找时间写一下关于ssh隧道翻墙和自建dns服务器的文章吧……虽然估计没人看...再就是随笔应该加上ctrl+enter直接发送的功能，目前还只能点鼠标有点郁闷。\r\n而且现在直接发随笔的话，页面的page变量是nil，再加1会导致视图抛错。回去改掉。\r\n另外simple_format最好也加上换行符之后自动缩进的功能比较好。','2014-02-14 14:48:52','2014-02-14 14:50:04','2014-02-14随笔',0),(7,2,'这道元','2014-02-14 21:34:06','2014-03-11 13:54:28','2014-02-14随笔',1),(8,1,'新浪微博提供的分享按钮有问题，如果本站启用了https，而引用微博js还是http的话就会有警告，而且这样的话就会完全无效；如果用https引用js也有问题：那个js所在的服务器的ssl证书有问题，域名是新浪的，但证书是*.weibo.com的。而且即使把那个js拿到本地加载，也会报错，提示url参数不正确。于是只好暂时先把博客改成http方式吧……','2014-02-15 17:44:16','2014-02-15 17:44:16','2014-02-15随笔',0),(9,4,'RT这个正文框实在太小了吧挤死人啦','2014-02-17 00:03:54','2014-03-11 11:33:10','好丑的界面阿',3),(10,1,'呃，于是这博客好久没动过了……找时间写个新的娱乐功能去……','2014-03-07 12:12:27','2014-03-07 12:12:27','2014-03-07随笔',0),(11,1,'感觉最近上谷歌各种恶心。dns污染不说，即使走正确的IP，从国内网络ping正确的IP丢包率也是低则40%，高则百分之八九十。这根本没法用吧。所以归根结底还是需要个代理。不过即使挂了代理，启用了远程dns解析，用谷歌加密搜索和普通的谷歌首页，都经常会很长很长时间无法载入。估计就是之前看到的，gfw会干扰有http特征的ssh协议吧。即使换了端口也没用。\r\n于是想起了之前看到的那个叫obfuscated ssh的玩意，这东西是在openssh基础上修改的，需要服务器端和客户端配合。\r\n这玩意需要编译安装。服务器端倒是可以独立于系统自带的sshd，单独开一个obfu_sshd进程，端口也应该隔离开，专门用来做端口转发。然后客户端也需要编译一份，然后加入一个盐（keyword）就行了。把连接ssh的脚本测试了一下，这东西也可以和sshpass结合在一起，所以以前的连接ssh命令也不用大改。这几天测试一下效果吧。\r\n\r\n参考文档：http://www.inkrope.com/archives/137','2014-03-08 00:58:00','2014-03-08 00:58:00','部署了一下obfuscated ssh',0),(12,1,'“精英病”这个词是我下午忽然想到的。起因是微博一个人说微博的点赞“只适合微信朋友圈一类的强关系网络，对微博、推特这类弱关系网络来说会分流用户的转发和评论行为，降低信息传播的效率，从而阻碍有效互动的产生”。我对此感到十分费解。\r\n对他的评论，我相信点赞行为分流用户的转发评论这是事实，但这一事实能否实际导致“阻碍有效互动”？所谓“降低信息传播效率”是否是不应该的？我看未必。对于点赞按钮来说，包括我在内的一部分用户认为它有趣，这就够了。不同的其他人喜欢或讨厌这个功能，各有各的理由。我要说的不在于这一件事儿本身。我十分反感一些人，无论评论什么，动辄以数字指标来说事儿，好像某个东西只要数字指标做到了就是好的，其他一切都无关紧要了一样。难道运营一个微博，只要是转发评论的数字上去了就是做好了吗？那么，当引入了点赞按钮之后，人们为什么会倾向于没有文字的点赞，而不是有文字的评论或者能给别人看的转发？理由很简单：不值当。说得难听点叫，犯不上。仅此而已。\r\n一般对于这种各有各的看法的事情，我不会将自己的观点强加于人。我在上面也说了，我这篇日志并不是在讨论他的观点对错。他的观点是他的事情，与我无关。我本身既不会去喷/骂观点，更不会去喷人。但是这背后有一种无论什么事情都要追求无谓的定量指标的心里。其实我想归根结底这和应试教育是一样的。不是说教育部、教育体系导致了应试教育，而是大多数人都会更多地关注定量指标，反而忽略了定量指标所无法体现的另一些重要的东西了。下午看到这个人的时候，我就想到了一个词：精英病。\r\n但晚上仔细想了想，其实这不是精英独有，而是我们每个人都会或多或少带有的思维定式。换算到平时就是买手机。我们总是抨击安卓阵营堆硬件，拿参数忽悠人。一部分人说你看苹果从来不忽悠硬件，人家比安卓顺溜多了。另一部分人告诉你，苹果的硬件实际上是领先于同期安卓的旗舰机的，加上自己掌握了生产线自己能够针对性的优化，当然更容易跑顺溜。我们之中的大部分人也会认为考试考高分是正道，大家都在考试前努力复习，期望拿到高分。\r\n我不会去这样做。平时听完了就完了，考试不会特意复习，该怎样怎样。当然，成绩一般般，只是够用而已。对我来说，那些看得见的定量指标没有那么重要。因为那些指标并不完善。\r\n我更愿意拿这部分时间去做另一些事儿。这些事儿不是定量分析所能看出结果的。当然我也有觉悟，承受这一切所带来的好处和代价。就是这样。\r\n下午看到一片文章，里面有这样的原话：“你会看到大量的分析师、投资家、企业家的图表，它都是描画一个“上翘的箭头”，以此来证明其正当性。今天我们看到的所谓信息社会的分析师，所操持的语言 与腔调，也不过如此。”——嘿，我觉得下午看到的那个，说点赞按钮破坏微博的信息传播效率，因此是一个失败透顶的设计的那位小哥，所谓精英病，大抵如此。\r\n我想，对上翘箭头的崇拜和追求，无论对整个人类社会，还是对每个个体的进步，都会是很大的鼓励和促进。但反过来说，最终的目的是进步，而不是上翘箭头本身。\r\n对吧。','2014-03-08 22:51:53','2014-03-13 02:46:54','精英病与上翘箭头的崇拜',0);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20131014082401'),('20131014083014'),('20131014083107'),('20131014151338'),('20131015034030'),('20131015061207'),('20131017055121'),('20140215140411'),('20140216124313'),('20140311090735'),('20140311094628');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_digest` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mood` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  KEY `index_users_on_remember_token` (`remember_token`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'辙道辕门','169192@gmail.com','$2a$10$wmwmyUmzeb.Ekej6jx1MTOpeeXbVJ.WV7wQOpQrF9SuP3HWzMl9PC','好门','2014-02-09 01:42:55','2014-03-11 11:20:05','a72b4efdfac4b014f1c73f8c8a8c009c678b7d26',1),(2,'cossy','1435852499@qq.com','$2a$10$oZTLRGaiWSbsFG2qVoZH3uPPxqkXtfn6eXxx.W2lnfxwyylkooVwy',NULL,'2014-02-14 21:33:00','2014-02-14 21:33:26','a12211c25d5174968e4bc856cad4398cefb74b9f',0),(3,'greed','974520351@qq.com','$2a$10$v3CG.aPtN6cFbBF1EEtby.fQ0g9RJiPVynvLMLWHG1hDlxKY1dxvK',NULL,'2014-02-14 23:02:52','2014-02-14 23:02:52','20c3842cf41f80c07f916566e8927b5000eae579',0),(4,'極楽往生','363718744@qq.com','$2a$10$gLEzlzagsB3kyLfnIdkD0.HwaUNZ1zpV1Ni4hzXKL3E8MZyA5zb9S',NULL,'2014-02-16 23:56:20','2014-03-11 11:20:09','195fe17a8af7988b7619b7ed6189e48626fe6957',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_counts`
--

DROP TABLE IF EXISTS `view_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_counts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_counts`
--

LOCK TABLES `view_counts` WRITE;
/*!40000 ALTER TABLE `view_counts` DISABLE KEYS */;
INSERT INTO `view_counts` VALUES (1,6,'2014-03-11 20:06:05','2014-03-12 16:18:55');
/*!40000 ALTER TABLE `view_counts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-13 15:29:17
