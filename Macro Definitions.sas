/*HW 12 Defining Macros*/
%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
proc print data=orion.customer_dim;
   var Customer_Group Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains 'Gold';
   title 'Gold Customers';
run;

/*Question 1b*/
%let TYPE = Gold;
proc print data=orion.customer_dim;
   var Customer_Group Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&TYPE";
   title "&TYPE Customers";
run;

/*Question 1c*/
options mcompilenote=all;
%macro CUSTOMERS;
	proc print data=orion.customer_dim;
	   var Customer_Group Customer_Name Customer_Gender Customer_Age;
	   where Customer_Group contains "&TYPE";
	   title "&TYPE Customers";
run;
%mend CUSTOMERS;
options mcompilenote=none;

/*Question 1d*/
%let TYPE = Gold;
%CUSTOMERS

/*Question 1e*/
%let TYPE = Internet;
%CUSTOMERS

/*Question 1f*/
options mprint;
%let TYPE = Internet;
%CUSTOMERS
options nomprint;

/*Question 2a*/
proc means data=orion.staff sum mean;
   var Salary;
   class Job_Title;
   where Job_Title contains "Sales";
   title "Summary Statistics for the Sales Group";
run;

/*Question 2b*/
%macro SUMSTATS;
	%let TITLE = sales;
	proc means data=orion.staff sum mean;
	   var Salary;
	   class Job_Title;
	   where upcase(Job_Title) contains "%upcase(&TITLE)";
	   title "Summary Statistics for the &TITLE Group";
	run;
%mend SUMSTATS;

%SUMSTATS

/*Question 2c*/
%macro SUMSTATS;
	%let TITLE = sales;
	proc means data=orion.staff sum mean;
	   var Salary;
	   class Job_Title;
	   where upcase(Job_Title) contains "%upcase(&TITLE)";
	   title "Summary Statistics for the %sysfunc(propcase(&TITLE)) Group";
	run;
%mend SUMSTATS;

%SUMSTATS

/*Question 3a*/
%macro FUTURE;
	%let DAYMON = %substr(&sysdate9,1,5);
	%let lastyear = %substr(&sysdate9,6);
	%let YEAR = %eval(&lastyear+1);
	%let FUTUREDATE = &DAYMON&YEAR;
	&sysdate9 to &FUTUREDATE;
%mend FUTURE;

/*Question 3b*/
proc print data=orion.customer_dim(obs=10);
   var Customer_Name Customer_Group;
   title "Date range of %FUTURE";
run;

/*Question 4a*/
%macro customer;
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
   title "&type Customers";
run;
%mend customer;

/*Question 4b*/
options mcompilenote=all;
%macro customer(type);
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
   title "&type Customers";
run;
%mend customer;
options mcompilenote=none;

/*Question 4c*/
%customer(Gold)

/*Question 4d*/
%customer(Catalog)

/*Question 4e*/
options mcompilenote=all;
%macro customer(type = Club);
proc print data=orion.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains "&type";
   title "&type Customers";
run;
%mend customer;
options mcompilenote=none;

/*Question 4f*/
%customer(type=Internet)

/*Question 4g*/
%customer()

/*Question 5a*/
proc sgplot data=orion.customer_dim;
   vbar Customer_Age_Group/
   fillattrs=( color=red transparency=.25);
run;

/*Question 5b*/
%macro bars(bar = vbar, col = red, trans = 0.25);
	proc sgplot data=orion.customer_dim;
		&bar Customer_Age_Group/
	   fillattrs=(color=&col transparency=&trans);
	run;
%mend bars;

/*Question 5c*/
%bars()

/*Question 5d*/
%bars(bar = hbar,col = blue, trans = 0.5)

/*Question 5e*/
%bars(trans = 0.75)

/*Question 6a*/
%macro specialchars(name);
   proc print data=orion.employee_addresses;
      where upcase(Employee_Name)="%upcase(&name)";
      var Employee_ID Street_Number Street_Name City State  
          Postal_Code;
      title "Data for &name";
   run;
%mend specialchars;

/*Question 6b*/
%specialchars(%str(Abbott, Ray))