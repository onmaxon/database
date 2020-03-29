drop database if exists my_shop;
create database my_shop;
use my_shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

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

drop table if exists photos;
create table photos (
  id SERIAL primary key,
  link_to_photo VARCHAR(100)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id SERIAL primary key,
  gender CHAR(1),
  birtday DATE,
  photo_id BIGINT UNSIGNED null,
  hometown VARCHAR(100),
  created_at DATETIME default now(),
  updated_at DATETIME DEFAULT now() ON UPDATE now(),

  foreign key (user_id) references users(id),
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

DROP TABLE IF EXISTS showroom;
CREATE TABLE showroom (
  id SERIAL primary key,
  link_to_product  VARCHAR(100),

  foreign key (id) references products(id)
  );

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),

  foreign key (user_id) references users(id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
	id SERIAL primary key,
	user_id BIGINT UNSIGNED not null,
  order_id BIGINT UNSIGNED not null,
  total_coast DECIMAL (11,2),

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
