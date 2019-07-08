CREATE TABLE EMPLOYEE (
  Fname VARCHAR(10) NOT NULL,
  Lname VARCHAR(15) NOT NULL,
  Ssn VARCHAR(9) PRIMARY KEY,
  Bdate DATE,
  Address VARCHAR(40),
  Sex CHAR,
  Salary INT,
  Super_ssn VARCHAR(9),
  Dno INT 
);

CREATE TABLE DEPARTMENT (
  Dname VARCHAR(15) NOT NULL,
  Dnumber INT PRIMARY KEY,
  Mgr_ssn VARCHAR(9) NOT NULL,
  Mgr_start_date DATE,
  FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn),
);

CREATE TABLE DEPENDENT (
  Dname VARCHAR(15),
  Essn VARCHAR(9),
  PRIMARY KEY(Essn, Dname),
  FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

INSERT INTO EMPLOYEE VALUES('John','Smith', 123456789, '09-JAN-65', '731 Fondren, Houston, TX', 'M', 30000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Franklin','Wong', 333445555, '08-DEC-55', '638 Voss, Houston, TX', 'M', 40000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Alicia','Zelaya', 999887777, '19-JAN-68', '3321 Castle, Spring, TX', 'F', 25000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Jennifer','Wallace', 987654321, '01-JAN-65', '731 Fondren, Houston, TX', 'F', 43000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Ramesh','Narayan', 666884444, '01-JAN-65', '731 Fondren, Houston, TX', 'M', 38000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Joyce','English', 453453453, '01-JAN-65', '731 Fondren, Houston, TX', 'F', 25000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('Ahmad','Jabbar', 987987987, '01-JAN-65', '731 Fondren, Houston, TX', 'M', 25000, NULL, NULL);
INSERT INTO EMPLOYEE VALUES('James','Borg', 888665555, '01-JAN-65', '731 Fondren, Houston, TX', 'M', 55000, NULL, NULL);

INSERT INTO DEPARTMENT VALUES('Research',5,'333445555','22-MAY-1988');
INSERT INTO DEPARTMENT VALUES('Administration',4,'987654321','01-JAN-1995');
INSERT INTO DEPARTMENT VALUES('Headquarters',1,'888665555','19-JUN-1981');
INSERT INTO DEPARTMENT VALUES('tech-Development',2,'666884444','22-MAY-1988');
INSERT INTO DEPARTMENT VALUES('tech-Management',3,'999887777','01-JAN-1995');

INSERT INTO DEPENDENT VALUES('Alice','333445555');
INSERT INTO DEPENDENT VALUES('Theodore','333445555');
INSERT INTO DEPENDENT VALUES('Joy','333445555');
INSERT INTO DEPENDENT VALUES('Abner','987654321');
INSERT INTO DEPENDENT VALUES('Michael','123456789');
INSERT INTO DEPENDENT VALUES('Alice','123456789');
INSERT INTO DEPENDENT VALUES('Elizabeth','123456789');

-- For each dept, retreive the dept name and avg salary of all employees working in that department

SELECT Dname, AVG(Salary) FROM DEPARTMENT, EMPLOYEE WHERE Dno=Dnumber GROUP BY Dname;

-- List names of managers who have at least one dependent

SELECT Fname, Lname FROM EMPLOYEE WHERE EXISTS(SELECT * FROM DEPENDENT WHERE Ssn=Essn) AND EXISTS (SELECT * FROM DEPARTMENT WHERE Ssn=Mgr_ssn);
-- or
SELECT Fname, Lname FROM EMPLOYEE WHERE Ssn IN ( SELECT Mgr_ssn FROM DEPARTMENT WHERE Mgr_ssn IN (SELECT Essn FROM DEPENDENT));

-- Display details of all departments having 'tech' as their substring

SELECT * FROM DEPARTMENT WHERE Dname LIKE '%tech%';