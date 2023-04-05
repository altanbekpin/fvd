/*
 Navicat Premium Data Transfer

 Source Server         : 10.255.140.4
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : 10.255.140.4:33066
 Source Schema         : quotes_db

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 05/04/2023 16:02:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for legacy
-- ----------------------------
DROP TABLE IF EXISTS `legacy`;
CREATE TABLE `legacy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_file` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of legacy
-- ----------------------------
BEGIN;
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (1, 'Халық мұрасы', 'Мұрасы/Халық мұрасы', NULL, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (3, 'Баталар', 'Мұрасы/Халық мұрасы/Баталар', 1, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (4, 'Баталар.pdf', 'Мұрасы/Халық мұрасы/Баталар/Баталар.pdf', 3, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (5, 'Жырлар', 'Мұрасы/Халық мұрасы/Жырлар', 1, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (6, '23 жоқтау.pdf', 'Мұрасы/Халық мұрасы/Жырлар/23 жоқтау.pdf', 5, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (7, 'Ер Сайын.pdf', 'Мұрасы/Халық мұрасы/Жырлар/Ер Сайын.pdf', 5, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (8, 'Әндер', 'Мұрасы/Халық мұрасы/Әндер', 1, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (9, 'Әндері.pdf', 'Мұрасы/Халық мұрасы/Әндер/Әндері.pdf', 8, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (10, 'Ғылымның басқа салалары', 'Мұрасы/Ғылымның басқа салалары', NULL, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (11, 'Мақалалар', 'Мұрасы/Ғылымның басқа салалары/Мақалалар', 10, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (12, 'Тәні саудың - жаны сау.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Тәні саудың - жаны сау.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (13, 'Қазақ жерін алу турасындағы низам.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ жерін алу турасындағы низам.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (14, 'Тағы да народный сот хақында. 1911 ж..pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Тағы да народный сот хақында. 1911 ж..pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (15, 'Уақ қарыз.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Уақ қарыз.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (16, 'Аңдаспаған мәселе турасында.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Аңдаспаған мәселе турасында.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (17, 'Бас қосуға рұқсат берілмеді.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Бас қосуға рұқсат берілмеді.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (18, 'Көшпелі һәм отырықшы норма.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Көшпелі һәм отырықшы норма.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (19, 'Бас қосу турасында.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Бас қосу турасында.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (20, 'Губернатор өзгерілуі.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Губернатор өзгерілуі.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (21, 'В.Л. Буртсев.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/В.Л. Буртсев.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (22, 'Партия әм кеңес құрылысындағы рушылық әсері.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Партия әм кеңес құрылысындағы рушылық әсері.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (23, 'Досмайыл хажыға ашық хат.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Досмайыл хажыға ашық хат.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (24, 'Қазаққа ашық хат.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазаққа ашық хат.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (25, 'МОПР һәм күншығыс елдерінің еңбекшілері.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/МОПР һәм күншығыс елдерінің еңбекшілері.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (26, 'Шаруа жайынан.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Шаруа жайынан.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (27, 'Соғысушы патшалар.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Соғысушы патшалар.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (28, 'Жер жалдау жайынан.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Жер жалдау жайынан.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (29, 'Земство.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Земство.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (30, 'Ауру жайынан.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Ауру жайынан.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (31, 'Закон жобасының баяндамасы.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Закон жобасының баяндамасы.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (32, 'Қазақ һәм 4-ші Дума.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ һәм 4-ші Дума.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (33, '5 мың десятина жер.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/5 мың десятина жер.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (34, 'Орынбор 13-нші октиабір.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Орынбор 13-нші октиабір.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (35, 'Орыс мейірманшылығы.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Орыс мейірманшылығы.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (36, 'ов туралы.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/ов туралы.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (37, 'Қазақстан дәуірінің жаңа құрылымы.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақстан дәуірінің жаңа құрылымы.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (38, 'Бұ заманның соғысы. 1914.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Бұ заманның соғысы. 1914.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (39, 'Лениннің елу жасы.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Лениннің елу жасы.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (40, 'Қазақ һәм түрлі мәселелер.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақ һәм түрлі мәселелер.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (41, 'Қазақтың өкпесі.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Қазақтың өкпесі.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (42, 'Егін егу.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Егін егу.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (43, 'Жәрдем комитеті. 1915.pdf', 'Мұрасы/Ғылымның басқа салалары/Мақалалар/Жәрдем комитеті. 1915.pdf', 11, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (45, 'Тіл ғылымы', 'Мұрасы/Тіл ғылымы', NULL, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (47, 'Әліппелер', 'Мұрасы/Тіл ғылымы/Әліппелер', 45, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (48, 'Сауат ашқыш. Ересектерге арналған әліппе. Семей, 1926.pdf', 'Мұрасы/Тіл ғылымы/Әліппелер/Сауат ашқыш. Ересектерге арналған әліппе. Семей. 1926.pdf', 47, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (49, 'Әліпби. Жаңа құрал. Қызылорда, 1926.pdf', 'Мұрасы/Тіл ғылымы/Әліппелер/Әліпби. Жаңа құрал. Қызылорда. 1926.pdf', 47, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (50, 'Оқу құралы. Бірінші кітап. Балаларға арналған әліппе. Орынбор, 1912.pdf', 'Мұрасы/Тіл ғылымы/Әліппелер/Оқу құралы. Бірінші кітап. Балаларға арналған әліппе. Орынбор. 1912.pdf', 47, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (51, 'Оқулықтар', 'Мұрасы/Тіл ғылымы/Оқулықтар', 45, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (52, 'Оқулық. Тіл-құрал. 1-нші тіл танытқыш кітап. Қызылорда, 1925.pdf', 'Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 1-нші тіл танытқыш кітап. Қызылорда, 1925.pdf', 51, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (53, 'Оқулық. Тіл-құрал. 3-жылдық. Қызылорда, 1925.pdf', 'Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 3-жылдық. Қызылорда, 1925.pdf', 51, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (54, 'Оқулық. Тіл-құрал. 2-жылдық. Орынбор, 1915.pdf', 'Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал. 2-жылдық. Орынбор, 1915.pdf', 51, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (55, 'Оқулық. Тіл-құрал 1-жылдық. Орынбор, 1914.pdf', 'Мұрасы/Тіл ғылымы/Оқулықтар/Оқулық. Тіл-құрал 1-жылдық. Орынбор, 1914.pdf', 51, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (56, 'Мақалалар', 'Мұрасы/Тіл ғылымы/Мақалалар', 45, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (57, 'Түрікшелер құрылтайы.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Түрікшелер құрылтайы.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (58, 'Тіл қисыны.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Тіл қисыны.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (59, 'Түзетілген әріп.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Түзетілген әріп.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (60, 'Емле туралы.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Емле туралы.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (61, 'Дыбыстарды жіктеу туралы.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Дыбыстарды жіктеу туралы.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (62, 'А.Байтұрсынұлының араб әліп-биін жақтаған баяндамасы.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/А.Байтұрсынұлының араб әліп-биін жақтаған баяндамасы.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (63, 'Жазу мәселесі.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Жазу мәселесі.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (64, 'Шаһзаман мырзаға.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Шаһзаман мырзаға.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (65, 'Жазу тәртібі.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Жазу тәртібі.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (66, 'Қазақша сөз жазушыларға.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Қазақша сөз жазушыларға.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (67, 'Сөз талғау.pdf', 'Мұрасы/Тіл ғылымы/Мақалалар/Сөз талғау.pdf', 56, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (68, 'Әдебиет ғылымы', 'Мұрасы/Әдебиет ғылымы', NULL, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (70, 'Аудармалар', 'Мұрасы/Әдебиет ғылымы/Аудармалар', 68, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (71, 'Қырық мысал.pdf', 'Мұрасы/Әдебиет ғылымы/Аудармалар/Қырық мысал.pdf', 70, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (72, 'Оқулық', 'Мұрасы/Әдебиет ғылымы/Оқулық', 68, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (73, 'Әдебиет танытқыш.pdf', 'Мұрасы/Әдебиет ғылымы/Оқулық/Әдебиет танытқыш.pdf', 72, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (74, 'Өлеңдер', 'Мұрасы/Әдебиет ғылымы/Өлеңдер', 68, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (75, 'Маса.pdf', 'Мұрасы/Әдебиет ғылымы/Өлеңдер/Маса.pdf', 74, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (76, 'Мақалалар', 'Мұрасы/Әдебиет ғылымы/Мақалалар', 68, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (77, 'Қалам қайраткерлері жайынан.pdf', 'Мұрасы/Әдебиет ғылымы/Мақалалар/Қалам қайраткерлері жайынан.pdf', 76, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (78, 'Қазақтың бас ақыны. №43.pdf', 'Мұрасы/Әдебиет ғылымы/Мақалалар/Қазақтың бас ақыны. №43.pdf', 76, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (79, 'Әдістеме ғылымы', 'Мұрасы/Әдістеме ғылымы', NULL, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (80, 'Оқу-әдістемелік құралдар', 'Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар', 79, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (81, 'Баяншы. Қазан, 1920.pdf', 'Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Баяншы. Қазан, 1920.pdf', 80, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (82, 'Тіл-жұмсар. 1-кітап. Қызылорда, 1928..pdf', 'Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Тіл-жұмсар. 1-кітап. Қызылорда, 1928..pdf', 80, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (83, 'Оқу құралы. Хрестоматия. Қызылорда, 1927.pdf', 'Мұрасы/Әдістеме ғылымы/Оқу-әдістемелік құралдар/Оқу құралы. Хрестоматия. Қызылорда, 1927.pdf', 80, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (84, 'Мақалалар', 'Мұрасы/Әдістеме ғылымы/Мақалалар', 79, 0);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (85, 'Білім жарысы.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Білім жарысы.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (86, 'Орысша оқушылар.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Орысша оқушылар.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (87, 'Бастауыш мектеп. 1914.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Бастауыш мектеп. 1914.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (88, 'Қазақ арасында оқу жұмыстарын қалай жүргізу керек. 1923.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Қазақ арасында оқу жұмыстарын қалай жүргізу керек. 1923.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (89, 'Мектеп керектері.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Мектеп керектері.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (90, 'Шекіспей, бекіспейді.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Шекіспей, бекіспейді.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (91, 'Қай әдіс жақсы.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Қай әдіс жақсы.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (92, 'Оқыту жайынан.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Оқыту жайынан.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (93, 'Баулу мектебі.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Баулу мектебі.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (94, 'Жалқылау әдіс.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Жалқылау әдіс.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (95, 'Білім жарысы қақында.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Білім жарысы қақында.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (96, 'Жалқылаулы-жалпылау әдіс.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Жалқылаулы-жалпылау әдіс.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (97, 'Оқу жайы.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Оқу жайы.pdf', 84, 1);
INSERT INTO `legacy` (`id`, `name`, `path`, `parent_id`, `is_file`) VALUES (98, 'Қазақша оқу жайынан.pdf', 'Мұрасы/Әдістеме ғылымы/Мақалалар/Қазақша оқу жайынан.pdf', 84, 1);
COMMIT;

-- ----------------------------
-- Table structure for page
-- ----------------------------
DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT NULL,
  `is_hidden` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of page
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for quote
-- ----------------------------
DROP TABLE IF EXISTS `quote`;
CREATE TABLE `quote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quote` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quote_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `added_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of quote
-- ----------------------------
BEGIN;
INSERT INTO `quote` (`id`, `quote`, `quote_by`, `added_by`, `created`, `updated`) VALUES (1, 'Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.', 'Allan Kay', 'Sam', '2022-08-04 17:04:32', NULL);
INSERT INTO `quote` (`id`, `quote`, `quote_by`, `added_by`, `created`, `updated`) VALUES (2, 'Мен қосып отырмын ', 'Altosh', 'Altosh', '2022-08-05 11:46:28', NULL);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
