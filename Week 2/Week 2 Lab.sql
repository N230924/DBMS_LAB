USE gram_panchayat_db;
SHOW TABLES;
SELECT * FROM Citizen;
SELECT * FROM Certificate_Type;
SELECT * FROM Certificate_Application;
SELECT * FROM Panchayat_Office;

#Built-in String Functions
#Level 1
SELECT UPPER(full_name) FROM Citizen;
SELECT LOWER(village_name) FROM Citizen;
SELECT full_name,LENGTH(full_name) FROM Citizen;
SELECT SUBSTRING(reference_number,1,4) FROM Certificate_Application;
SELECT LEFT(reference_number,4) FROM Certificate_Application;
SELECT CONCAT(full_name,' - ',village_name) FROM Citizen;
#Level 2
SELECT REPLACE(certificate_name,'Certificate','Cert.') FROM Certificate_Type;
SELECT TRIM(certificate_name) FROM Certificate_Type;
SELECT SUBSTRING_INDEX(full_name,' ',1) FROM Citizen;
#Level 3
SELECT CONCAT('Citizen : ',full_name,'\nVillage : ',village_name) AS Deatails FROM Citizen;
SELECT * FROM Certificate_Application WHERE reference_number LIKE 'GP2026%';

#Built-in Numeric Functions
#Level 1
SELECT ROUND(application_fee) FROM Certificate_Type;
SELECT ABS(processing_days - 10) FROM Certificate_Type;
SELECT POWER(processing_days,2) FROM Certificate_Type;
#Level 2
SELECT MOD(processing_days,3) FROM Certificate_Type;
SELECT ROUND(application_fee,1) FROM Certificate_Type;
SELECT application_fee,CEIL(application_fee),FLOOR(application_fee) FROM Certificate_Type;
#Level 3
SELECT FLOOR(RAND()*100)+1;
SELECT SQRT(processing_days) FROM Certificate_Type;
SELECT processing_days*2 FROM Certificate_Type;

#Date Functions
#Level 1
SELECT CURDATE();
SELECT CURRENT_DATE();
SELECT NOW();
SELECT YEAR(application_date) FROM Certificate_Application;
SELECT MONTH(application_date) FROM Certificate_Application;
SELECT DAY(application_date) FROM Certificate_Application;
#Level 2
SELECT ct.certificate_name,ca.application_date,ct.processing_days,DATE_ADD(ca.application_date,INTERVAL ct.processing_days DAY) AS Expected_Issue_Date
FROM Certificate_Application AS ca INNER JOIN Certificate_Type AS ct ON ca.certificate_id = ct.certificate_id;
SELECT application_date,date_add(application_date,interval 30 DAY) from Certificate_Application;
select application_date,date_sub(application_date,interval 7 day) from Certificate_Application;
#Level 3
select application_date,datediff(curdate(),application_date) from Certificate_Application;
select applicatio_id,application_date from Certificate_Application where year(application_date)=year(curdate());

#Conversion Functions
#Level 1
select convert(application_fee,signed) from Certificate_Type;
select cast(processing_days AS CHAR) from Certificate_Type;
#Level 2
select convert(application_date,datetime) from Certificate_Application;
select convert(processing_days,decimal(8,2)) from Certificate_Type;
#Level 3
select convert(application_fee,CHAR) from Certificate_Type;
select convert(application_fee,signed)+100 from Certificate_Type;