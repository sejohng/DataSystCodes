
--1. Find the names of all customers who have at least one address
SELECT C_NAME FROM CUSTOMER
WHERE C_ID IN (SELECT A_CUSTID FROM ADDRESS);
--2. For each product id, list the total quantity sold
SELECT L_PRODUCTID, SUM(L_QUANTITY) AS TOTALSOLD FROM LINEITEM
GROUP BY L_PRODUCTID
ORDER BY TOTALSOLD DESC;
--3. Find the names of all products that do not have any reviews
SELECT P_NAME FROM PRODUCT 
LEFT JOIN REVIEW ON PRODUCT.P_ID=REVIEW.R_PRODUCTID
WHERE REVIEW.R_PRODUCTID IS NULL
ORDER BY PRODUCT.P_ID ASC;
--4. Find the names of all customers who were referred by 'Margot Robbie'. Note: You must use the string ‘Margot Robbie’ and not hardcode the ID.
SELECT C_NAME FROM CUSTOMER
WHERE C_REFERRERID = (
    SELECT C_ID FROM CUSTOMER
    WHERE C_NAME = 'Margot Robbie'
);
