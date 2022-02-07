-- Ceate function to get the most recent price
drop FUNCTION top_price
delimiter //
 CREATE FUNCTION get_new_price(
  shipto VARCHAR(20), 
  product VARCHAR(20), 
  effective_date DATE
) RETURNS FLOAT 
DETERMINISTIC 
BEGIN 
	DECLARE price FLOAT;
	SELECT 
		NEW_PRICE INTO price 
	FROM 
		PRICING_EDIT_HISTORY 
	WHERE SHIP_TO = shipto 
	AND product_code = product 
	AND EFFECTIVE_DATE_TXT <= effective_date 
	ORDER BY 
		EFFECTIVE_DATE_TXT DESC 
	LIMIT 1;
RETURN price;
END // 
delimiter ;