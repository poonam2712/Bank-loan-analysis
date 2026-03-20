-- bank loan analysis
use fusion;

set session sql_mode="";

select * from financial_loan;
-- take a back up of main table 

create table bank_loan as
select * from financial_loan;

-- data cleaning-->setting appropriate data types
-- convert issue_date to date type


update financial_loan
set issue_date = 
case 
	when issue_date like '%/%' then str_to_date(issue_date,'%d/%m/%Y')
	when issue_date like '%-%' then str_to_date(issue_date,'%d-%m-%Y')
else null
end;

update financial_loan
set last_credit_pull_date =
case 
	when last_credit_pull_date  like '%/%' then str_to_date(last_credit_pull_date,'%d/%m/%Y')
	when last_credit_pull_date like '%-%' then str_to_date(last_credit_pull_date,'%d-%m-%Y')
else null
end;

update financial_loan
set last_payment_date = 
case 
	when last_payment_date like '%/%' then str_to_date(last_payment_date,'%d/%m/%Y')
	when last_payment_date like '%-%' then str_to_date(last_payment_date,'%d-%m-%Y')
else null
end;


update financial_loan
set next_payment_date = 
case 
	when next_payment_date like '%/%' then str_to_date(next_payment_date,'%d/%m/%Y')
	when next_payment_date like '%-%' then str_to_date(next_payment_date,'%d-%m-%Y')
else null
end;

-- now change column datatype to date
alter table financial_loan
modify issue_date date,
modify last_credit_pull_date date,
modify last_payment_date date,
modify next_payment_date date;


-- KPI'S
-- 1]. TOTAL LOAN APPLICATION
select count(id) as total_application from financial_loan;

-- MTD LOAN APPLICATION
SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(issue_date) = 12;

 -- PMTD LOAN APPLICATION
 SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11;
 
 -- Total funded Amount
 select sum(loan_amount) as Total_Funded_Amount 
 from financial_loan;
 
 -- MTD Total funded Amount
 select sum(loan_amount) as Total_Funded_Amount
 from financial_loan
 where month(issue_date)=12;
 
 -- PMTD Total Funded Amount
 select sum(loan_amount) as Total_Funded_amount
 from financial_loan
 where month(issue_date)=11;
 
 -- Total Amount Recived
 select sum(total_payment) as Total_Amount_Collected
 from financial_loan;
 
 -- MTD Total Amount Recived
 select sum(total_payment) as total_Amount_collected
 from financial_loan
 where month(issue_date)=12;
 
 -- PMTD Total Amount Recived
 select sum(total_payment) as Total_Amount_collected
 from financial_loan
 where month(issue_date)=11;
 
 -- Avarage Interest Rate
 select avg(int_rate)*100 as Avg_Int_Rate from financial_loan;
 
 -- MTD Avarage Interest 
 select Avg(int_rate) *100 as MTD_avg_Int_Rate 
 from financial_loan
 where month(issue_date)=12;
 
 -- PMTD Avarage Interest
 select avg(int_rate) *100 as PMTD_avg_int_rate
 from financial_loan
 where month(issue_date)=11;




