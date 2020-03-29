use my_shop;

-- Все заказы пользователей
CREATE OR REPLACE VIEW
    order_by_users
as
select name, description, total, price
from orders_products op, products p
where op.product_id = p.id;

-- Заказы пользователя с id = 1
CREATE OR REPLACE VIEW
    users_pick
as
select order_id , user_id, product_id , firstname
from orders_products op, orders o
	inner join users u ON o.user_id = u.id
where op.order_id = o.id and o.user_id = 1;


select * from order_by_user;

select * from users_pick;
