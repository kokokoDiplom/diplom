DROP DATABASE IF EXISTS `testingsystem`;
CReATE DATABASE `testingsystem`;
USE `testingsystem`;

DROP TABLE IF EXISTS `problems`;
CREATE TABLE IF NOT EXISTS `problems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `problem` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `variant` int(11) NOT NULL,
  `text_problem` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `problems` (`problem`, `level`, `variant`, `text_problem`) VALUES
(1, 228, 1, 'text_text_text_text_text_text_text'),
(2, 1488, 2, 'text_text_text_text_text_text_text_text_text_text_text_text_text_text'),
(1, 666, 777, 'лалка'),
(1, 228, 2, 'ss'),
(1, 228, 3, 'ss'),
(1, 228, 4, 'ss'),
(1, 1, 1, 'text_text_text_text_text_text_text'),
(2, 2, 2, 'text_text_text_text_text_text_text_text_text_text_text_text_text_text'),
(1, 2, 3, '<b>lol</b>\r\n</br> \r\n<code>лол</code> \r\n123\r\n\r\n987'),
(2, 2, 4, 'trololo'),
(1, 1, 3, '<b>lol</b>\r\n');

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fam` char(40) DEFAULT NULL,
  `name` char(40) DEFAULT NULL,
  `otch` char(40) DEFAULT NULL,
  `login` char(40) DEFAULT NULL,
  `pass` char(50) DEFAULT NULL,
  `email` char(80) DEFAULT NULL,
  `lvlAccess` char(20) NOT NULL,
  `sost` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `users` (`fam`, `name`, `otch`, `login`, `pass`, `email`, `lvlAccess`, `sost`) VALUES
('Админов', 'Админ', 'Админович', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'qwe@qwe.qwe', 'Администратор', 'Активен');