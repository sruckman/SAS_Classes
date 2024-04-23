/*Assignment 15 Summary Reports 2*/
/*Sarah Ruckman*/

libname orion '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

/*Question 1*/
title1 "Orion Star Sales Analysis";
title2 "Catalog Sales Only";
footnote "Based on the previous day's posted data";
proc means data=orion.order_fact;
   where Order_Type=2;
   var Total_Retail_Price;
run;

title2 "Internet Sales Only";
footnote;
proc means data=orion.order_fact;
   where Order_Type=3;
   var Total_Retail_Price;
run;
title;

/*Question 2*/
%let currentdate=%sysfunc(today(),worddate.);
%let currenttime=%sysfunc(time(),timeampm.);

title "Sales Report as of &currenttime on &currentdate";
proc means data=orion.order_fact;
   var Total_Retail_Price;
run;
title;

/*Question 3*/
proc print data=orion.customer split ='*' label;
   where Country='TR';
   title 'Customers from Turkey';
   var Customer_ID Customer_FirstName Customer_LastName
       Birth_Date;
   label Customer_ID = 'Customer ID'
   		 Customer_FirstName = 'First*Name'
   		 Customer_LastName = 'Last*Name'
   		 Birth_Date = 'Birth Year';
   format Birth_Date year4.;
run;
title;

/*Question 4*/
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;

proc format;
   value $gender  'F' = 'Female'
                  'M' = 'Male';
run;

proc format;
	value moname 1 = January
				 2 = February
				 3 = March;
run;

proc freq data=Q1Birthdays;
   tables BirthMonth Employee_Gender;
   title 'Employees with Birthdays in Q1';
   format Employee_Gender $gender.
   		  BirthMonth moname.;
run;
title;

/*Question 5*/
proc format;
   value $gender  'F' = 'Female'
                  'M' = 'Male'
                  other = 'Invalid Code';
run;

proc format;
	value salrange 20000-< 100000 = 'Below $100,000'
				   100000-< 500000 = '$100,000 or more'
				   . = 'Missing Salary'
				   other = 'Invalid Salary';
run;

proc print data=orion.nonsales (obs=10);
   var Employee_ID Job_Title Salary Gender;
   title1 'Distribution of Salary and Gender Values';
   title2 'for Non-Sales Employees';
   format Gender $gender.
   		  Salary salrange.;
run;
title;

/*Question 6*/
proc sort data = orion.order_fact out = order;
	by Order_Type; 
run;

proc means data = order;
   var Total_Retail_Price;
   title 'Orion Star Sales Summary';
   where Order_Type = 2 or Order_Type = 3;
   by Order_Type;
run;
title;

/*Question 7*/
proc sort data = orion.order_fact out = orders;
	by Order_Type descending Order_Date;
run;

proc print data = orders;
   var Order_Type Order_ID Order_Date Delivery_Date ;
   title1 'Orion Star Sales Details';
   title2 '2-Day Deliveries from January to April 2005';
   by Order_type;
   where Order_Date between '01Jan2005'd and '30APR2005'd AND Delivery_Date = Order_Date+2 ;
run;
title;

/*Question 8*/
proc tabulate data=orion.customer_dim;
	title 'Ages of Customers by Group and Gender';
	class Customer_Group Customer_Gender;
	var Customer_Age;
	table Customer_Group*Customer_Gender all,
		  Customer_Age*(n mean);
run;
title;
