use gram_panchayat_db;
show tables;
select * from Citizen;
select * from Certificate_Application;
select * from Certificate_Type;
select * from Panchayat_Office;

#Level 1
SELECT application_date FROM Certificate_Application WHERE application_date=(SELECT MAX(application_date) FROM Certificate_Application); 
SELECT application_date FROM Certificate_Application WHERE application_date=(SELECT MIN(application_date) FROM Certificate_Application);
SELECT applicatio_id,application_date FROM Certificate_Application WHERE application_date=(SELECT MAX(application_date) FROM Certificate_Application); 
SELECT applicatio_id,application_date FROM Certificate_Application WHERE application_date=(SELECT MIN(application_date) FROM Certificate_Application); 
select * from Citizen where citizen_id in (select citizen_id from Certificate_Application where application_status='Approved');

#Level 2
select * from Certificate_Application where application_date>(select min(application_date) from Certificate_Application);
select * from Certificate_Application where application_date<(select max(application_date) from Certificate_Application);
select * from Citizen where citizen_id in (select citizen_id from Certificate_Application);
select * from Citizen where citizen_id not in (select citizen_id from Certificate_Application where application_status='Approved');
select * from Certificate_Type where certificate_id in (select certificate_id from Certificate_Application where application_status='Approved');
select * from Certificate_Type where certificate_id not in (select certificate_id from Certificate_Application where application_status='Approved');
select * from Certificate_Application where application_date>(select avg(application_date) from Certificate_Application);
select C.certificate_name,CA.application_date from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id 
where CA.application_date=(select max(application_date) from Certificate_Application);

#Level 3
SELECT C.certificate_name, COUNT(*) AS application_count FROM Certificate_Type C JOIN Certificate_Application CA ON C.certificate_id=CA.certificate_id
GROUP BY C.certificate_name HAVING COUNT(*)=(SELECT MAX(application_count)FROM(SELECT COUNT(*) AS application_count FROM Certificate_Application GROUP BY certificate_id)AS counts);
select P.office_name,count(*) as application_count from Certificate_Application CA join Panchayat_Office P on CA.office_id=P.office_id
group by P.office_name having count(*)=(select max(application_count) from (select count(*) as application_count from Certificate_Application group by office_id) as counts);
select C.certificate_name,count(*) as application_count from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id
group by C.certificate_name having count(*)>(select avg(application_count) from (select count(*) as application_count from Certificate_Application group by certificate_id) as counts);
select P.office_name,count(*) as total_applications from Certificate_Application CA join Panchayat_Office P on CA.office_id=P.office_id
group by P.office_name,P.office_id having count(*)>any(select count(*) from Certificate_Application group by office_id);
select P.office_name,count(*) as total_applications from Certificate_Application CA join Panchayat_Office P on CA.office_id=P.office_id
group by P.office_name,P.office_id having count(*)>all(select count(*) from Certificate_Application CA2 where CA2.office_id<>P.office_id group by CA2.office_id);
select C.certificate_name,CA.application_date from Certificate_Application CA join Certificate_Type C on CA.certificate_id=C.certificate_id 
where CA.application_date=(select max(application_date) from Certificate_Application);
select C.full_name,count(*) as application_count from Citizen C join Certificate_Application CA on C.citizen_id=CA.citizen_id
group by C.full_name having count(*)>(select 1);
select application_status,count(*) as application_count from Certificate_Application group by application_status having count(*)=(
select max(application_count) from(select count(*) as application_count from Certificate_Application group by application_status)as counts);

#Optional
select applicatio_id,application_date from Certificate_Application where application_date=(select max(application_date) from Certificate_Application);
select applicatio_id,application_date from Certificate_Application where application_date=(select min(application_date) from Certificate_Application);
select full_name from Citizen where citizen_id in(select citizen_id from Certificate_Application where application_status='Approved');
select certificate_name from Certificate_Type where certificate_id not in(select certificate_id from Certificate_Application where application_status='Approved');
select P.office_name,count(*) as application_count from Certificate_Application CA join Panchayat_Office P on CA.office_id=P.office_id group by P.office_name having count(*)=(select
max(application_count) from(select count(*) as application_count from Certificate_Application group by office_id)as counts);
select C.certificate_name,count(*) as application_count from Certificate_Application CA join Certificate_Type C on C.certificate_id=CA.certificate_id 
group by C.certificate_name having count(*)>(select avg(application_count) from(select count(*) as application_count from Certificate_Application group by certificate_id)as counts);
select C.certificate_name,count(*) as total_applications from Certificate_Application CA join Certificate_Type C on C.certificate_id=CA.certificate_id 
group by C.certificate_name,C.certificate_id having count(*)=(select max(total_applications) from(select count(*) as total_applications from Certificate_Application group by certificate_id)as counts);
SELECT C.certificate_name AS certificate_type,COUNT(*) AS total_applications,MIN(CA.application_date) AS earliest_application_date,MAX(CA.application_date) AS latest_application_date
from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id group by C.certificate_id,C.certificate_name;