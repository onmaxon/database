-- * DDL (Data Definition Language
-- * command: create, alter, drop
drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users (
	id SERIAL primary key,  -- BIGint unsigned not null auto_increment unique
	firstname varchar(100),
	lastname varchar(100),
	email varchar(150) unique,
	password_hash varchar(200),
	phone BIGINT,

	index users_phone_idx(phone),
	index (firstname, lastname)
);

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`)
VALUES
('1', 'Wilfrid', 'Gulgowski', 'arau@example.com', '9d86f67029ff654d3119989c2aae9d3d8077a76e', '1'),
('2', 'Charlie', 'Adams', 'qzulauf@example.net', 'df555b8a4bbcd175e7d899f6107fe3e2fcb3b045', '697'),
('3', 'Shanelle', 'Bechtelar', 'frances70@example.org', '78ebcd622ff46c9eedf94f153582004f5f97bfc0', '1'),
('4', 'Chester', 'Gibson', 'wheidenreich@example.net', '82ddf925c7b60a5f38ab98208f6cfa5ed72aef02', '742604'),
('5', 'Janick', 'Tremblay', 'carroll.ignacio@example.net', 'd0d0185c6f4630cfef10a8baaa12994cde21eb8a', '927'),
('6', 'Kari', 'Emard', 'alysa.botsford@example.net', 'f6a4a67c33a5124355646835ae330f0b6dc77eff', '477685'),
('7', 'Olga', 'Mann', 'timmy99@example.net', '4a263fae34f7ff1b9adce57adf1b179420efd24a', '0'),
('8', 'Charity', 'Fritsch', 'piper04@example.org', '0975335f79295bf97b2a109d424793d863fdd79f', '469'),
('9', 'Lucious', 'Boehm', 'josiane42@example.com', '52acdaa74d4583e67b8fb0a338c02bdfd4f5696d', '90'),
('10', 'Demond', 'Heaney', 'terrell18@example.net', 'b5acaf254434b5715d52f1b38e6e618ee99ae063', '1'),
('11', 'Carolanne', 'Pagac', 'torp.daphney@example.net', '6a61b002ff1e394e414a3c59ddd9e55f0b72b7ab', '722499'),
('12', 'Ike', 'Pfeffer', 'nziemann@example.net', '378ad67c3f2cdc43b5c81b115f66fa5901ff986a', '9767824111'),
('13', 'Paul', 'Ullrich', 'wendy.cruickshank@example.com', 'be06fe0c2cb7bc4d5b8c2e3a024d2be9ffac2310', '625795'),
('14', 'Brian', 'O\'Keefe', 'haley.burley@example.org', 'a3a0b1bc92ac2afb497d849c36eae4908910f916', '0'),
('15', 'Arno', 'Monahan', 'obauch@example.net', 'a24d075dc8e8fd6eaff27958b1cbeefe39969751', '129');


drop table if exists profiles;
create table profiles (
	user_id SERIAL primary key,
	gender CHAR(1),
	birtday DATE,
	photo_id BIGINT UNSIGNED null,
	hometown VARCHAR(100),
	created_at DATETIME default now()
);

INSERT INTO profiles (`user_id`, `gender`, `birtday`, `photo_id`, `hometown`, `created_at`)
VALUES
('1', NULL, '2004-05-28', '1', NULL, '2006-09-08 15:29:12'),
('2', NULL, '2005-05-10', '2', NULL, '1982-10-04 11:13:10'),
('3', NULL, '1996-08-18', '3', NULL, '1973-08-23 20:52:04'),
('4', NULL, '1981-09-30', '4', NULL, '1983-11-23 19:50:03'),
('5', NULL, '1970-10-23', '5', NULL, '1981-08-27 07:01:45'),
('6', NULL, '2006-07-20', '6', NULL, '1982-07-02 11:46:58'),
('7', NULL, '1993-04-24', '7', NULL, '2008-08-11 06:41:18'),
('8', NULL, '1990-02-18', '8', NULL, '2007-05-15 20:02:54'),
('9', NULL, '1994-12-21', '9', NULL, '1974-11-29 20:45:52'),
('10', NULL, '1980-05-23', '10', NULL, '1980-12-08 21:19:18'),
('11', NULL, '1997-08-03', '11', NULL, '1994-09-24 08:47:29'),
('12', NULL, '1978-06-18', '12', NULL, '1983-07-30 22:50:05'),
('13', NULL, '2011-07-07', '13', NULL, '2000-07-06 15:30:19'),
('14', NULL, '1993-02-06', '14', NULL, '1971-12-10 09:50:41'),
('15', NULL, '1997-06-08', '15', NULL, '1985-09-02 00:02:18');

alter table profiles
add constraint fk_user_id
foreign key(user_id) references users(id)
	on update cascade
	on delete restrict;




drop table if exists messages;
create table messages (
	id SERIAL primary key,
	from_user_id BIGINT UNSIGNED not null,
	to_user_id BIGINT UNSIGNED not null,
	body TEXT,
	created_at DATETIME default now(),

	index (from_user_id),
	index (to_user_id),
	foreign key (from_user_id) references users(id),
	foreign key (to_user_id) references users(id)
);

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`)
VALUES
('1', '1', '2', 'Velit eligendi incidunt maiores quibusdam nihil sit culpa excepturi. Excepturi aspernatur assumenda corrupti quam. In quibusdam nisi id impedit qui.', '1977-06-05 00:14:48'),
('2', '2', '1', 'Iure repellendus minima enim nihil illum. Sunt qui aut deserunt blanditiis. Architecto ratione commodi error nemo.', '2013-11-27 04:04:15'),
('3', '3', '5', 'Rem inventore voluptas et veniam. Pariatur in autem qui non autem. Beatae alias dignissimos ut quibusdam qui quaerat qui aliquam. Velit repellendus ut est omnis.', '3000-12-19 16:40:31'),
('4', '4', '6', 'Ex laudantium vel similique eveniet hic inventore ut. Doloremque repellendus recusandae similique aut modi ullam. Doloremque qui cupiditate error omnis assumenda minus. Sequi quae voluptas est quis est.', '2011-09-26 23:29:53'),
('5', '5', '3', 'Enim nihil eius quae vel molestiae laudantium. Nemo magnam repellat est. Consequatur ipsa dicta sapiente quaerat explicabo sequi recusandae. Consequatur enim consequuntur saepe qui hic sapiente.', '1987-06-22 10:53:47'),
('6', '6', '1', 'Fugit autem tempora vel consequatur. Corrupti est dicta expedita. Fugiat eveniet dolorum rerum. Quo dolorem maxime totam molestiae quod.', '2018-06-02 05:31:48'),
('7', '7', '4', 'Incidunt eum qui voluptas alias amet. Impedit hic et ipsa ad incidunt. Accusamus et aut omnis nihil. Sint et omnis non quia fuga ex deleniti. Ut voluptatum dolor animi animi.', '2015-09-15 22:55:35'),
('8', '8', '3', 'Ut distinctio aut id illo saepe rem. Eveniet molestias eaque dolore. Autem architecto rerum consequatur sunt earum sit id quis. Repudiandae voluptatem consequuntur voluptatem eum dicta commodi.', '2034-04-20 16:14:33'),
('9', '8', '9', 'Quo aut modi numquam sed qui. Quos et nihil aperiam neque quos asperiores voluptate. Dolores ipsam veritatis sit voluptates deserunt repudiandae culpa.', '2004-06-11 06:19:34'),
('10', '10', '11', 'Beatae recusandae consequatur quisquam ex. Magni ex expedita architecto non voluptas praesentium quia. Accusamus consectetur voluptatibus occaecati tempora. Et est est vel rem est quidem error.', '2020-08-11 08:43:30'),
('11', '11', '12', 'Occaecati mollitia ut nihil dolorum labore consequatur dicta. Maxime et ullam ut eum dolore. Tenetur iste molestiae eveniet beatae. Omnis labore delectus expedita officiis mollitia odit.', '1993-03-03 12:49:12'),
('12', '12', '10', 'Aspernatur esse itaque animi magnam. Hic ducimus maxime fugiat in cum repudiandae. Reprehenderit et quo aut architecto cumque.', '1973-12-21 19:49:35'),
('13', '13', '15', 'At delectus aut dolorum officia voluptatem. Quis eius et consectetur ex ea voluptas unde accusantium. Dolor assumenda nisi et perspiciatis est quo.', '2006-05-02 12:19:45'),
('14', '14', '13', 'Est ad in vel reprehenderit qui officiis deleniti. Qui voluptatem officiis et harum. Adipisci quasi at et voluptatem.', '1975-03-06 00:08:21'),
('15', '15', '13', 'Labore temporibus quia modi quidem magni soluta. Neque nobis quia dolore. Enim voluptatum eveniet quo necessitatibus est. Ducimus iste dolores ullam repellat. Vel quisquam voluptatibus dolor autem nihil autem.', '2000-06-11 08:30:28');

drop table if exists friend_requests;
create table friend_requests (
	initiator_user_id BIGINT UNSIGNED not null,
	target_user_id BIGINT UNSIGNED not null,
	status ENUM('requested', 'approved', 'unfriended', 'declined'),
    requests_at DATETIME default now(),
    updated_at DATETIME ON UPDATE current_timestamp,

    primary key(initiator_user_id, target_user_id),
	foreign key (initiator_user_id) references users(id),
	foreign key (target_user_id) references users(id)
);

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requests_at`, `updated_at`)
VALUES
('1', '1', 'requested', '1999-01-04 20:25:27', '1976-03-22 07:49:28'),
('2', '2', 'approved', '2002-04-06 10:11:41', '1972-11-11 02:52:17'),
('3', '3', 'unfriended', '1987-09-17 12:15:57', '2015-05-08 04:42:01'),
('4', '4', 'unfriended', '1974-07-24 22:28:14', '1998-09-23 06:19:18'),
('5', '5', 'unfriended', '1996-10-04 08:48:45', '2016-05-12 04:16:17'),
('6', '6', 'unfriended', '2007-07-09 04:06:45', '2008-11-11 14:27:20'),
('7', '7', 'unfriended', '1993-05-06 11:38:57', '1996-03-24 04:55:03'),
('8', '8', 'declined', '2020-02-28 03:22:10', '2008-06-01 06:28:39'),
('9', '9', 'declined', '1988-11-22 19:45:04', '2006-12-13 16:01:41'),
('10', '10', 'declined', '1995-07-30 21:04:44', '1978-05-18 13:19:10'),
('11', '11', 'declined', '1973-08-31 08:48:54', '2012-07-31 09:55:43'),
('12', '12', 'declined', '2009-01-18 18:48:22', '2000-11-24 01:06:37'),
('13', '13', 'declined', '2000-12-09 05:51:32', '2000-07-08 23:35:45'),
('14', '14', 'declined', '2007-07-27 10:01:53', '2003-10-28 03:31:12'),
('15', '15', 'declined', '1973-08-23 22:50:09', '1997-12-13 01:14:21');

drop table if exists communities;
create table communities (
	id SERIAL primary key,
	name VARCHAR(200),
	admin_is_user BIGINT UNSIGNED not null,

	index communities_name_idx(name),
	index (admin_is_user),
	foreign key (admin_is_user) references users(id)
);

INSERT INTO `communities` (`id`, `name`, `admin_is_user`)
VALUES
('1701', 'repudiandae', '1'),
('1702', 'nihil', '4'),
('1703', 'quia', '6'),
('1704', 'dolorem', '4'),
('1705', 'tenetur', '6'),
('1706', 'eius', '8'),
('1707', 'mollitia', '9'),
('1708', 'quaerat', '9'),
('1709', 'modi', '3'),
('1710', 'dicta', '5'),
('1711', 'harum', '5'),
('1712', 'et', '8'),
('1713', 'omnis', '7'),
('1714', 'placeat', '4'),
('1715', 'laudantium', '8');

drop table if exists users_communities;
create table users_communities (
	user_id BIGINT UNSIGNED not null,
	community_id BIGINT UNSIGNED not null,
	created_at DATETIME default now(),

    primary key(user_id, community_id),
	foreign key (user_id) references users(id),
	foreign key (community_id) references communities(id)
);

INSERT INTO `users_communities` (`user_id`, `community_id`, `created_at`)
VALUES
('1', '1701', '2017-01-31 09:47:11'),
('2', '1702', '2001-06-01 12:00:40'),
('3', '1703', '1978-07-29 21:05:34'),
('4', '1704', '1974-12-05 09:19:13'),
('5', '1705', '2015-09-19 12:32:51'),
('6', '1706', '2018-11-11 09:52:48'),
('7', '1707', '2014-06-24 05:28:49'),
('8', '1708', '2014-04-06 01:41:34'),
('9', '1709', '2019-12-21 16:15:25'),
('10', '1710', '1989-06-15 09:33:47'),
('11', '1711', '1987-02-25 11:35:54'),
('12', '1712', '1972-09-02 02:08:39'),
('13', '1713', '2012-11-24 05:27:50'),
('14', '1714', '1990-11-11 19:50:52'),
('15', '1715', '2004-04-03 12:46:52');

drop table if exists media_types;
create table media_types (
	id SERIAL primary key,
	name VARCHAR(255)
);

INSERT INTO `media_types` (`id`, `name`)
VALUES
('1', 'Doloremque dolores quidem aliquam vitae consequatur. Minima omnis culpa velit eaque cumque cum sapiente. Aut atque qui voluptates.'),
('2', 'Autem in reiciendis maxime hic culpa. Labore est et vitae perspiciatis voluptatem cumque.'),
('3', 'Qui voluptatem labore perferendis reprehenderit tempore. Ipsam sunt aut facere facilis.'),
('4', 'Illo rerum aliquam id. Quia ipsa aperiam est.'),
('5', 'Eos est doloremque cum veniam deserunt.'),
('6', 'Sint rerum sint aperiam qui excepturi est iste.'),
('7', 'Veritatis blanditiis dolorem enim est possimus neque.'),
('8', 'Culpa et sint optio qui sit et fuga voluptatibus.'),
('9', 'At et deserunt accusamus temporibus dolores harum.'),
('10', 'Non accusantium voluptatum aspernatur et et velit saepe.'),
('11', 'Consequatur laudantium soluta nemo hic. '),
('12', 'Dolore itaque vitae occaecati.'),
('13', 'Vitae deleniti inventore eum aut et eligendi.'),
('14', 'In blanditiis est expedita ipsam corrupti tempora sit reprehenderit.'),
('15', 'Molestiae voluptatem sequi ex ipsam cumque sequi similique.');

drop table if exists media;
create table media (
	id SERIAL primary key,
	media_type_id BIGINT UNSIGNED not null,
	user_id BIGINT UNSIGNED not null,
	body text,
	filename varchar(255),
	-- filename2 blob,
	`size` int,
	metadata JSON,
	created_at DATETIME default now(),
	updated_at DATETIME ON UPDATE current_timestamp,

	index (user_id),
	foreign key (user_id) references users(id),
	foreign key (media_type_id) references media_types(id)
);

INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`)
VALUES
('1', '1', '1', 'Doloremque dolores quidem aliquam vitae consequatur. Minima omnis culpa velit eaque cumque cum sapiente. Aut atque qui voluptates.', 'dolorum', 379327935, NULL, '2017-08-19 19:45:51', '1994-12-05 03:22:25'),
('2', '2', '2', 'Autem in reiciendis maxime hic culpa. Labore est et vitae perspiciatis voluptatem cumque. Modi repellendus natus ad enim animi et. Ipsum dolor ex porro nesciunt. Vitae ullam sit et velit.', 'recusandae', 139687758, NULL, '1977-01-09 11:37:26', '2003-05-18 01:41:27'),
('3', '3', '3', 'Qui voluptatem labore perferendis reprehenderit tempore. Ipsam sunt aut facere facilis. Minima dolore sed debitis consequatur sit et. Sit provident reiciendis sint voluptatem saepe est.', 'tenetur', 1121712, NULL, '2011-06-09 20:16:22', '1991-06-17 20:04:40'),
('4', '4', '4', 'Illo rerum aliquam id. Quia ipsa aperiam est. Eos est neque assumenda eos qui id ut est. Sequi adipisci ut sint vel.', 'illum', 77244, NULL, '1980-03-18 23:05:26', '2001-01-20 01:13:26'),
('5', '5', '5', 'Eos est doloremque cum veniam deserunt. Blanditiis debitis quisquam explicabo quas. Voluptatibus ullam nemo dolor natus non aut veritatis. Et aut dolorum dolorum non.', 'voluptas', 0, NULL, '1991-11-30 00:46:19', '2007-10-19 21:34:56'),
('6', '6', '6', 'Sint rerum sint aperiam qui excepturi est iste. Reprehenderit ipsa sequi nesciunt odio illum. Et ipsam dolor recusandae accusantium modi eius. Quia impedit aperiam dolorem quis aut debitis modi.', 'voluptatem', 49086, NULL, '1982-04-13 09:12:32', '1978-09-10 06:13:07'),
('7', '7', '7', 'Veritatis blanditiis dolorem enim est possimus neque. Et iusto assumenda totam animi. Mollitia aut consequatur ab voluptatum. Aut non eum et. Et vel voluptas voluptates dolores nobis omnis.', 'molestiae', 65096, NULL, '1994-12-09 18:19:21', '1974-12-04 06:25:37'),
('8', '8', '8', 'Culpa et sint optio qui sit et fuga voluptatibus. Eligendi dolores molestias vel vitae dolorem occaecati.', 'temporibus', 7, NULL, '1989-06-10 08:20:09', '2008-07-12 18:39:35'),
('9', '9', '9', 'At et deserunt accusamus temporibus dolores harum. Dolor optio eveniet vero et tempore accusantium explicabo. Fuga qui est et aut expedita. Et ipsam et quis et velit modi enim.', 'quibusdam', 0, NULL, '2012-12-07 00:12:12', '1990-03-24 15:16:42'),
('10', '10', '10', 'Non accusantium voluptatum aspernatur et et velit saepe. Harum ea corrupti commodi et ut. Quis id voluptate aperiam ratione.', 'dolore', 20, NULL, '2009-09-03 08:39:22', '1971-01-28 10:15:33'),
('11', '11', '11', 'Consequatur laudantium soluta nemo hic. Dolorem et porro enim laboriosam laudantium. Est optio aliquam asperiores dolor enim. Iste quis sed molestiae dolore.', 'ea', 9312150, NULL, '2009-07-27 05:52:16', '1994-01-31 18:09:10'),
('12', '12', '12', 'Dolore itaque vitae occaecati. Numquam quo magnam repudiandae reiciendis. Quia magni est sed nemo nihil numquam deserunt voluptas.', 'dolor', 21536929, NULL, '1991-10-25 12:33:37', '1996-07-08 20:05:35'),
('13', '13', '13', 'Vitae deleniti inventore eum aut et eligendi. Fugiat dolorum libero dolore in ullam odio eos. Eligendi totam dolor doloribus enim modi maiores. Accusantium quos maiores voluptatibus illum quasi. Quod qui nesciunt iste sed nam.', 'et', 9, NULL, '1982-10-13 19:08:20', '2001-02-28 15:46:51'),
('14', '14', '14', 'In blanditiis est expedita ipsam corrupti tempora sit reprehenderit. Cum ullam autem officiis quis modi adipisci tempore. Placeat distinctio iusto voluptas.', 'a', 41265047, NULL, '1978-09-07 06:04:52', '1981-02-02 15:18:27'),
('15', '15', '15', 'Molestiae voluptatem sequi ex ipsam cumque sequi similique. Distinctio et ratione sint. Assumenda vitae sed qui. Ut quo aut sint quo omnis.', 'non', 22, NULL, '1992-08-31 15:58:20', '1992-03-05 23:05:23');

drop table if exists likes;
create table likes (
	id SERIAL primary key,
	user_id BIGINT UNSIGNED not null,
	media_id BIGINT UNSIGNED not null,
	created_at DATETIME default now()

	-- index (user_id),
	-- foreign key (user_id) references users(id),
);

INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`)
VALUES
('1', '1', '1', '1972-06-22 10:31:25'),
('2', '2', '2', '1992-09-09 14:35:13'),
('3', '3', '3', '1971-09-22 01:09:41'),
('4', '4', '4', '2004-11-14 23:01:18'),
('5', '5', '5', '2019-06-15 05:15:46'),
('6', '6', '6', '2019-11-19 22:33:23'),
('7', '7', '7', '2007-06-30 20:29:31'),
('8', '8', '8', '1995-07-31 10:11:30'),
('9', '9', '9', '2008-05-28 16:33:08'),
('10', '10', '10', '1996-07-07 22:48:01'),
('11', '11', '11', '1999-01-11 13:00:39'),
('12', '12', '12', '1994-01-31 19:42:56'),
('13', '13', '13', '2019-01-16 02:33:24'),
('14', '14', '14', '2017-05-31 09:21:27'),
('15', '15', '15', '1977-02-02 05:52:21');

drop table if exists photo_albums;
create table photo_albums (
	id SERIAL primary key,
	name varchar(255),
	user_id BIGINT UNSIGNED not null,
	created_at DATETIME default now(),

	foreign key (user_id) references users(id)
);

INSERT INTO `photo_albums` (`id`, `name`, `user_id`, `created_at`)
VALUES
('1', 'aliquid', '1', '1992-02-23 02:52:50'),
('2', 'dolorem', '2', '1995-10-10 15:10:58'),
('3', 'itaque', '3', '1990-10-01 09:45:58'),
('4', 'doloribus', '4', '1979-11-04 08:06:25'),
('5', 'voluptas', '5', '2009-08-24 09:54:39'),
('6', 'ratione', '6', '1985-08-17 10:42:14'),
('7', 'pariatur', '7', '1977-09-19 04:56:05'),
('8', 'expedita', '8', '1985-09-08 08:04:47'),
('9', 'officiis', '9', '2005-09-06 22:18:16'),
('10', 'officiis', '10', '2019-12-13 03:08:33'),
('11', 'laudantium', '11', '1996-11-10 18:41:30'),
('12', 'libero', '12', '2009-10-19 10:14:04'),
('13', 'rerum', '13', '1998-07-09 13:39:31'),
('14', 'quia', '14', '2004-04-03 04:26:44'),
('15', 'deserunt', '15', '2016-07-28 05:25:23');

drop table if exists photos;
create table photos (
	id SERIAL primary key,
	album_id BIGINT UNSIGNED null,
	media_id BIGINT UNSIGNED not null,

	foreign key (album_id) references photo_albums(id),
	foreign key (media_id) references media(id)
);

INSERT INTO `photos` (`id`, `album_id`, `media_id`)
VALUES
('1', '1', '1'),
('2', '2', '2'),
('3', '3', '3'),
('4', '4', '4'),
('5', '5', '5'),
('6', '6', '6'),
('7', '7', '7'),
('8', '8', '8'),
('9', '9', '9'),
('10', '10', '10'),
('11', '11', '11'),
('12', '12', '12'),
('13', '13', '13'),
('14', '14', '14'),
('15', '15', '15');

-- homework 3

drop table if exists play_lists;
create table play_lists (
	id SERIAL primary key,
	name varchar(255),
	user_id BIGINT UNSIGNED not null,
	created_at DATETIME default now(),

	foreign key (user_id) references users(id)
);
INSERT INTO `play_lists` (`id`, `name`, `user_id`, `created_at`)
VALUES
('1', 'id', '1', '2011-09-03 05:13:36'),
('2', 'aut', '2', '2000-01-15 18:20:32'),
('3', 'id', '3', '1997-10-20 03:07:48'),
('4', 'et', '4', '2017-01-25 06:07:59'),
('5', 'architecto', '5', '1996-03-03 17:09:47'),
('6', 'aut', '6', '2010-06-24 06:54:46'),
('7', 'quia', '7', '2008-05-15 05:18:38'),
('8', 'asperiores', '8', '1974-04-10 01:18:11'),
('9', 'minus', '9', '2000-12-01 04:27:28'),
('10', 'maxime', '10', '1974-03-21 17:50:25'),
('11', 'hic', '11', '1984-10-13 14:05:21'),
('12', 'tempore', '12', '1999-11-28 01:31:19'),
('13', 'libero', '13', '1983-01-17 02:25:29'),
('14', 'sapiente', '14', '2019-03-24 23:58:06'),
('15', 'exercitationem', '15', '1982-02-19 05:23:47');

drop table if exists track;
create table track (
	id SERIAL primary key,
	play_lists_id BIGINT UNSIGNED null,
	media_id BIGINT UNSIGNED not null,
	shared_time BIGINT UNSIGNED null,
	download_at DATETIME default now(),

	foreign key (play_lists_id) references play_lists(id),
	foreign key (media_id) references media(id)
);

INSERT INTO `track` (`id`, `play_lists_id`, `media_id`, `shared_time`, `download_at`)
VALUES
('1', '1', '1', NULL, '2019-04-04 01:49:25'),
('2', '2', '2', NULL, '2012-09-07 15:39:13'),
('3', '3', '3', NULL, '1986-09-30 06:07:14'),
('4', '4', '4', NULL, '2012-07-25 05:15:24'),
('5', '5', '5', NULL, '1995-12-28 05:37:57'),
('6', '6', '6', NULL, '2001-09-11 00:53:04'),
('7', '7', '7', NULL, '1991-03-18 04:09:56'),
('8', '8', '8', NULL, '1999-04-13 10:05:49'),
('9', '9', '9', NULL, '1984-11-20 09:39:12'),
('10', '10', '10', NULL, '1971-04-27 00:21:29'),
('11', '11', '11', NULL, '2018-11-12 07:41:15'),
('12', '12', '12', NULL, '1991-04-01 22:42:29'),
('13', '13', '13', NULL, '1990-05-22 10:37:39'),
('14', '14', '14', NULL, '1988-01-31 09:06:07'),
('15', '15', '15', NULL, '2002-09-05 17:31:19');

drop table if exists graffitis;
create table graffitis (
	id SERIAL primary key,
	user_id BIGINT UNSIGNED not null,
	album_id BIGINT UNSIGNED null,
	media_id BIGINT UNSIGNED not null,
	created_at DATETIME default now(),

	index (user_id),
	foreign key (album_id) references photo_albums(id),
	foreign key (media_id) references media(id)
);

INSERT INTO `graffitis` (`id`, `user_id`, `album_id`, `media_id`, `created_at`)
VALUES
('1', '1', '1', '1', '2016-06-08 22:15:03'),
('2', '2', '2', '2', '1997-11-21 11:24:57'),
('3', '3', '3', '3', '1999-04-12 06:58:15'),
('4', '4', '4', '4', '2013-10-31 22:49:50'),
('5', '5', '5', '5', '2011-12-18 22:43:52'),
('6', '6', '6', '6', '2015-04-16 11:19:48'),
('7', '7', '7', '7', '2016-05-01 11:30:09'),
('8', '8', '8', '8', '1980-01-26 05:20:08'),
('9', '9', '9', '9', '1990-01-16 17:35:00'),
('10', '10', '10', '10', '1996-04-12 00:48:44'),
('11', '11', '11', '11', '2002-02-17 21:46:56'),
('12', '12', '12', '12', '2015-04-21 11:57:10'),
('13', '13', '13', '13', '2008-05-31 12:57:45'),
('14', '14', '14', '14', '1979-08-14 23:39:51'),
('15', '15', '15', '15', '2004-03-30 15:26:06');
