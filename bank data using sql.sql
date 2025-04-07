create database Bank_analyst;
use bank_analyst;
drop table bankdata;
CREATE TABLE Bankdata
(
    Account_ID VARCHAR(50),
    Age VARCHAR(20),
    BH_Name VARCHAR(100),
    Bank_Name VARCHAR(100),
    Branch_Name VARCHAR(100),
    Caste VARCHAR(50),
    Center_Id INT,
    City VARCHAR(100),
    Client_id INT,
    Client_Name VARCHAR(100),
    Close_Client VARCHAR(10),
    Closed_Date DATE,
    Credif_Officer_Name VARCHAR(100),
    Date_of_Birth DATE,
    Disb_By VARCHAR(50),
    Disbursement_Date DATE,
    Disbursement_Date_Years INT,
    Gender_ID VARCHAR(10),
    Home_Ownership VARCHAR(50),
    Loan_Status VARCHAR(50),
    Next_Meeting_Date DATE,
    Product_Code VARCHAR(50),
    Grade VARCHAR(10),
    Sub_Grade VARCHAR(10),
    Product_Id VARCHAR(50),
    Purpose_Category VARCHAR(100),
    Region_Name VARCHAR(100),
    Religion VARCHAR(50),
    Verification_Status VARCHAR(50),
    State_Abbr VARCHAR(10),
    State_Name VARCHAR(100),
    Tranfer_Logic VARCHAR(50),
    Is_Delinquent_Loan VARCHAR(10),
    Is_Default_Loan VARCHAR(10),
    Age_T INT,
    Delinq_2_Yrs INT,
    Loan_Amount DECIMAL(15,2),
    Funded_Amount DECIMAL(15,2),
    Funded_Amount_Inv DECIMAL(15,2),
    Term VARCHAR(20),
    Int_Rate DECIMAL(5,4),
    Total_Pymnt DECIMAL(15,2),
    Total_Pymnt_inv DECIMAL(15,2),
    Total_Rec_Prncp DECIMAL(15,2),
    Total_Fees DECIMAL(15,2),
    Total_Rec_Int DECIMAL(15,2),
    Total_Rec_Late_fee DECIMAL(15,2),
    Recoveries DECIMAL(15,2),
    Collection_Recovery_fee DECIMAL(15,2)
);
select * from bankdata;

--  1. Total Loan Amount Funded
select sum(funded_Amount) as Total_loan_Amount from  bankdata  ;

-- 2. Total Loans
select count(loan_amount) as Total_loan from bankdata;

-- 3. Total Collection
select sum(Total_Pymnt_inv)+sum(Total_Rec_Prncp) as Total_Collection from bankdata;

-- 4. Total Interest
select sum(Total_Pymnt_inv) as Total_Interest from bankdata;

-- 5. Branch-Wise (Interest, Fees, Total Revenue)
select Branch_Name,Total_Pymnt_inv,Total_Fees,(Total_Pymnt_inv+Total_Fees) from bankdata;

-- 6. State-Wise Loan
select State_name , sum(loan_Amount) from bankdata group by State_name;

-- 7. Religion-Wise Loan
select  Religion ,sum(loan_Amount)  from bankdata group by religion;

-- 8. Product Group-Wise Loan
select * from bankdata;
select Home_Ownership,sum(loan_Amount) from bankdata group by Home_Ownership;

-- 9. Disbursement Trend
 select year(Disbursement_Date),Term ,sum(loan_Amount) 
 from bankdata 
 group by year(Disbursement_Date),Term 
 order by  year(Disbursement_Date) ;
 
 -- 10. Grade-Wise Loan
select Grade , sum(loan_amount) from bankdata group by grade;

-- 11. Count of Default Loan
select count(Is_Default_Loan) from bankdata where Is_Default_Loan="Y" ;

-- 12. Count of Delinquent Clients
select count(Is_Delinquent_Loan) from bankdata where Is_Delinquent_Loan="Y" ;

-- 13. Delinquent Loans Rate
select count(Is_Delinquent_Loan) from bankdata;
select concat(round((count(Is_Delinquent_Loan)/65496)*100,2),"%") as Deliquent_rate
from bankdata 
where Is_Delinquent_Loan="Y";

-- 14. Default Loan Rate
select count(Is_Default_Loan) from bankdata;
select concat(round((count(Is_Default_Loan)/65496)*100,2),"%") as Is_Default_Loan 
from bankdata 
where Is_Default_Loan="Y";

-- 15. Loan Status-Wise Loan
select * from bankdata;
select loan_status ,sum(loan_amount)as loan_amount
 from bankdata 
 group by loan_status;

-- 16. Age Group-Wise Loan
select age,sum(loan_Amount) from bankdata group by age;

-- 17. No Verified Loan
select count(Verification_Status)
 from bankdata 
 where Verification_Status="Verified";
 
 -- 18. Loan Maturity
select Account_id,datediff(closed_date,Disbursement_date) as maturity_days
 from bankdata;