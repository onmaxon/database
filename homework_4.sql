-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
select DISTINCT firstname from users order by firstname;

-- Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
alter table vk.profiles add column is_active bit default true;

update profiles set is_active=false where (birtday + interval 18 year)> now();

-- молодняк
select * from profiles where is_active=false order by birtday;

-- совершеннолетние
select * from profiles where is_active=true order by birtday;


-- Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
-- добавим флаг
alter table vk.messages add column is_deleted bit default false;

-- проставим сообщениям статус - сообщения из будушего ( в базе имеется несколько таких )
update messages set is_deleted = true where created_at > now();

-- посмотрим что это за сообщения
select * from messages where is_deleted=true order by created_at;

