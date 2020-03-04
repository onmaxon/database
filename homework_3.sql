-- homework 3

drop table if exists play_lists;
create table play_lists (
	id SERIAL primary key,
	name varchar(255),
	user_id BIGINT UNSIGNED not null,
	created_at DATETIME default now(),
	
	foreign key (user_id) references users(id)
);

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
	