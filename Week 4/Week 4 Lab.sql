USE gram_panchayat_db;
show tables;
select * from Citizen;
select * from Certificate_Application;
select * from Certificate_Type;
select * from Panchayat_Office;

SELECT full_name,ct.certificate_name FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id;
SELECT full_name,po.office_name FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id;
SELECT ca.applicatio_id,full_name FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id;
SELECT full_name,ct.certificate_name,ca.application_date FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id;
SELECT full_name,ct.certificate_name,po.office_name FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id 
INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id;

SELECT  full_name,po.office_name FROM Citizen c INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id 
INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id WHERE ct.certificate_name='Income Certificate';
SELECT ca.applicatio_id,c.citizen_id,full_name,c.village_name,ca.application_date FROM Citizen c
INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id WHERE po.office_name='Nuzvid Panchayat Office';
SELECT ca.applicatio_id,ct.certificate_name,ct.description FROM Certificate_Application ca INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id;
SELECT full_name,c.village_name,ct.certificate_name,po.office_name,ca.application_date FROM Citizen c INNER JOIN Certificate_Application ca
ON c.citizen_id=ca.citizen_id INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id;
SELECT c.citizen_id,full_name,c.village_name,ct.certificate_id,po.office_id,ca.applicatio_id,ca.application_date FROM Citizen c
INNER JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id INNER JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id INNER JOIN Panchayat_Office po ON ca.office_id=po.office_id;

SELECT c.citizen_id,full_name,c.village_name,ca.applicatio_id FROM Citizen c LEFT JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id;
SELECT ct.certificate_id,ct.certificate_name,ca.applicatio_id,ca.citizen_id FROM Certificate_Application ca RIGHT JOIN Certificate_Type ct ON ca.certificate_id=ct.certificate_id;
SELECT c.citizen_id,full_name,ca.applicatio_id FROM Citizen c LEFT JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id
UNION
SELECT c.citizen_id,full_name,ca.applicatio_id FROM Citizen c RIGHT JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id;
SELECT full_name,ct.certificate_name FROM Citizen c CROSS JOIN Certificate_Type ct;
SELECT c1.full_name AS Citizen1,c2.full_name AS Citizen2,c1.village_name FROM Citizen c1
INNER JOIN Citizen c2 ON c1.village_name=c2.village_name AND c1.citizen_id<c2.citizen_id;