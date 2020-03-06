use vk;

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT from_user_id as sender_id, COUNT(*) as total_msg FROM messages WHERE to_user_id=1
group by from_user_id;


--     Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT COUNT(*) as count_likes FROM likes 
WHERE media_id IN (SELECT user_id FROM profiles where TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10) 
GROUP BY media_id;


--     Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT gender FROM (
	SELECT "Male" as gender, COUNT(*) as total FROM likes WHERE user_id IN (SELECT user_id FROM profiles as p WHERE gender='M' )
	UNION
	SELECT "Female" as gender, COUNT(*) as total FROM likes WHERE user_id IN (SELECT user_id FROM profiles as p WHERE gender='F')
) as my_sort
ORDER BY total DESC
LIMIT 1