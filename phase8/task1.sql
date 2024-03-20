--Shijun Jiang--CSCI 4125 Fall 2023
--Phase8 task1


CREATE OR REPLACE TRIGGER Task1
BEFORE INSERT ON LINEITEM
FOR EACH ROW
DECLARE
    product_id CHAR(3);
    inventory NUMBER;
    
BEGIN
    product_id := :NEW.L_ProductID;
    SELECT Inventory INTO inventory
    FROM Product
    WHERE P_ID = product_id;
    
    IF inventory = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Product #' || product_id || ' is out of stock!');
    ELSIF inventory - :NEW.L_Quantity < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Product #' || product_id || ' does not have enough stock for this order!');
    ELSE
        UPDATE Product
        SET Inventory = inventory - :NEW.L_Quantity
        WHERE P_ID = product_id;
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product #' || product_id || ' not found!');
END;
/
