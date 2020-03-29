--  Общее количество заказов
SELECT count(id) from orders;
-- Количество зарегистрированных пользователей
SELECT count(id) from users;
-- Количество покупок пользователями
SELECT COUNT(*) as count_of_buy FROM orders o2
WHERE user_id  IN (SELECT user_id FROM profiles)
GROUP BY user_id ;
