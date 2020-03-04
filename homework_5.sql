-- добавляем колонки
alter table vk.users add column created_at varchar(100) ;
alter table vk.users add column updated_at varchar(100) ;

-- заполняем текущей датой
update users SET created_at = now(), updated_at = now();

-- конвертируем str в datetime
ALTER TABLE vk.users MODIFY COLUMN created_at DATETIME;
ALTER TABLE vk.users MODIFY COLUMN updated_at DATETIME;

--остальные задания залью позже спасибо!
