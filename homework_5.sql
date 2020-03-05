-- добавляем колонки
alter table vk.users add column created_at varchar(100) ;
alter table vk.users add column updated_at varchar(100) ;

-- заполняем текущей датой
update users SET created_at = now(), updated_at = now();

-- конвертируем str в datetime
ALTER TABLE vk.users MODIFY COLUMN created_at DATETIME;
ALTER TABLE vk.users MODIFY COLUMN updated_at DATETIME;

--остальные задания залью позже спасибо!
use shop;

-- проверяем ту ли базу мы используем
select database ();

-- выводилим в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
select value from storehouses_products order by value=0, value;

-- извлекаем пользователей родившихся в августе и мае
select name, birthday_at, case
when DATE_FORMAT(birthday_at, '%m') = 05 then 'may'
when DATE_FORMAT(birthday_at, '%m') = 08 then 'august'
end as mounth
from users
where DATE_FORMAT(birthday_at,'%m') = 05 or DATE_FORMAT(birthday_at,'%m') = 08;

-- Из таблицы catalogs извлекаем записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
select * from catalogs where id in (5, 1, 2) order by id=2, id desc;

-- Практическое задание теме “Агрегация данных”

-- Подсчитайте средний возраст пользователей в таблице users
select round(avg((to_days(now()) - to_days(birthday_at)) / 365.25), 0) as average_age from users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
select dayname(concat(year(now()), '-', substring(birthday_at, 6, 10))) as week_day,
count(dayname(concat(year(now()), '-', substring(birthday_at, 6, 10)))) as count_of_birth
from users group by week_day;

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
select id from storehouses;

SELECT round(exp(sum(log(id))), 0) as factorial from storehouses;
