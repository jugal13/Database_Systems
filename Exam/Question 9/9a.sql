CREATE TABLE CUSTOMER(
  Cno INT,
  Cname VARCHAR(50),
  Ccity VARCHAR(50),
  PRIMARY KEY(Cno)
);
 
CREATE TABLE ORDER1(
  Ono INT,
  Odate DATE,
  Ocno INT,
  Oamt INT, 
  PRIMARY KEY(Ono),
  FOREIGN KEY(Ocno) REFERENCES CUSTOMER(Cno) ON DELETE CASCADE
);
 
CREATE TABLE ITEM(
  Ino INT,
  Uprice INT, 
  PRIMARY KEY(Ino)
);
 
CREATE TABLE ORDER_ITEM(
  Iono INT,
  Oino  INT,
  Qty INT, 
  PRIMARY KEY(Iono,Oino),
  FOREIGN KEY(Iono) REFERENCES ORDER1(Ono) ON DELETE CASCADE, 
  FOREIGN KEY(Oino) REFERENCES ITEM(Ino) ON DELETE CASCADE
);
 
CREATE TABLE SHIPMENT(
  Sono INT,
  Shipdate DATE,
  PRIMARY KEY(Sono), 
  FOREIGN KEY(Sono) REFERENCES ORDER1(Ono) ON DELETE CASCADE, 
);

INSERT INTO CUSTOMER VALUES (1,'Archie','Bangalore');
INSERT INTO CUSTOMER VALUES (2,'Veronica','Bangalore');
INSERT INTO CUSTOMER VALUES (3,'Betty','Mysore');
INSERT INTO CUSTOMER VALUES (4,'Jughead','Bangalore');
INSERT INTO CUSTOMER VALUES (5,'Cheryl','Mysore');
INSERT INTO CUSTOMER VALUES (6,'Jason','Mangalore');
 
INSERT INTO ORDER1 VALUES (1, '2001-06-16',1,1000);
INSERT INTO ORDER1 VALUES (2, '2003-06-16',1,2000);
INSERT INTO ORDER1 VALUES (3, '2003-06-16',3,3000);
INSERT INTO ORDER1 VALUES (4, '2005-06-16',4,4000);
INSERT INTO ORDER1 VALUES (5, '2006-06-17',5,5000);
 
INSERT INTO ITEM VALUES(1,100);
INSERT INTO ITEM VALUES(2,200);
INSERT INTO ITEM VALUES(3,300);
INSERT INTO ITEM VALUES(4,400);
INSERT INTO ITEM VALUES(10,500);
 
INSERT INTO ORDER_ITEM VALUES(1,1,2);
INSERT INTO ORDER_ITEM VALUES(1,2,1);
INSERT INTO ORDER_ITEM VALUES(2,3,2);
INSERT INTO ORDER_ITEM VALUES(3,4,3);
INSERT INTO ORDER_ITEM VALUES(4,3,1);
INSERT INTO ORDER_ITEM VALUES(5,2,1);
 
INSERT INTO SHIPMENT VALUES(1,1,'2003-01-16');
INSERT INTO SHIPMENT VALUES(2,1,'2003-02-16');
INSERT INTO SHIPMENT VALUES(3,2,'2015-03-16');
INSERT INTO SHIPMENT VALUES(4,3,'2005-01-16');
INSERT INTO SHIPMENT VALUES(5,4,'2006-05-16');

-- List the customer names who have placed more than 2 orders

SELECT Cname FROM CUSTOMER WHERE (SELECT count(Ono) FROM ORDER1 WHERE Cno=Ocno)>=2;

-- Find the total order amount for each day.

SELECT Odate,SUM(Oamt) FROM ORDER1 GROUP BY Odate;

-- List customer details who has the largest order amount.

SELECT Cno,Cname,Ccity FROM CUSTOMER,ORDER1 WHERE Cno=Ocno AND Oamt IN(SELECT max(Oamt) FROM ORDER1);
-- or
SELECT * FROM CUSTOMER WHERE Cno IN (SELECT Ocno FROM ORDER1 WHERE Oamt=(SELECT max(Oamt) FROM ORDER1));
