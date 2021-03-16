/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `express_spring`;
CREATE DATABASE IF NOT EXISTS `express_spring` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `express_spring`;

DROP TABLE IF EXISTS `blog`;
CREATE TABLE IF NOT EXISTS `blog` (
  `blogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '0',
  `userId` int(11) unsigned NOT NULL DEFAULT 0,
  `content` text NOT NULL,
  `dateAdded` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`blogId`),
  KEY `FK_blog_user` (`userId`),
  CONSTRAINT `FK_blog_user` FOREIGN KEY (`userId`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `blog`;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` (`blogId`, `title`, `userId`, `content`, `dateAdded`) VALUES
	(1, 'test 1', 8, '<strong>test</strong', '2021-03-15 11:38:04'),
	(2, 'test 2', 1, 'test', '2021-03-15 11:38:21');
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `imageID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `imageFile` varchar(40) NOT NULL,
  `description` text NOT NULL,
  `dateModified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`imageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `image`;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` (`imageID`, `imageFile`, `description`, `dateModified`) VALUES
	(1, 'e0a08901ae798ec6a1ecdbf46ab046f3.jpg', 'A frog on a leaf!', '2021-02-25 09:52:13'),
	(2, 'd07139ee166aaa9e33175280d305ba3f.jpg', '', '2021-02-25 09:59:49'),
	(3, '55b5f5487b7f37b6d3d431fc8d8a9d5a.jpg', '', '2021-02-25 10:01:04'),
	(4, '1767ec70a389b72b0b6c0ffcfbdb156f.jpg', '', '2021-02-25 10:03:07'),
	(5, 'd725fc06d3a9d5c76b0f01df1909bd6e.jpg', 'some frog', '2021-02-25 10:05:45'),
	(6, '05676b7c2bc9fcce2704b3d06c2b59c0.jpg', 'a wise newfoundland dog!', '2021-02-25 10:21:48');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `menuID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `cssID` varchar(12) NOT NULL,
  `dateModified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`menuID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `menu`;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`menuID`, `name`, `cssID`, `dateModified`) VALUES
	(1, 'main', 'main', '2021-02-23 08:51:23'),
	(2, 'side', 'side', '2021-03-10 10:47:14'),
	(3, 'footer', 'footer', '2021-03-12 09:10:01');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

DROP TABLE IF EXISTS `menuitem`;
CREATE TABLE IF NOT EXISTS `menuitem` (
  `menuItemID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menuID` int(10) unsigned NOT NULL,
  `html` text NOT NULL,
  `link` varchar(32) NOT NULL,
  `target` varchar(16) NOT NULL DEFAULT '_self',
  `sort` int(11) NOT NULL,
  `dateModified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`menuItemID`),
  KEY `menuID` (`menuID`),
  CONSTRAINT `menuitem_ibfk_1` FOREIGN KEY (`menuID`) REFERENCES `menu` (`menuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `menuitem`;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` (`menuItemID`, `menuID`, `html`, `link`, `target`, `sort`, `dateModified`) VALUES
	(1, 1, 'Home', 'home', '_self', 0, '2021-03-10 10:28:16'),
	(2, 1, 'Contact Us', 'contact', '_self', 2, '2021-03-15 12:09:53'),
	(3, 2, 'Copyright Policy', 'copyright', '_self', -1, '2021-03-12 09:11:45'),
	(7, 1, 'Blog', 'blog', '_self', 1, '2021-03-15 12:09:49');
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;

DROP TABLE IF EXISTS `page`;
CREATE TABLE IF NOT EXISTS `page` (
  `pageID` int(11) NOT NULL AUTO_INCREMENT,
  `pageKey` varchar(32) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `lastUserID` int(10) unsigned NOT NULL,
  `dateModified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`pageID`),
  UNIQUE KEY `pageKey` (`pageKey`),
  KEY `FK_page_user` (`lastUserID`),
  CONSTRAINT `FK_page_user` FOREIGN KEY (`lastUserID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `page`;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` (`pageID`, `pageKey`, `title`, `content`, `lastUserID`, `dateModified`) VALUES
	(1, 'home', 'Home', '<p class="content">hy\r\n    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac auctor turpis. Cras ante risus,\r\n    tempus id leo sed, finibus tristique lacus. Praesent consectetur mauris in arcu efficitur, a\r\n    sollicitudin ante semper. Ut volutpat, leo non molestie finibus, nisi odio tincidunt erat, vel\r\n    egestas ex tellus eu lectus. Sed feugiat blandit ex sit amet dapibus. Praesent vehicula augue velit,\r\n    id elementum dolor eleifend nec. Curabitur erat dolor, tempor at dolor eu, sagittis sollicitudin\r\n    ligula. Morbi egestas pharetra lectus sed blandit. Phasellus pharetra est eu ultricies dignissim.\r\n    Mauris egestas turpis nec nunc sodales malesuada. Interdum et malesuada fames ac ante ipsum primis\r\n    in faucibus.\r\n</p>\r\n<p class="content">\r\n    Nam odio quam, laoreet eu dignissim vel, commodo sit amet metus. Nunc ut porttitor elit, id lacinia\r\n    erat. Sed facilisis nibh id magna pretium interdum. Proin pretium ipsum sed maximus placerat. Mauris\r\n    dictum augue non placerat fermentum. Duis ut porttitor lacus, convallis cursus nulla. Mauris vel\r\n    finibus erat. Mauris id velit sed massa commodo vehicula. Fusce dapibus congue quam at lobortis.\r\n    Praesent et elementum nisi. Sed non dictum nisi. Cras porta et felis eget pulvinar. Vestibulum\r\n    luctus volutpat finibus. Aenean imperdiet sapien non maximus efficitur. Fusce molestie neque vitae\r\n    scelerisque hendrerit.\r\n</p>\r\n<p class="content">\r\n    Ut fringilla ipsum risus, lobortis tincidunt dui eleifend eget. Proin sagittis dignissim mi, id\r\n    venenatis dui egestas et. Nunc eu lacinia ipsum, in ultricies lectus. Aliquam erat volutpat.\r\n    Maecenas varius mi id elit accumsan, ac volutpat massa finibus. Duis pretium augue id eros\r\n    venenatis, id porttitor ex euismod. Mauris suscipit enim at blandit consectetur. Integer tempus\r\n    turpis eu nisl vestibulum dapibus. Ut ultricies suscipit nisl, non commodo nisi laoreet eu. Maecenas\r\n    aliquam justo sed neque laoreet convallis.\r\n</p>\r\n<p class="content">\r\n    Maecenas in dictum quam, facilisis lacinia dui. Nullam feugiat, ipsum a rhoncus convallis, ex tellus\r\n    sagittis mi, nec egestas massa ante blandit orci. Sed placerat urna non nisl molestie, quis laoreet\r\n    metus ullamcorper. Aliquam pretium nunc eu diam dictum, ac fermentum libero fringilla. Donec ac\r\n    tempor ex. Etiam auctor mi dui, ut sagittis est mollis ut. Praesent accumsan iaculis gravida.\r\n    Vivamus aliquam dolor id dictum interdum. Phasellus varius aliquam magna, a sollicitudin nibh\r\n    rhoncus vitae. Cras non interdum lorem, eget placerat ipsum.\r\n</p>\r\n<p class="content" id="lastp">\r\n    Nunc nec euismod velit, id commodo est. Phasellus a tempor dolor. Nullam mollis non orci vitae\r\n    rutrum. Fusce blandit nisl orci, id sagittis leo aliquet vitae. Nulla vestibulum porta nunc sit\r\n    amet\r\n    cursus. Donec sit amet ligula dolor. Cras feugiat finibus magna. Duis sit amet lacus dui. Nunc\r\n    facilisis consequat nunc eget egestas. Curabitur ultrices urna diam, hendrerit auctor odio\r\n    fringilla\r\n    sit amet. In vel nulla velit. Maecenas pharetra in ligula ac sollicitudin. Donec volutpat\r\n    porttitor\r\n    augue eu aliquam.\r\n</p>', 1, '2021-03-12 09:52:18'),
	(2, 'contact', 'Contact Us', '<a href="mailto:lstephenson@cegep-heritage.qc.ca">Email</a>', 8, '2021-03-12 11:15:34'),
	(3, 'upload', 'Upload a File!', 'upload_image.php', 1, '2021-03-12 09:52:22'),
	(4, 'gallery', 'Pictures', '<img src="https://programmedcleaning.com/wp-content/uploads/spring-season.jpg" / style="width:40vw"> ', 8, '2021-03-12 11:12:35'),
	(5, 'copyright', 'Our Copyright Policy', '<h1>Don\'t steal our stuff!</h1>', 1, '2021-03-12 09:52:26'),
	(6, 'bob', 'dfgd', 'sdfsdf', 1, '2021-03-12 11:26:58'),
	(7, 'test', 'dfgd', 'fxdcgdgcfgh', 8, '2021-03-12 11:32:50');
/*!40000 ALTER TABLE `page` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `passHash` varchar(256) NOT NULL,
  `cookieHash` varchar(256) NOT NULL,
  `dateModified` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userID`, `username`, `passHash`, `cookieHash`, `dateModified`) VALUES
	(1, 'bob', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=', 'Yf81+XZHvmkcyKuXmK4fntn/rp5fZp8uBjQ3nqRtH0s=', '2021-03-15 09:28:46'),
	(6, 'fhfgy', '550bd0e77e819081c9aa89043382aee9cb341730', '89553c275a3c947762ec7354d19b04eecb41e71c', '2021-02-24 09:08:29'),
	(8, 'luke', 'zM9S89A8UHLuZKE290/FayfgTxX/5dHSd9WKsY2Usyc=', 'CWi8YE4eQaGFSSsc8hiONOz4ecViXr/NFMKGpNcKF60=', '2021-03-15 12:10:21');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
