/*Assignment 11 Macrovariables*/

/*Question 1a*/
%put _automatic_;

/*Question 2a*/
%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

proc sort data = orion.customer out = cust;
	by Country;
run;

/*Question 2b*/
title "&syslast";
proc print data = &syslast;
run;
title;

/*Question 3a*/
data new;
   set orion.customer;
run;
%put &syslast;

/*What is the value of the automatic macro variable SYSLAST after the 
following DATA step is submitted? A: work.new*/

/*Question 3b*/
proc print data = orion.customer;
run;
%put &syslast;
/*What is the value of the automatic macro variable SYSLAST after the 
following PROC PRINT step is submitted? A: work.new */

/*Question 4a*/
proc print data=orion.employee_payroll;
   format Birth_Date Employee_Hire_Date date9.;
run;

/*Question 4b*/
proc print data=orion.employee_payroll;
   format Birth_Date Employee_Hire_Date date9.;
   where '01JAN2007'd <= Employee_Hire_Date <= "&SYSDATE9"d;
run;

/*Question 5a*/
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains 'Gold';
   title 'Gold Customers';
run;

/*Question 5b*/
%let TYPE = Gold;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&TYPE";
   title "&TYPE Customers";
run;

/*Question 5c*/
options symbolgen;
%let TYPE = Gold;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&TYPE";
   title "&TYPE Customers";
run;

/*Question 5d*/
options symbolgen;
%let TYPE = Internet;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&TYPE";
   title "&TYPE Customers";
run;

/*Question 5e*/
options nosymbolgen;
%let TYPE = Internet;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&TYPE";
   title "&TYPE Customers";
run;

/*Question 6a*/
%let type=Gold;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type" AND 30 <= Customer_Age <= 45;
   title "&type Customers";
run;

/*Question 6b*/
%let type=Gold;
%let age1 = 30;
%let age2 = 45;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type" AND &age1 <= Customer_Age <= &age2;
   title "&type Customers";
run;

/*Question 6c*/
options symbolgen;
%let type=Gold;
%let age1 = 30;
%let age2 = 45;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type" AND &age1 <= Customer_Age <= &age2;
   title "&type Customers";
run;

/*Question 6d*/
options symbolgen;
%let type=Gold;
%let age1 = 25;
%let age2 = 40;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type" AND &age1 <= Customer_Age <= &age2;
   title "&type Customers";
run;

/*Question 6e*/
options nosymbolgen;
%let type=Gold;
%let age1 = 25;
%let age2 = 40;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type" AND &age1 <= Customer_Age <= &age2;
   title "&type Customers";
run;

/*Question 7a*/
%let pet1 = Paisley;
%let pet2 = Sitka;

/*Question 7b*/
%let pet1 = Paisley;
%let pet2 = Sitka;

%symdel pet1 pet2;

/*Question 7c*/
%let pet1 = Paisley;
%let pet2 = Sitka;

%symdel pet1 pet2;

%put &pet1 &pet2;

/*Question 8a*/
proc print data=orion.employee_payroll;
   where Employee_Hire_Date='01AUG2006'd;
   id Employee_ID;
   var Employee_Gender Employee_Hire_Date;
   title 'Personal Information for Employees Hired in AUG 2006';
run;

/*Question 8b*/
%let Month = AUG;
%let Year = 2006;
proc print data=orion.employee_payroll;
   where Employee_Hire_Date="01&Month&Year"d;
   id Employee_ID;
   var Employee_Gender Employee_Hire_Date;
   title "Personal Information for Employees Hired in &Month &Year";
run;

/*Question 8c*/
%let Month = JUL;
%let Year = 2003;
proc print data=orion.employee_payroll;
   where Employee_Hire_Date="01&Month&Year"d;
   id Employee_ID;
   var Employee_Gender Employee_Hire_Date;
   title "Personal Information for Employees Hired in &Month &Year";
run;

/*Question 9a*/
proc sort data=orion.staff out=staffhires;
   by Job_Title Emp_Hire_Date;
run;
data FirstHired;   
   set staffhires;
   by Job_Title;
   if First.Job_Title;  
run;
proc print data=FirstHired;
   id Job_Title;
   var Employee_ID Emp_Hire_Date;
   title "First Employee Hired within Each Job Title";  
run;

/*Question 9b*/
%let sen = First;
proc sort data=orion.staff out=staffhires;
   by Job_Title Emp_Hire_Date;
run;
data &sen;   
   set staffhires;
   by Job_Title;
   if &sen..Job_Title;  
run;
proc print data=&sen;
   id Job_Title;
   var Employee_ID Emp_Hire_Date;
   title "&sen Employee Hired within Each Job Title";  
run;

%let sen = Last;
proc sort data=orion.staff out=staffhires;
   by Job_Title Emp_Hire_Date;
run;
data &sen;   
   set staffhires;
   by Job_Title;
   if &sen..Job_Title;  
run;
proc print data=&sen;
   id Job_Title;
   var Employee_ID Emp_Hire_Date;
   title "&sen Employee Hired within Each Job Title";  
run;

/*Question 10a*/
%let fullname = Anthony Miller;

/*Question 10b*/
%let name=%substr(&fullname,1,1). %scan(&fullname,2); 
%put &name;

/*Question 11*/
%put %sysfunc(today(), MMDDYYP10.) and is %sysfunc(time(), TIMEAMPM.);

/*Question 12a*/
proc print data=orion.product_dim;
   where Product_Name contains "Jacket";
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing 'Jacket'";
run;

/*Question 12b*/
%let product = R&D;
proc print data=orion.product_dim;
   where Product_Name contains "&product";
   var Product_Name Product_ID Supplier_Name;
   title "Product Names Containing '&product'";
run;

/*Question 12c*/
%let product = R&D;
proc print data=orion.product_dim;
   where Product_Name contains "&product";
   var Product_Name Product_ID Supplier_Name;
   title1 "Product Names Containing '&product'";
   title2 "Report generated at %sysfunc(time(), TIMEAMPM.)";
   title3 "on %sysfunc(today(), MMDDYYP10.)";
run;

/*Question 13*/
%let DSN = work.test;
%let FIRST = %substr(&DSN., 1,1);
%put The value of ckbegin = %verify(&FIRST., &DSN.);

