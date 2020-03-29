drop database if exists my_shop;
create database my_shop;
use my_shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (1, 'Готовые решения'),
  (2, 'Плагины'),
  (3, 'SEO'),
  (4, 'Размещение'),
  (5, 'Администрирование');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL primary key,
  firstname varchar(100) COMMENT 'Имя покупателя',
  lastname varchar(100) COMMENT 'Фамилия покупателя',
  email varchar(150) unique,
  password_hash varchar(200),
  phone BIGINT,

  index users_phone_idx(phone),
  index (firstname, lastname)
) COMMENT = 'Покупатели';

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`)
VALUES
('1', 'Wilfrid', 'Gulgowski', 'arau@example.com', '9d86f67029ff654d3119989c2aae9d3d8077a76e', '791300000000'),
('2', 'Charlie', 'Adams', 'qzulauf@example.net', 'df555b8a4bbcd175e7d899f6107fe3e2fcb3b045', '791300000001'),
('3', 'Shanelle', 'Bechtelar', 'frances70@example.org', '78ebcd622ff46c9eedf94f153582004f5f97bfc0', '791300000002'),
('4', 'Chester', 'Gibson', 'wheidenreich@example.net', '82ddf925c7b60a5f38ab98208f6cfa5ed72aef02', '791300000003'),
('5', 'Janick', 'Tremblay', 'carroll.ignacio@example.net', 'd0d0185c6f4630cfef10a8baaa12994cde21eb8a', '791300000004'),
('6', 'Kari', 'Emard', 'alysa.botsford@example.net', 'f6a4a67c33a5124355646835ae330f0b6dc77eff', '791300000005'),
('7', 'Olga', 'Mann', 'timmy99@example.net', '4a263fae34f7ff1b9adce57adf1b179420efd24a', '791300000006'),
('8', 'Charity', 'Fritsch', 'piper04@example.org', '0975335f79295bf97b2a109d424793d863fdd79f', '791300000007'),
('9', 'Lucious', 'Boehm', 'josiane42@example.com', '52acdaa74d4583e67b8fb0a338c02bdfd4f5696d', '791300000008'),
('10', 'Demond', 'Heaney', 'terrell18@example.net', 'b5acaf254434b5715d52f1b38e6e618ee99ae063', '791300000009'),
('11', 'Carolanne', 'Pagac', 'torp.daphney@example.net', '6a61b002ff1e394e414a3c59ddd9e55f0b72b7ab', '791300000010'),
('12', 'Ike', 'Pfeffer', 'nziemann@example.net', '378ad67c3f2cdc43b5c81b115f66fa5901ff986a', '791300000011'),
('13', 'Paul', 'Ullrich', 'wendy.cruickshank@example.com', 'be06fe0c2cb7bc4d5b8c2e3a024d2be9ffac2310', '791300000012'),
('14', 'Brian', 'O\'Keefe', 'haley.burley@example.org', 'a3a0b1bc92ac2afb497d849c36eae4908910f916', '791300000013'),
('15', 'Arno', 'Monahan', 'obauch@example.net', 'a24d075dc8e8fd6eaff27958b1cbeefe39969751', '791300000014');

drop table if exists photos;
create table photos (
  id SERIAL primary key,
  link_to_photo BIGINT UNSIGNED not null,
);

drop table if exists profiles;
create table profiles (
  user_id SERIAL primary key,
  gender CHAR(1),
  birtday DATE,
  photo_id BIGINT UNSIGNED null,
  hometown VARCHAR(100),
  created_at DATETIME default now(),
  updated_at DATETIME DEFAULT now() ON UPDATE now(),

  foreign key (user_id) references users(id)
  foreign key (photo_id) references photos(id)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id BIGINT UNSIGNED,
  created_at DATETIME DEFAULT now(),
  updated_at DATETIME DEFAULT now() ON UPDATE now(),

  foreign key (catalog_id) references catalogs(id)
) COMMENT = 'Предложения';

INSERT INTO products (name, description, price, catalog_id)
VALUES
  ('Интернет магазин №1', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 25000.00, 1),
  ('Интернет магазин №2', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 30000.00, 1),
  ('Интернет магазин №3', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 35000.00, 1),
  ('Модуль загрузки прайса', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 10000.00, 2),
  ('Модуль выгрузки прайса', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 10000.00, 2),
  ('Размещение на хостере', 'Выбор, регистрация домена, аренда мощностей, размещение магазина', 2500.00, 4),
  ('SEO продвижение', 'Продвижение интернет магазина', 7000.00, 3),
  ('Администрирование магазина', 'Администрирование, решение проблем', 7000.00, 5);

drop table if exists showroom;
create table showroom (
  id SERIAL primary key,
  link_to_product BIGINT UNSIGNED not null,

  foreign key (link_to_product) references products(id)
  );

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`)
VALUES
('1', 1, '1972-04-26 16:02:11', '1971-10-12 23:40:56'),
('2', 2, '1994-04-28 21:12:13', '1984-03-27 02:58:29'),
('3', 3, '2017-11-24 20:48:15', '1972-01-21 09:27:13'),
('4', 4, '1990-08-08 21:28:56', '1974-07-25 07:33:35'),
('5', 5, '1972-03-14 14:22:46', '1971-03-26 14:43:45'),
('6', 6, '2004-11-15 21:11:47', '2000-06-24 14:32:44'),
('7', 1, '1970-12-24 16:20:35', '1974-10-26 08:37:47'),
('8', 2, '1989-02-07 10:57:21', '1974-05-12 05:54:43'),
('9', 3, '2006-06-13 06:11:48', '1973-01-12 19:11:06'),
('10', 4, '2014-04-30 01:47:05', '1980-12-25 08:38:26'),
('11', 5, '1994-09-02 05:49:41', '2002-02-21 01:11:44'),
('12', 6, '1983-05-30 05:27:22', '2004-12-21 16:58:18'),
('13', 1, '2001-02-15 20:36:05', '1994-01-30 00:06:50'),
('14', 2, '2019-04-18 16:45:34', '2017-07-14 03:00:49'),
('15', 3, '2013-08-21 23:10:59', '1982-03-22 21:28:50');

drop table if exists cart;
create table cart (
	id SERIAL primary key,
	user_id BIGINT UNSIGNED not null,
  order_id BIGINT UNSIGNED not null,

  foreign key (user_id) references users(id),
  foreign key (order_id) references orders(id)
);

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  foreign key (order_id) references orders(id),
  foreign key (product_id) references products(id)

) COMMENT = 'Состав заказа';

INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`)
VALUES
('1', 1, 1, 1, '1988-04-25 06:03:23', '1999-10-08 20:01:50'),
('2', 2, 2, 1, '1990-07-16 20:12:09', '1998-08-08 15:07:55'),
('3', 3, 3, 1, '2013-03-16 10:13:41', '1978-06-27 18:12:23'),
('4', 4, 4, 1, '1988-05-11 04:01:28', '1991-11-21 19:48:09'),
('5', 5, 5, 1, '2010-06-04 23:15:02', '1975-12-03 03:03:26'),
('6', 6, 6, 1, '1984-06-09 22:50:06', '2008-03-25 08:26:56'),
('7', 7, 7, 1, '1998-07-17 01:24:48', '1983-07-22 23:09:04'),
('8', 8, 1, 1, '2009-11-09 18:20:06', '2002-04-13 07:19:33'),
('9', 9, 2, 1, '1971-02-04 03:24:15', '1998-10-29 08:55:02'),
('10', 10, 3, 1, '1990-01-07 16:03:11', '2001-09-14 06:54:42'),
('11', 11, 4, 1, '1992-12-08 15:48:06', '1989-09-19 01:36:09'),
('12', 12, 5, 1, '1990-01-20 15:52:11', '1989-08-10 21:53:22'),
('13', 13, 6, 1, '2010-01-23 11:49:20', '2002-11-23 04:49:11'),
('14', 14, 7, 1, '1972-03-05 04:45:44', '1979-04-23 02:09:33'),
('15', 15, 1, 1, '2019-11-18 09:02:29', '2018-07-07 02:18:00');

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id),

  foreign key (product_id) references products(id),
  foreign key (user_id) references users(id)

) COMMENT = 'Скидки';

INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`)
VALUES
('1', 1, 1, '4556860', '1996-08-05 01:52:22', '1987-12-01 16:23:46', '2011-04-14 15:01:42', '1998-09-08 16:28:44'),
('2', 2, 2, '1', '1988-09-17 15:54:37', '1988-05-08 22:41:05', '2007-01-28 00:26:37', '1999-09-04 22:31:12'),
('3', 3, 3, '0', '1979-08-04 21:50:03', '1999-08-27 00:13:37', '2013-11-11 06:15:52', '1986-02-28 15:47:38'),
('4', 4, 4, '4779', '2009-06-24 16:41:44', '2016-02-19 17:26:33', '2007-08-02 19:35:33', '1987-11-05 01:29:05'),
('5', 5, 5, '516', '1998-03-31 08:47:17', '2012-02-05 05:39:00', '2002-03-11 01:59:18', '1995-11-28 22:37:24'),
('6', 6, 6, '0', '1988-05-16 11:49:20', '1992-11-21 09:22:13', '2000-07-14 10:37:21', '2001-11-19 19:07:32'),
('7', 1, 7, '8236', '2014-03-31 16:02:25', '1973-10-16 22:26:19', '2012-05-30 03:14:57', '1976-11-15 02:00:16'),
('8', 2, 1, '561957000', '2001-09-26 00:12:14', '1980-04-20 23:50:44', '2012-05-01 21:48:08', '1989-10-27 15:53:24'),
('9', 3, 2, '628824000', '2012-02-19 13:44:18', '1977-05-01 13:43:42', '1982-11-03 08:55:05', '2007-04-01 09:37:50'),
('10', 4, 3, '0', '1977-08-10 07:05:30', '1973-08-22 21:41:08', '1983-11-17 21:27:15', '1978-05-19 03:27:34'),
('11', 5, 4, '152315', '2018-11-26 21:45:21', '1999-12-01 14:30:08', '1970-12-01 03:29:55', '2018-10-25 02:49:34'),
('12', 6, 5, '141', '1991-08-03 08:48:42', '2010-11-28 10:59:50', '1980-03-20 13:35:49', '2001-08-13 23:42:42'),
('13', 1, 6, '1905400', '1977-07-19 02:04:23', '2002-09-07 01:11:50', '1981-12-19 14:29:22', '2003-08-18 09:30:20'),
('14', 2, 7, '31689600', '1975-09-18 10:33:47', '1977-01-05 11:47:15', '2014-12-31 22:33:26', '2014-12-18 14:16:31'),
('15', 3, 1, '51672400', '2007-06-05 02:19:58', '2017-10-13 02:57:21', '1996-07-14 01:43:16', '1983-08-20 12:22:59');

-- DROP TABLE IF EXISTS storehouses;
-- CREATE TABLE storehouses (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(255) COMMENT 'Название',
--   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- ) COMMENT = 'Склады';
--
-- INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`)
-- VALUES
-- ('1', 'soluta', '1986-05-30 19:11:08', '1982-12-15 13:12:57'),
-- ('2', 'et', '2001-12-25 02:39:39', '2003-03-24 12:10:30'),
-- ('3', 'provident', '2012-01-03 16:32:34', '2004-02-05 03:49:21'),
-- ('4', 'quasi', '2015-03-14 13:24:31', '2001-05-19 03:21:35'),
-- ('5', 'a', '1970-11-13 11:24:03', '2011-09-24 10:42:03'),
-- ('6', 'mollitia', '2007-04-02 00:37:49', '1995-09-22 08:17:01'),
-- ('7', 'eum', '1972-06-23 09:13:38', '1981-07-17 17:12:20'),
-- ('8', 'temporibus', '1996-07-29 19:22:27', '1974-03-29 17:54:26'),
-- ('9', 'odio', '1972-10-19 22:13:11', '1974-11-19 02:04:15'),
-- ('10', 'sit', '1992-07-31 19:33:22', '1984-09-11 12:55:35'),
-- ('11', 'doloribus', '1983-03-10 01:02:16', '1982-04-21 08:02:24'),
-- ('12', 'sit', '1994-05-25 09:29:36', '1994-02-13 01:39:13'),
-- ('13', 'dolorum', '2012-01-20 21:12:27', '2003-09-16 19:46:28'),
-- ('14', 'corrupti', '1994-12-22 22:28:02', '2005-02-19 03:56:59'),
-- ('15', 'neque', '1972-03-29 08:42:33', '2015-05-26 00:21:52');
--
-- DROP TABLE IF EXISTS storehouses_products;
-- CREATE TABLE storehouses_products (
--   id SERIAL PRIMARY KEY,
--   storehouse_id INT UNSIGNED,
--   product_id INT UNSIGNED,
--   value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
--   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- ) COMMENT = 'Запасы на складе';
--
-- INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`)
-- VALUES
-- ('1', 1, 1, 5, '1989-10-29 06:23:34', '1974-01-07 08:08:01'),
-- ('2', 2, 2, 9, '2019-12-06 03:07:17', '1989-01-07 05:03:31'),
-- ('3', 3, 3, 1, '1973-05-14 20:26:55', '2014-02-25 03:47:52'),
-- ('4', 4, 4, 1, '1995-03-27 13:50:21', '1997-11-05 10:58:10'),
-- ('5', 5, 5, 1, '2017-01-31 09:54:28', '1974-07-17 06:06:32'),
-- ('6', 6, 6, 6, '2010-04-14 10:55:56', '2006-04-17 08:50:02'),
-- ('7', 7, 7, 2, '1981-11-12 18:51:23', '2006-03-11 11:11:53'),
-- ('8', 8, 1, 9, '1998-03-31 20:51:40', '1971-10-26 10:08:40'),
-- ('9', 9, 2, 8, '1992-07-27 21:42:14', '2007-09-21 00:29:29'),
-- ('10', 10, 3, 0, '1999-06-10 07:04:27', '1986-06-16 22:26:01'),
-- ('11', 11, 4, 5, '1982-10-20 15:47:51', '1986-05-05 06:10:13'),
-- ('12', 12, 5, 1, '1971-12-22 03:02:22', '1973-04-14 23:38:02'),
-- ('13', 13, 6, 8, '1981-04-06 00:34:06', '2019-01-28 23:10:42'),
-- ('14', 14, 7, 6, '2015-04-03 12:52:33', '1998-12-07 20:53:31'),
-- ('15', 15, 1, 8, '1981-10-08 22:57:02', '1981-03-15 14:27:34');
