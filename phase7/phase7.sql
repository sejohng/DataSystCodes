-- 1. Retrieve the names of all products which have sold a total quantity greater than 30.
SELECT P_NAME FROM PRODUCT
JOIN LINEITEM ON PRODUCT.P_ID=LINEITEM.L_PRODUCTID
GROUP BY P_NAME
HAVING SUM(L_QUANTITY) > 30;
-- 2. Retrieve the names of all customers who were referred by someone who was referred by the customer with ID C15. Ex. Return CustomerA who was referred by CustomerB where CustomerB was referred by customer C15
SELECT CUSTOMER.C_NAME FROM CUSTOMER
JOIN CUSTOMER CUST1 ON CUSTOMER.C_REFERRERID = CUST1.C_ID
JOIN CUSTOMER CUST2 ON CUST1.C_REFERRERID = CUST2.C_ID
WHERE CUST2.C_ID = 'C15';
-- 3. Find the customer name's that have ordered the least expensive product
SELECT DISTINCT C_NAME FROM CUSTOMER
WHERE C_ID IN(
SELECT O_CUSTID FROM ORDERS WHERE O_ORDERNUMBER IN(
SELECT L_ORDERNUMBER FROM LINEITEM WHERE L_PRODUCTID IN(
SELECT P_ID FROM PRODUCT WHERE P_PRICE = (
SELECT MIN(P_PRICE) FROM PRODUCT))));
-- 4. Find the avg review rating for each product that has received a review (do no include products that have not received a review).
SELECT R_PRODUCTID, AVG(R_RATING)
FROM REVIEW
GROUP BY R_PRODUCTID;
-- 5. List the total cost for each order (quantity * price for all products for each order ID) where the order cost is greater than 1000. Note: shipping cost was also a derived attribute - we will discuss how to build a function that can add that into the cost when we get to PL/SQL in Ch 5. 
SELECT L_ORDERNUMBER, SUM(P_PRICE * L_QUANTITY) AS TOTALCOST
FROM LINEITEM
JOIN PRODUCT ON LINEITEM.L_PRODUCTID = PRODUCT.P_ID
GROUP BY L_ORDERNUMBER
HAVING SUM(P_PRICE * L_QUANTITY) > 1000
ORDER BY TOTALCOST ASC;
-- 6. List customers that have spent more than $1000 on orders
SELECT C_NAME FROM CUSTOMER
WHERE C_ID IN(SELECT O_CUSTID FROM LINEITEM
JOIN PRODUCT ON LINEITEM.L_PRODUCTID = PRODUCT.P_ID
JOIN ORDERS ON LINEITEM.L_ORDERNUMBER = ORDERS.O_ORDERNUMBER
GROUP BY O_CUSTID
HAVING SUM(P_PRICE * L_QUANTITY)>1000);
-- 7. Find the total number of orders placed by customers who were referred by Margot Robbie.
SELECT COUNT(O_ORDERNUMBER) FROM ORDERS
WHERE O_CUSTID IN(SELECT C_ID FROM CUSTOMER WHERE C_REFERRERID = (
SELECT C_ID FROM CUSTOMER WHERE C_NAME='Margot Robbie'));
--8. This problem requires (no points if you don't) you to use the regular expression function REGEXP_LIKE that we discussed in class.
-- Find all customer names where both the first name and last name begin with a vowel
SELECT C_NAME FROM CUSTOMER WHERE REGEXP_LIKE(C_Name, '^[AEIOU].* [AEIOU]');