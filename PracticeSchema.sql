/*
James Wagner
CSC 4125/5125 Fall 2023
Practice Schema
*/

DROP TABLE Orders2;
DROP TABLE Item2;
DROP TABLE Supplier2;
DROP TABLE Customer2;

CREATE TABLE Customer2(
	C_ID NUMBER,
	C_Name VARCHAR(20),
	C_City VARCHAR(25),
	C_Phone CHAR(12),
	CONSTRAINT Cusomter2PK PRIMARY KEY (C_ID)
);

CREATE TABLE Supplier2(
	S_ID NUMBER,
	S_Name VARCHAR(20),
	S_City VARCHAR(25),
	S_Phone CHAR(12),
	CONSTRAINT Supplier2PK PRIMARY KEY (S_ID)
);

CREATE TABLE Item2(
	I_ID NUMBER,
	I_Name VARCHAR(20),
	I_Color VARCHAR(25),
	I_Size NUMBER(3),
	I_Price NUMBER(6,2),
	CONSTRAINT Part2PK PRIMARY KEY (I_ID)
);

CREATE TABLE Orders2(
	O_ID NUMBER,
	O_CustID NUMBER,
	O_SuppID NUMBER,
	O_ItemID NUMBER,
	O_Date DATE,
	O_Shipmode VARCHAR(10),	
	CONSTRAINT Order2PK PRIMARY KEY (O_ID),
	CONSTRAINT Cust2FK FOREIGN KEY (O_CustID) REFERENCES Customer2(C_ID),
	CONSTRAINT Supp2FK FOREIGN KEY (O_SuppID) REFERENCES Supplier2(S_ID),
	CONSTRAINT Part2FK FOREIGN KEY (O_ItemID) REFERENCES Item2(I_ID)	
);
