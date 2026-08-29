use gram_panchayat_db;
show tables;
select * from Citizen;
select * from Certificate_Type;
select * from Certificate_Application;
select * from Panchayat_Office;
alter table Certificate_Application  drop column certificate_name,drop column office_name;
alter table Certificate_Application add column certificate_id int,add column office_id int;
update Certificate_Application set certificate_id=1,office_id=1 where applicatio_id=1001;
update Certificate_Application set certificate_id=4,office_id=2 where applicatio_id=1002;
update Certificate_Application set certificate_id=5,office_id=3 where applicatio_id=1003;
update Certificate_Application set certificate_id=1,office_id=4 where applicatio_id=1004;
update Certificate_Application set certificate_id=6,office_id=5 where applicatio_id=1005;
update Certificate_Application set certificate_id=2,office_id=6 where applicatio_id=1006;
alter table Certificate_Application add constraint fk_citizen foreign key (citizen_id) references Citizen(citizen_id);
alter table Certificate_Type change certificate_type_id certificate_id int;
alter table Certificate_Application add constraint fk_certificate foreign key (certificate_id) references Certificate_Type(certificate_id);
alter table Certificate_Application add constraint fk_office foreign key (office_id) references Panchayat_Office(office_id);
show create table Certificate_Application;
insert into Certificate_Application(applicatio_id,citizen_id,application_date,purpose,application_status,fee_paid,reference_number,issued_date,certificate_id,office_id) values
(1007,75,'2026-07-07','test','submitted',30,'gp20260007',null,1,1);
insert into Certificate_Application(applicatio_id,citizen_id,application_date,purpose,application_status,fee_paid,reference_number,issued_date,certificate_id,office_id) values
(1008,101,'2026-07-08','test','submitted',30,'gp20260008',null,99,1);
delete from Citizen where citizen_id=101;
delete from Certificate_Type where certificate_id=1;

#Level 0
select * from Citizen;
select * from Certificate_Application;
select full_name from Citizen order by full_name asc;
select distinct village_name from Citizen;
select distinct certificate_name from Certificate_Type;
select distinct office_name from Panchayat_Office;
select * from Certificate_Application where application_status='PENDING';
select * from Citizen where village_name='Ramapuram';
select * from Certificate_Application where year(application_date)=2026;
select * from Certificate_Application order by application_date desc;
select ca.* from Certificate_Application ca join Panchayat_Office po on ca.office_id=po.office_id where po.office_name='Seethampeta Panchayat Office';
select c.full_name from Citizen c join Certificate_Application ca on c.citizen_id-ca.citizen_id join Certificate_Type ct on ca.certificate_id=ct.certificate_id where ct.certificate_name='Income Certificate';

#Level 1
select c.full_name from Citizen c join Certificate_Application ca on c.citizen_id=ca.citizen_id join Certificate_Type ct on ca.certificate_id=ct.certificate_id where ct.certificate_name='Income Certificate'
union
select c.full_name from Citizen c join Certificate_Application ca on c.citizen_id=ca.citizen_id join Certificate_Type ct on ca.certificate_id=ct.certificate_id where ct.certificate_name='Residence Certificate';
SELECT * FROM Certificate_Application WHERE MONTH(application_date) = 1 UNION SELECT * FROM Certificate_Application WHERE MONTH(application_date) = 2;
SELECT * FROM Citizen WHERE village_name= 'Ramapuram' UNION SELECT * FROM Citizen WHERE village_name = 'Lakshmipuram';
SELECT DISTINCT ca1.citizen_id FROM Certificate_Application ca1 INNER JOIN Certificate_Application ca2 ON ca1.citizen_id = ca2.citizen_id
WHERE ca1.certificate_id=7 AND ca2.certificate_id=1;
SELECT DISTINCT ca1.citizen_id FROM Certificate_Application ca1 INNER JOIN Certificate_Application ca2 ON ca1.citizen_id=ca2.citizen_id
WHERE YEAR(ca1.application_date) = 2025 AND YEAR(ca2.application_date) = 2026;
SELECT DISTINCT ca1.citizen_id FROM Certificate_Application ca1 WHERE ca1.certificate_id=7
AND NOT EXISTS (SELECT 1 FROM Certificate_Application ca2 WHERE ca2.citizen_id=ca1.citizen_id AND ca2.certificate_id=1);
SELECT applicatio_id FROM Certificate_Application ca1 WHERE YEAR(ca1.application_date) = 2026
AND NOT EXISTS(SELECT 1 FROM Certificate_Application ca2 WHERE ca2.citizen_id = ca1.citizen_id AND YEAR(ca2.application_date) = 2025);
INSERT INTO Certificate_Application(citizen_id,certificate_id,application_date,applicatio_id,application_status,fee_paid) VALUES
(9999,7,'2026-08-10',7,'submitted',30);
DELETE FROM Citizen WHERE citizen_id=1;

#Level 2
SELECT full_name FROM Citizen WHERE citizen_id IN(SELECT citizen_id FROM Certificate_Application);
SELECT * FROM Citizen WHERE citizen_id IN(SELECT citizen_id FROM Certificate_Application WHERE certificate_id=7);
SELECT full_name FROM Citizen WHERE citizen_id NOT IN(SELECT citizen_id FROM Certificate_Application);
SELECT * FROM Panchayat_Office WHERE office_id NOT IN(SELECT office_id FROM Certificate_Application);
SELECT full_name  FROM Citizen c WHERE EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.citizen_id=c.citizen_id);
SELECT * FROM Certificate_Type ct WHERE EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.certificate_id=ct.certificate_id);
SELECT full_name FROM Citizen c WHERE NOT EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.citizen_id=c.citizen_id);
SELECT * FROM Certificate_Type ct WHERE NOT EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.certificate_id=ct.certificate_id);
SELECT full_name,date_of_birth FROM Citizen WHERE TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())>ANY(SELECT TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) FROM Citizen WHERE village_name='Ramapuram');
SELECT full_name,date_of_birth FROM Citizen WHERE TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())>ALL(SELECT TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())FROM Citizen WHERE village_name='Ramapuram');
SELECT ca.* FROM Certificate_Application ca JOIN Certificate_Type ct ON ca.certificate_id = ct.certificate_id WHERE ct.processing_days>ALL
(SELECT ct2.processing_days FROM Certificate_Application ca2 JOIN Certificate_Type ct2 ON ca2.certificate_id=ct2.certificate_id WHERE ca2.office_id IN(SELECT office_id FROM Panchayat_Office WHERE office_name='Nuzvid Panchayat Office'));

#mini challenge
SELECT c.citizen_id, c.full_name, COUNT(ca.citizen_id) AS application_count FROM Citizen c JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id GROUP BY c.citizen_id,c.full_name ORDER BY application_count DESC LIMIT 1;
SELECT po.office_id,po.office_name,COUNT(ca.applicatio_id) AS application_count FROM Panchayat_Office po JOIN Certificate_Application ca ON po.office_id=ca.office_id GROUP BY po.office_id,po.office_name ORDER BY application_count DESC LIMIT 1;
SELECT ct.certificate_id,COUNT(ca.applicatio_id) AS application_count FROM Certificate_Type ct JOIN Certificate_Application ca ON ct.certificate_id=ca.certificate_id GROUP BY ct.certificate_id HAVING COUNT(ca.applicatio_id)>5;
SELECT DISTINCT c.village_name FROM Citizen c WHERE NOT EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.citizen_id=c.citizen_id);
SELECT * FROM Citizen c WHERE NOT EXISTS(SELECT 1 FROM Certificate_Type ct WHERE NOT EXISTS(SELECT 1 FROM Certificate_Application ca WHERE ca.citizen_id=c.citizen_id AND ca.certificate_id=ct.certificate_id));
SELECT c.full_name,COUNT(ca.applicatio_id) AS application_count FROM Citizen c JOIN Certificate_Application ca ON c.citizen_id=ca.citizen_id GROUP BY c.citizen_id,c.full_name HAVING COUNT(ca.applicatio_id)>1;