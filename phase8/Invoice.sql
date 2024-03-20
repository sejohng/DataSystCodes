--Shijun Jiang
--CSCI 4125 Fall 2023
--Phase8 task2

CREATE OR REPLACE PROCEDURE Invoice(
    -- Accept two arguments: a customer ID and an order date. 
    customer_id IN CUSTOMER.C_ID%TYPE,
    order_date IN ORDERS.O_OrderDate%TYPE
) AS
    customer_name CUSTOMER.C_Name%TYPE;
    total_product_cost DECIMAL(8, 2) := 0;
    shipping_cost DECIMAL(8, 2) := 0;
    order_exists NUMBER := 0;
BEGIN
    SELECT C_Name INTO customer_name
    FROM CUSTOMER
    WHERE C_ID = customer_id;
    
    DBMS_OUTPUT.PUT_LINE('');

    -- If the customer has not placed an order on the given date, print a message “No invoice to generate” and return.
    SELECT COUNT(*) INTO order_exists
    FROM ORDERS
    WHERE O_CustID = customer_id AND O_OrderDate = order_date;

    IF order_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No invoice to generate');
        RETURN;
    END IF;

    -- Provide an invoice header that includes: order date, customer ID, and customer name
    
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(order_date, 'DD-MON-YY') || ' invoice for ' || customer_id || ': ' || customer_name);
    DBMS_OUTPUT.PUT_LINE(RPAD('Product', 25) || RPAD('Quantity', 10) || LPAD('Price/Unit', 10) || LPAD('Total', 10)) ;
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');

    -- cursor
    FOR order_row IN (
        SELECT L.L_ProductID, P.P_Name, L.L_Quantity, P.P_Price
        FROM LINEITEM L
        JOIN PRODUCT P ON L.L_ProductID = P.P_ID
        WHERE L.L_OrderNumber IN (
            SELECT O_OrderNumber
            FROM ORDERS
            WHERE O_CustID = customer_id AND O_OrderDate = order_date
        )
    ) LOOP
        -- Calculate total line price
        DECLARE
            line_price DECIMAL(8, 2);
        BEGIN
            line_price := order_row.L_Quantity * order_row.P_Price;
            total_product_cost := total_product_cost + line_price;

            -- List all products in the order, the quantity, the price/unit, and the total line price (i.e., quantity * price/unit).

            DBMS_OUTPUT.PUT_LINE(
            RPAD(order_row.P_Name, 25) || RPAD(TO_CHAR(order_row.L_Quantity, '9999'), 10) || '  $' || LPAD(TO_CHAR(order_row.P_Price, '999999.99'), 10) || '  $' || LPAD(TO_CHAR(line_price, '999999.99'), 10)
        );

        END;
    END LOOP;

    -- Display the total cost for all products, the shipping cost ($0 if total product cost >= $35, else $10), and the total cost (i.e., total product cost plus shipping cost).
    IF total_product_cost >= 35 THEN
        shipping_cost := 0;
    ELSE
        shipping_cost := 10;
    END IF;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(RPAD('Total Product Cost:', 25) || ' $' || LPAD(TO_CHAR(total_product_cost, '999999.99'), 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('Shipping Cost:', 25) || ' $' || LPAD(TO_CHAR(shipping_cost, '999999.99'), 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('Total Due:', 25) || ' $' || LPAD(TO_CHAR(total_product_cost + shipping_cost, '999999.99'), 10));
    DBMS_OUTPUT.PUT_LINE('');
    
END;
/