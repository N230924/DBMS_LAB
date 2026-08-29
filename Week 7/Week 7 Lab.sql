use gram_panchayat_db;
show tables;
select * from Citizen;
select * from Certificate_Type;
select * from Certificate_Application;
select * from Panchayat_Office;

#Level 1
create view Certificate_Applications as select * from Certificate_Application;
create view Application_Details as select applicatio_id,citizen_id,application_status from Certificate_Application;
create view Approved_Applications as select * from Certificate_Application where application_status='Approved';
select * from Approved_Applications;
show full tables where Table_type ='VIEW';

#Level 2
create view Application_Name_Date as select C.certificate_name,CA.application_date 
from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id;
create view Application_Citizen_Status as select C.full_name,CA.application_status
from Citizen C join Certificate_Application CA on C.citizen_id=CA.citizen_id;
create view Applications_Submitted as select P.office_id,P.office_name,CA.applicatio_id,CA.certificate_id 
from Certificate_Application CA join Panchayat_Office P on P.office_id=CA.office_id;
create view Application_Count as select certificate_id,count(*) as total_applications from Certificate_Application group by certificate_id;
create view Application_Count_Panchayat as select office_id,count(*) as total_applications from Certificate_Application group by office_id;
create view Pending_Applications as select C.certificate_name,CA.applicatio_id from Certificate_Application CA join Certificate_Type C
on CA.certificate_id=C.certificate_id where CA.application_status='Pending';
select * from Application_Details where application_status='Approved';
show create view Approved_Applications;

#Level 3
create view Applied_Applications_Count as select C.certificate_name,count(*) as total_applications 
from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id group by C.certificate_name;
create view More_Application_1 as select P.office_name,count(*) as applications_submitted from Panchayat_Office P 
join Certificate_Application CA on P.office_id=CA.office_id group by P.office_name,CA.office_id having count(*)>1;
create view Application_Earliest_Latest as select C.certificate_name,min(CA.application_date) as earliest_application,max(CA.application_date)
as latest_application from Certificate_Type C join Certificate_Application CA on C.certificate_id=CA.certificate_id group by C.certificate_name;
create view Application_Citizen as select C.full_name,count(*) as total_applications from Citizen C 
join Certificate_Application CA on C.citizen_id=CA.citizen_id group by CA.citizen_id;
create view Citizen_Certificate_Application_Details as select C.full_name,CT.certificate_name,CA.applicatio_id,CA.application_date from
Citizen C join Certificate_Application CA on C.citizen_id=CA.citizen_id join Certificate_Type CT on CA.certificate_id=CT.certificate_id;
create view Citizen_Certificate_Approved_Details as select C.full_name,CT.certificate_name,CA.application_status from Citizen C join Certificate_Application CA
on C.citizen_id=CA.citizen_id join Certificate_Type CT on CA.certificate_id=CT.certificate_id where CA.application_status='Approved';
select * from Application_Citizen order by total_applications desc;

create view Application as select certificate_name from Certificate_Type;
drop view Application;
select * from Application;

#Optional
create view All_Application_Details as select C.full_name,CT.certificate_name,P.office_name,CA.applicatio_id from Citizen C join Certificate_Application CA
on CA.citizen_id=C.citizen_id join Certificate_Type CT on CA.certificate_id=CT.certificate_id join Panchayat_Office P on CA.office_id=P.office_id;
select * from All_Application_Details;

create view Gram_Panchayat_Dashboard as select CA.applicatio_id,C.full_name,CT.certificate_name,P.office_name,CA.application_date,CA.application_status from Citizen C join Certificate_Application CA
on CA.citizen_id=C.citizen_id join Certificate_Type CT on CA.certificate_id=CT.certificate_id join Panchayat_Office P on CA.office_id=P.office_id;
select * from Gram_Panchayat_Dashboard;