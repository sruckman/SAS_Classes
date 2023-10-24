/*Assignment 13 Combining Data Sets*/
/*Sarah Ruckman*/

/*Exercise 1*/
/*Q1: Use two data steps to read in price_current and price_new*/
libname hw13 "/home/u62104146/my_shared_file_links/jhshows0/STA5066";

title "Exercise 1 Q1";
data current;
	set hw13.price_current;
run;

data new;
	set hw13.price_new;
run;

/*Q2: Use Proc Contents*/
title "Exercise 1 Q2 Current";
proc contents data = current details;
run;
title "Exercise 1 Q2 New";
proc contents data = new details;
run;
/*Current has 171 obs while new has 88 obs*/

/*Q3: Proc APPEND step to append new and current*/
title "Exercise 1 Q3";
proc append base = current data = new force;
run;

/*Q4: Proc contents to examine current*/
title "Exercise 1 Q4";
proc contents data = current details;
run;
/*259 data points*/

/*Exercise 2*/
/*Q1: Proc Contents of qtr1_2007 and qtr2_2007*/
title "Exercise 2 Q1 qtr1";
proc contents data = hw13.qtr1_2007 details;
run;

title "Exercise 2 Q1 qtr2";
proc contents data = hw13.qtr2_2007 details;
run;
/*Employee_ID is missing from qtr1*/

/*Q2: Proc append qtr1 to new data set ytd*/
title "Exercise 2 Q2";
data ytd;
input Order_ID Order_Type Customer_ID Order_Date Delivery_Date @@;
datalines;
run;

proc append base = ytd data = hw13.qtr1_2007 force;
run;

/*Q3: Proc Contents of ytd*/
title "Exercise 2 Q3";
proc contents data = ytd details;
run;

/*Q4: Proc Append qtr2 to ytd*/
title "Exercise 2 Q4";
proc append base = ytd data = hw13.qtr2_2007 force;
run;

proc contents data = ytd details;
run;

/*Exercise 3*/
/*Q1: Proc contents for mnth7, mnth8, and mnth9*/
title "Exercise 3 Q1 mnth7";
proc contents data = hw13.mnth7_2007 details;
run;
title "Exercise 3 Q1 mnth8";
proc contents data = hw13.mnth8_2007 details;
run;
title "Exercise 3 Q1 mnth9";
proc contents data = hw13.mnth9_2007 details;
run;
/*mnth7 has 10 obs, mnth8 has 12 obs, and mnth9 has 10 obs*/

/*Q2: Data step to concatenate the three data sets*/
title "Exercise 3 Q2";
data thirdqtr;
	set hw13.mnth7_2007 hw13.mnth8_2007 hw13.mnth9_2007;
run;

/*Q3: Proc contents of thirdqtr*/
title "Exercise 3 Q3";
proc contents data = thirdqtr details;
run;

/*Exercise 4*/
/*Q1: Proc contents sales and nonsales*/
title "Exercise 4 Q1 Sales";
proc contents data = hw13.sales details;
run;
title "Exercise 4 Q1 Nonsales";
proc contents data = hw13.nonsales details;
run;

/*Q2: Data step to concatenate sales and nonsales*/
title "Exercise 4 Q2";
data allemployees;
	set hw13.sales hw13.nonsales (rename = (First = First_Name Last = Last_Name));
run;

/*Q3: work.allemployees should include only the following five variables: 
Employee_ID, First_Name, Last_Name, Job_Title, and Salary */
title "Exercise 4 Q3";
data allemployees (keep = Employee_ID First_Name Last_Name Job_Title Salary);
	set hw13.sales hw13.nonsales (rename = (First = First_Name Last = Last_Name));
run;

/*Q4: proc print first 100 obs*/
title "Exercise 4 Q4";
proc print data = allemployees (obs = 100);
run;

/*Exercise 5*/
/*Q1: Proc contents*/
title "Exercise 5 Q1 payroll";
proc contents data = hw13.employee_payroll details;
run;

title "Exercise 5 Q1 addresses";
proc contents data = hw13.employee_addresses details;
run;
/*Payroll has 424 obs and 8 variables while addresses has 424 obs and 9 variables*/

/*Q2: Proc sort payroll by ascending order of employee_id*/
title "Exercise 5 Q2";
proc sort data=hw13.employee_payroll out=payroll;  
	by Employee_ID;
run;

/*Q3: Proc sort addresses by ascending order of employee_id*/
title "Exercise 5 Q3";
proc sort data=hw13.employee_addresses out=addresses;  
	by Employee_ID;
run;

/*Q4: Data step to merge by Employee_ID*/
title "Exercise 5 Q4";
data payadd;
	merge payroll addresses;
	by Employee_ID;
run;

/*Q5: Proc contents of payadd*/
title "Exercise 5 Q5";
proc contents data = payadd details;
run;

/*Exercise 6*/
/*Q1: proc sort addresses by Employee_ID*/
title "Exercise 6 Q1";
proc sort data=hw13.employee_addresses out=addresses;  
	by Employee_ID;
run;

/*Q2: Proc sort payroll by Employee_ID*/
title "Exercise 6 Q2";
proc sort data=hw13.employee_payroll out=payroll;  
	by Employee_ID;
run;

/*Q3: Proc sort organizations by Employee_ID*/
title "Exercise 6 Q3";
proc sort data=hw13.employee_organization out=organization;  
	by Employee_ID;
run;

/*Q4: Proc contents of all data sets*/
title "Exercise 6 Q4 Addresses";
proc contents data = addresses details;
run;
title "Exercise 6 Q4 Payroll";
proc contents data = payroll details;
run;
title "Exercise 6 Q4 Organization";
proc contents data = organization details;
run;
/*Addresses has 424 obs with 8 variables, payroll has 424 obs with 9 variables, and
organization has 424 obs with 4 variables*/

/*Q5: Data step to merge data sets*/
title "Exercise 6 Q5";
data payaddorg;
	merge addresses payroll organization;
	by Employee_ID;
run;

/*Q6: Proc print and verify*/
title "Exercise 6 Q6";
proc print data = payaddorg;
run;
/*There are 424 obs with 19 variables*/

/*Exercise 7*/
/*Q1: Proc sort list by supplier_id*/
title "Exercise 7 Q1";
proc sort data = hw13.product_list out = product;
	by Supplier_ID;
run;

/*Q2: Proc sort supplier by supplier_id*/
title "Exercise 7 Q2";
proc sort data = hw13.supplier out = suppliersort;
	by Supplier_ID;
run;

/*Q3: Data step to merge by supplier_id*/
title "Exercise 7 Q3";
data prodsup;
	merge product(in = onprod) suppliersort(in = onsup);
	by Supplier_ID;
	if onprod ne 1 or onsup ne 1;
run;

/*Q4: Proc print to verify supplier_id is missing*/
title "Exercise 7 Q4";
proc print data = prodsup;
run;
/*75 obs with 10 variables and missing Supplier_IDs*/

/*Exercise 8*/
/*Q1: Proc Print lookup_country*/
title "Exercise 8 Q1";
proc print data = hw13.lookup_country;
run;

/*Q2: Proc print customer*/
title "Exercise 8 Q2";
proc print data = hw13.customer;
run;

/*Q3: Proc sort customer by country*/
title "Exercise 8 Q3";
proc sort data = hw13.customer out = customer;
	by Country;
run;

/*Q4: Data step to merge data*/
title "Exercise 8 Q4";
data allcustomer;
	merge customer(in = cust) hw13.lookup_country(rename = (Start = Country Label = Country_Name) in = coun);
	by Country;
	if cust = 1 and coun = 1;
run;

/*Q5: Proc print to verify all 77 obs*/
title "Exercise 8 Q5";
proc print data = allcustomer;
run;

/*Exercise 9*/
/*Q1: Proc sort labsub2 by seqn*/
title "Exercise 9 Q1";
proc sort data = hw13.labsub2 out = lab;
	by seqn;
run;

/*Q2: Proc sort examsub2 by seqn*/
title "Exercise 9 Q2";
proc sort data = hw13.examsub2 out = exam;
	by seqn;
run;

/*Q3: Data step to merge by seqn and construct three data sets*/
title "Exercise 9 Q3";
data ExamOnly LabOnly LabAndExam;
	merge lab (in = onlab) exam (in = onexam);
	by seqn;
	if onlab = 0 and onexam = 1 then output ExamOnly;
	if onlab = 1 and onexam = 0 then output LabOnly;
	if onlab = 1 and onexam = 1 then output LabAndExam;
run;

/*Q4: Proc contents to determine number of obs and variables for each data set*/
title "Exercise 9 Q4 ExamOnly";
proc contents data = ExamOnly details;
run;
title "Exercise 9 Q4 LabOnly";
proc contents data = LabOnly details;
run;
title "Exercise 9 Q4 LabAndExam";
proc contents data = LabAndExam details;
run;
/*ExamOnly has no obs and 19 variables, LabOnly has 11152 obs with 19 variables, and 
LabAndExam has 18162 obs and 19 variables*/
