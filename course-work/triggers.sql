-- Триггер реагирующий на изменение цены в таблице products и делающий скидку 20%
use my_shop;

DELIMITER //
CREATE TRIGGER sale_price
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    SET NEW.price = NEW.price - (NEW.price * 0.2);
END //
DELIMITER
