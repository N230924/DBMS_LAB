CREATE DATABASE gram_panchayat_db;
USE gram_panchayat_db;
CREATE TABLE Citizen(citizen_id INT PRIMARY KEY,full_name VARCHAR(100) NOT NULL,date_of_birth DATE NOT NULL,gender VARCHAR(10) NOT NULL,mobile_number VARCHAR(15) NOT NULL,occupation VARCHar(50),village_name VARCHAR(50) NOT NULL,is_active BOOLEAN NOT NULL);
INSERT INTO Citizen VALUES
(101,'Ravi Kumar','1995-06-15','Male',9876500001,'Farmer','Ramapuram',TRUE),
(102,'Rama Devi','1988-11-22','Female',9876500002,'Tailor','Ramapuram',TRUE),
(103,'Suresh Babu','1992-03-10','Male',9876500003,'Shopkeeper','Seethampeta',TRUE),
(104,'Anjali Rao','2000-08-05','Female',9876500004,'Student','Ramapuram',TRUE),
(105,'Kiran Kumar','1985-01-18','Male',9876500005,'Electrician','Seetampeta',TRUE),
(106,'Meena Kumari','1998-12-30','Female',9876500006,'Teacher','Lakshmipuram',FALSE);
SELECT * FROM Citizen;
CREATE TABLE Certificate_Type(certificate_type_id INT PRIMARY KEY,certificate_name VARCHAR(100) NOT NULL,description VARCHAR(200) NOT NULL,processing_days INT NOT NULL,application_fee DECIMAL(8,2) NOT NULL,is_available BOOLEAN NOT NULL);
INSERT INTO Certificate_Type VALUES
(1,'Residence Certificate','Certifies the declared place of residence',7,30,1),
(2,'Birth Record Request','Request for a locally maintained birth record',5,20,1),
(3,'Death Record Request','Request for a loacally maintained death record',5,20,1),
(4,'Family Member Certificate','Records declared famiy member informationa',10,40,1),
(5,'Proprty Certificate','Certificate related to locally maintained property records',15,50,1),
(6,'No-Dues Certificate','Indicates applicable local dues status',7,25,0);
SELECT * FROM Certificate_Type;
CREATE TABLE Certificate_Application(application_id INT PRIMARY KEY,citizen_id INT NOT NULL,certificate_name VARCHAR(100) NOT NULL,application_date DATE NOT NULL,purpose VARCHAR(200) NOT NULL,application_status VARCHAR(30) NOT NULL,fee_paid DECIMAL(8,2) NOT NULL,reference_number VARCHAR(30) UNIQUE);
INSERT INTO Certificate_Application VALUES
(1001,101,'Residence Certificate','2026-07-01','Bank account documentation','Submitted',30,'GP20260001'),
(1002,102,'Family Member Certificate','2026-07-02','Welfare scheme application','Under Review',40,'GP20260002'),
(1003,103,'Property Certificate','2026-07-03','Propert Documnetation','Submitted',50,'GP20260003'),
(1004,104,'Residence Certificate','2026-07-04','College Admission','Approved',30,'GP20260004'),
(1005,105,'No-Dues Certificate','2026-07-05','Local service requirement','Under review',25,'GP20260005'),
(1006,106,'Birth Record Request','2026-07-06','Personal documentation','Rejected',20,'GP20260006');
SELECT * FROM Certificate_Application;
CREATE TABLE Panchayat_Office(office_id INT PRIMARY KEY,office_name VARCHAR(100) NOT NULL,village_name VARCHAR(50) NOT NULL,pincode VARCHAR(6) NOT NULL,contact_number VARCHAR(15) UNIQUE,office_mail VARCHAR(100) UNIQUE,opening_time TIME NOT NULL,is_operational BOOLEAN NOT NULL);
INSERT INTO Panchayat_Office VALUES
(1,'Ramapuram Gram Panchayat','Ramapuram','521101','0866000001','ramapuram@gp.example','09:00:00',1),
(2,'Seethampeta Gram Panchayat','Seethampeta','521102','0866000002','seethampeta@gp.example','09:30:00',1),
(3,'Lakshmipuram Gram Panchayat','Laksmipuram','521103','0866000003','lakshmipuram@gp.example','09:00:00',1),
(4,'Krishnapuram Gram Panchayat','Krishnapuram','521104','0866000004','krishanpuram@gp.example','10:00:00',1),
(5,'Venkatapuram Gram Panchayt','Venkatapuram','521105','0866000005','venkatapuram@gp.eaxmple','09:30:00',1),
(6,'Gopalapuram Gram Panchayt','Gopalapuram','521106','0866000006','gopalapuram@gp.example','09:00:00',0);
SELECT * FROM Panchayat_Office;
#DML Commands
INSERT INTO Citizen() VALUES (107,'Juvvanapudi Sanjana','2008-04-28','Female','8121387873','Student','Chillaboinapalli',1);
INSERT INTO Certificate_Type() VALUES(7,'Income Certificate','Certificate related to annual income of a family',8,50,1);
UPDATE Certificate_Application SET application_status='Under Review' WHERE applicatio_id=1001;
UPDATE Certificate_Application SET application_status='Approved' WHERE applicatio_id=1002;
UPDATE Citizen SET occupation='Electrical Technician' WHERE citizen_id=105;
UPDATE Certificate_Type SET processing_days=12 WHERE certificate_type_id=5;
UPDATE Certificate_Type SET is_available=1 WHERE certificate_type_id=6;
DELETE FROM Citizen WHERE citizen_id=107;
#DDL Commands
ALTER TABLE Citizen ADD(address VARCHAR(200));
ALTER TABLE Certificate_Application ADD(issued_date DATE);
ALTER TABLE Certificate_Application MODIFY COLUMN purpose VARCHAR(255);
ALTER TABLE Panchayat_Office ADD(closing_time TIME);

CREATE TABLE Temporary_Request(request_id INT PRIMARY KEY,request_name VARCHAR(10) NOT NULL,request_date DATE NOT NULL);
INSERT INTO Temporary_Request VALUES
(1,'Nothing','2008-08-28'),
(2,'Hello','2008-11-19'),
(3,'Excuse me','1998-12-08');
SELECT * FROM Temporary_Request;
TRUNCATE TABLE Temporary_Request;
DROP TABLE Temporary_Request;
INSERT INTO Citizen() VALUES (101,'Juvvanapudi Sanjana','2008-04-28','Female','8121387873','Student','Chillaboinapalli',1,'Eluru');
INSERT INTO Panchayat_Office() VALUES(7,'Seethampeta Gram Panchayat','Seethampeta','521102','0866000002','seethampeta@gp.example','09:30:00',1,'04:00:00');
INSERT INTO Certificate_Type() VALUES(7,'Records declared famiy member informationa',10,40,1);
INSERT INTO Certificate_Application() VALUES(1007,107,'Residence Certificate','2026-07-04','College Admission','Approved',30,'GP20260004','2008-08-24');