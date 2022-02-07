-- create a stored procedure to check inventory 
delimiter //
CREATE PROCEDURE check_inventory (IN item_id VARCHAR(20),
OUT qoh FLOAT)
BEGIN 
SELECT quantity INTO qoh
From inventory
WHERE id = item_id;
END //
delimiter ;
-- call/test procedure
set @i = 0;
call check_inventory('Zythane6045D',@i);
select @i;
-- create trigger to automaticlly update inventory when initiate an order
-- if lack of inventory will return an error massage 
delimiter //
CREATE TRIGGER update_inventory_tgr
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
   DECLARE old_inventory float;
   CALL check_inventory(NEW.item_id, old_inventory);
   IF old_inventory < NEW.quantity THEN
     SIGNAL SQLSTATE "45000"
     SET MESSAGE_TEXT = "Not Enough Inventory";
   ELSE 
     UPDATE inventory SET inventory.quantity = old_inventory - new.quantity
     where inventory.id = NEW.item_id;
   END IF;
END //
delimiter ;
