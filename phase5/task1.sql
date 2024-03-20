--1. [4 pts] Find all products (their names) with a price greater than $100.
SELECT P_NAME
FROM PRODUCT
WHERE P_PRICE >100;
--2. [4 pts] Find all Customers who were not referred by another customer.
SELECT C_ID,C_NAME
FROM CUSTOMER
WHERE C_REFERRERID IS NULL;
--3. [4 pts] Find the average rating for all reviews.
SELECT AVG(R_RATING)
FROM REVIEW;
--4. [4 pts] Find all the “Ticket�?s from product and sort the output by the price (any direction). Hint: remember the LIKE operator. 
SELECT P_NAME,P_PRICE
FROM PRODUCT
WHERE P_NAME LIKE '%Ticket%'
ORDER BY P_PRICE DESC;  
--5. [4 pts] Find the minimum and maximum date of births amongst all customer. Use only a single query that returns a single row (ex. 01-JAN-70, 01-JAN-99).
SELECT MIN(C_DATEOFBIRTH)AS MINDOB,MAX(C_DATEOFBIRTH)AS MAXDOB 
FROM CUSTOMER;
--6. [4 pts] Find all reviews that contain the word "Great". Make sure to remove case sensitivity Hint: remember the LIKE operator.
SELECT * FROM REVIEW 
WHERE UPPER(R_TEXT) LIKE '%GREAT%';
--7. [4 pts] Find the number of reviews for P05 with a rating between 3 and 5. 
SELECT COUNT(*) FROM REVIEW 
WHERE R_PRODUCTID='P05' AND R_RATING BETWEEN 3 AND 5;
--8. [7 pts] Find the name of the product with the highest price. Do not hardcode any prices or other values – you must use SQL without assuming you know the current database snapshot.
SELECT P_NAME FROM PRODUCT
WHERE P_PRICE = (SELECT MAX(P_PRICE) FROM PRODUCT);
--9. [7 pts] Find the product names with a price greater than the average overall price of products + 25% (i.e., greater than 1.25 * average price). Do not hardcode any prices or other values – you must use SQL without assuming you know the current database snapshot.
SELECT P_NAME FROM PRODUCT
WHERE P_PRICE > 1.25*(SELECT AVG(P_PRICE) FROM PRODUCT);