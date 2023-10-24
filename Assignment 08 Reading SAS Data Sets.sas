/* Assignment 08 Reading Raw Data */
/* Sarah Ruckman */

/*Question 1 */
/*Part A: Write a DATA step that reads the raw data file and creates a SAS data set work.newemps */
title "Question 1 Part A";
filename newemps '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/newemps.csv';

data work.newemps;
   infile newemps dlm=",";
   length LastName $18 FirstName $12 Title $25 Salary 8;
   input LastName $ FirstName $ Title $ Salary;
run; 

/*Part B: Include a PROC CONTENTS step in your program to verify that there are 71 observations */
title "Question 1 Part B";
proc contents data = work.newemps details;
run;
/*71 observations read in*/

/*Part C: Include a PROC PRINT step in your program to print the first 7 records on the SAS data set work.emps 
and verify that the values are correct */
title "Question 1 Part C";
proc print data = work.newemps (obs=7);
run;
/*Data sets match*/

/*Question 2*/
/*Part A: Write a DATA step to read this file and create a SAS data set named
 work.Donation by reading the space delimited raw data file*/
title "Question 2 Part A";
filename Donation '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/donation.dat';

data work.Donation;
   infile Donation dlm=" ";
   length IDNum $6 Q1 8 Q2 8 Q3 8 Q4 8;
   input IDNum $ Q1 Q2 Q3 Q4;
run; 

/*Part B: Include a PROC CONTENTS step to verify that there are 124 observations */
title "Question 2 Part B";
proc contents data = work.Donation details;
run;
/*124 observations read in*/

/*Part C: Include a PROC PRINT step to print the first 10 observations 
on the data set work.Donation to verify that the values are correct */
title "Question 2 Part C";
proc print data = work.Donation (obs=10);
run;
/*Data sets match*/


/*Question 3*/
/*Part A: Write a DATA step to read this file and create a SAS data set named work.supplier */
title "Question 3 Part A";
filename supplier '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/supplier.dat';

data work.supplier;
   infile supplier;
   input ID 1-5
   		 Name $ 8-37
   		 Country $ 40-41;
run; 

/*Part B: Include a PROC CONTENTS step to verify that there are 52 observations */
title "Question 3 Part B";
proc contents data = work.supplier details;
run;
/*52 observations read in*/

/*Part C: c.	Include a PROC PRINT step to print the first 5 observations 
on the data set work.supplier to verify that the values are correct */
title "Question 3 Part C";
proc print data = work.supplier (obs=5);
run;
/*Data sets match*/


/*Question 4 */
/*Part A: Write a DATA step to read the raw data file and create a SAS data set work.canada
 The data step should translate the birth dates to SAS dates */
title "Question 4 Part A";
filename canada '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/custca.csv';

data work.canada;
   infile canada dlm=",";
   length First $20 Last $20 ID 8 Gender $1 Age 8 AgeGroup $12;
   input First $ Last $ ID Gender $ BirthDate DDMMYY10. Age AgeGroup $;
run; 

/*Part B: Write a PROC CONTENTS step to verify that the SAS data set work.canada has 15 observations*/
title "Question 4 Part B";
proc contents data = work.canada details;
run;
/*Data set has 15 obs*/

/*Part C: Write a PROC PRINT to print the first three observations 
and verify that the birth dates were translated to SAS dates */
title "Question 4 Part C";
proc print data = canada (obs = 3);
run;
/*Data sets match and birth dates are SAS dates*/

/*Part D: Write a second PROC PRINT step to print the first three observations. 
The step should include a format statement to display the birth dates in the same format they were 
on the raw data file.  Use these results to verify that the correct values are in the SAS data 
set work.canada */
title "Question 4 Part D";
proc print data=canada (obs = 3);
format BirthDate DDMMYY10.;
run;
/*Birth Date is in the right format*/


/*Question 5*/
/*Part A: Write a DATA step to read this data and create a SAS data set work.sales */
title "Question 5 Part A";
filename sales '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/sales1.dat';

data work.sales;
   infile sales;
   input id 1-6
   		 FirstName $ 8-20
   		 LastName $ 21-38
   		 Gender $ 40-40
   		 JobTitle $ 43-62
   		 @64 salary DOLLAR8.
   		 country $ 73-74
   		 @76 BirthDate MMDDYY10.
   		 @87 HireDate MMDDYY10.;
run; 

/*Part B: Include a PROC CONTENTS step to verify that the SAS data set work.sales has 165 observations */
title "Question 5 Part B";
proc contents data = sales details;
run;
/*Data set has 165 obs*/

/*Part C: Include a PROC PRINT step to examine the first six records on the SAS data set work.sales*/
title "Question 5 Part C";
proc print data = sales (obs = 6);
run;

/*Part D: Include a second PROC PRINT step to  examine the first six records on the SAS data 
set work.sales. Include a format statement to display the variables in the same format they 
were on the raw data file to verify that the first six observations are correct*/
title "Question 5 Part D";
proc print data=sales (obs = 6);
format BirthDate MMDDYY10. HireDate MMDDYY10. Salary DOLLAR8.;
run;
/*Dates are in the correct format*/


/*Question 6*/
/*Part A: Write a DATA step that uses the raw data file, to create a new SAS data set work.staff2 
that contains the variables on the raw data file*/
title "Question 6 Part A";
filename staff2 '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/sales2.dat';

data staff2;
	infile staff2;
	input @1 ID 6.
		  @8 FirstName $12.
		  @21 LastName $18.;
	input @1 JobTitle $20.
		  @22 HireDate MMDDYY10. 
		  @33 Salary DOLLAR8.;
	input @1 Gender $1.
		  @3 BirthDate MMDDYY10.
		  @14 Country $2.;
run;

/*Part B: Include a PROC PRINT step to display the SAS dataset work.staff2*/
title "Question 6 Part B";
proc print data = staff2;
run;

/*Part C: Include a second PROC PRINT step to display the first two records on the SAS dataset 
work.staff2.  Include a format statement to assure the variable display as they were on the raw 
data file and verify that these two records contain the correct values*/
title "Question 6 Part C";
proc print data=staff2 (obs = 2);
format BirthDate MMDDYY10. HireDate MMDDYY10. Salary DOLLAR8.;
run;
/*Dates are in the correct format*/


/*Question 7*/
/*Part A: Write a DATA step to create a file work.sales that contains the information 
in the raw data file.  Each employees data should be in a single observation */
title "Question 7 Part A";
filename sales '/home/u62104146/my_shared_file_links/jhshows0/Data Sets/sales3.dat';

data sales;
	infile sales;
	input @1 ID 6.
		  @8 FirstName $12.
		  @21 LastName $18.
		  @40 Gender $1.
		  @43 JobTitle $20.;
	input @10 Country $2. @;
	if Country = 'AU' then
		input @1 Salary DOLLARX8.
			  @13 BirthDate DDMMYY10.
			  @24 HireDate DDMMYY10.;
	else if Country = 'US' then 
		input @1 Salary DOLLAR8.
			  @13 BirthDate MMDDYY10.
			  @24 HireDate MMDDYY10.;
run;

/*Part B: Include a PROC CONTENTS step to examine the descriptor portion on the work.sales data set*/
title "Question 7 Part B";
proc contents data = sales details;
run;

/*Part C: Include a PROC PRINT step that prints the first 10 Australian Employees*/
title "Question 7 Part C";
proc print data = sales (obs = 10);
	where Country = "AU";
	format BirthDate DDMMYY10. HireDate DDMMYY10. Salary DOLLARX8.;
run;

/*Part D: Include a second PROC PRINT step that prints the first 15 U.S. Employees*/
title "Question 7 Part D";
proc print data = sales (obs = 15);
	where Country = "US";
	format BirthDate MMDDYY10. HireDate MMDDYY10. Salary DOLLAR8.;
run;
