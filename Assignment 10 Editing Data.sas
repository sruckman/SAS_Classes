/* Assignment 10 Editing Data */
/* Sarah Ruckman */

/*Question 1 */
/*Part A: Use a PROC PRINT step to list the observations that do not meet both of the 
following requirements: Product_Category must not be missing and Supplier_Country must 
have a value of GB or US */
title "Question 1 Part A";
libname q1 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data shoes;
	set q1.shoes_tracker;
run;

proc print data = shoes;
	where Product_Category IS MISSING or
		  Supplier_Country not in ('GB','US');
run;

/*Part B: Use a PROC FREQ step with a TABLES statement to create frequency tables 
for Supplier_Name and Supplier_ID. Include the NLEVELS option*/
title "Question 1 Part B";
proc freq data=shoes nlevels;
	tables Supplier_Name Supplier_ID;
run;

/*Part C: Use a PROC PRINT step with a WHERE statement to display observations
  for which  Product_Name is not in proper case (use the propcase function)*/
title "Question 1 Part C";
proc print data = shoes;
	where Product_Name not= propcase(Product_Name);
run;

/*Part D: The following table identifies data errors that need to be corrected
 The table also notes the correct values.  Use a data step to create a file 
 work.shoes_tracker in which the errors have been corrected*/
title "Question 1 Part D";
libname q1 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data clean_shoes;
	set q1.shoes_tracker;
	Supplier_Country = upcase(Supplier_Country);
	if Supplier_Country = 'UT' then Supplier_Country = 'US';
	if Product_Category = '' then Product_Category = 'Shoes';
	if Supplier_ID = . then Supplier_ID = 2963;
	else if Supplier_Name = '3op Sports' then Supplier_Name = '3Top Sports';
	if _N_ = 9 then Supplier_Name = 'Greenline Sports Ltd';
	else if _N_ = 4 then Product_ID = 220200300079;
	else if _N_ = 8 then Product_ID = 220200300129;
	else if _N_ = 3 then Product_Name = propcase(Product_Name);
run;

proc print data = clean_shoes;
run;


/*Question 2*/
/*Part A: Use a data step to create a new dataset work.qtr2*/
title "Question 2 Part A";
libname q2 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data qtr2;
	set q2.qtr2_2007;
run;

/*Part B: Use a print step to print observations on work.qtr2 that do not meet both of the requirements:
Delivery_Date values must be equal to or greater than Order_Date values. 
Order_Date values must be in the range of April 1, 2007 – June 30, 2007.*/
title "Question 2 Part B";
proc print data = qtr2;
	where Delivery_Date not>= Order_Date or
	Order_Date not between '01APR2007'd AND '30JUN2007'd;
run;

/*Part C: Use a PROC FREQ step with work.qtr2 and a TABLES statement to create frequency tables for Order_ID
 and Order_Type. Include the NLEVELS option*/
title "Question 2 Part C";
proc freq data=qtr2 nlevels;
	tables Order_ID Order_Type;
run;

/*Part D: The data on work.qtr2 should meet the following requirements:
Order_ID must be unique (36 distinct values) and not missing.  
Use a proc freq step to check this requirement */
title "Question 2 Part D";
proc freq data=qtr2 nlevels;
	tables Order_ID;
run;
/*Two values are missing making 35 distinct values rather than 36 levels */

proc print data = qtr2;
	where Order_Type not in (1,2,3);
run;
/*Two values are outside of the range*/

/*Part E: Correct the invalid data on work.qtr2*/
title "Question 2 Part E";
libname q2 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data clean_qtr2;
	set q2.qtr2_2007;
	if Order_ID=1242012259 then Delivery_Date = '12MAY2007'd;
	else if Order_ID=1242449327 then Order_Date = '26JUN2007'd;
	if _N_ = 18 then Order_ID = 1241895587;
	else if _N_ = 19 then Order_ID = 1241895564;
	else if _N_ = 2 then Order_Type = 3;
	else if _N_ = 10 then Order_Type = 3;
run;

proc print data = clean_qtr2;
run;

/*Part F: f.	Use your previously written programs (above) to 
verify that the data on work.qtr meet all of the data set requirements.*/
title "Question 2 Part F";
proc print data = clean_qtr2;
	where Delivery_Date not>= Order_Date or
	Order_Date not between '01APR2007'd AND '30JUN2007'd;
run;

proc freq data=clean_qtr2 nlevels;
	tables Order_ID;
run;

proc print data = clean_qtr2;
	where Order_Type not in (1,2,3);
run;
/*No values before 01APR2007 or after 30JUN2007, no missing values in Order_ID, 
and no values less than 1 or greater than 3 in Order_type */

/*Question 3*/
/*Part A: Use a PROC CONTENTS step to examine the variables on the price_current
 data set, in particular, their type (numeric or character)*/
title "Question 3 Part A";
libname q3 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data price;
	set q3.price_current;
run;

proc contents data = price details;
run;
/*All variables are numeric*/

/*Part B: Use a PROC PRINT step to print observations with missing values for 
any of the variables Unit_Cost_Price, Unit_Sales_Price, or Factor */
title "Question 3 Part B";
proc print data = price;
	where Unit_Cost_Price IS MISSING or
		  Unit_Sales_Price IS MISSING or
		  Factor IS MISSING;
run;

/*Part C: Use a PROC MEANS step to determine whether there are observations 
with the values of the variables Unit_Cost_Price, Unit_Sales_Price, and Factor  
that do not meet the following requirements.  Use a VAR statement to restrict 
the analyses to these variables */
title "Question 3 Part C";
proc means data = price n nmiss min max;
	var Unit_Cost_Price Unit_Sales_Price Factor;
run;
/*The max for Unit_Sales_Price is well over 800 and the range for factor is far off*/

/*Part D: Use a PROC UNIVARIATE step with a VAR statement to obtain the extreme 
observations of  Unit_Sales_Price and Factor. Use an ODS SELECT statement 
to only display the extreme values*/
title "Question 3 Part D";
ods select extremeobs;
proc univariate data = price;
	var Unit_Sales_Price Factor;
run;

/*Part E: Use a DATA step to create a data set work.price_current that corrects the 
errors shown in the following table*/
title "Question 3 Part E";
data price_current;
	set q3.price_current;
	if Product_ID=220200200022 then Unit_Sales_Price = 57.30;
	else if Product_ID=240200100056 then Unit_Sales_Price = 41.20;
	if _N_ = 14 then Factor = 1.0;
	else if _N_ = 170 then Factor = 1.02;
	else if _N_ = 134 then Factor = 1.0;
run;

proc print data = price_current;
run;

/*Question 4*/
/*Part A: Use a PROC CONTENTS step with the position option to find the 
order of the variables on the data set*/
title "Question 4 Part A";
libname q4 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data lab;
	set q4.labsub1;
run;

proc contents position;
run;

/*Part B: Use a PROC MEANS step to find the mean of all the variables except seqn 
on the data set.  In the VAR statement use a varlist to denote all of the variables 
other than seqn*/
title "Question 4 Part B";
proc means data = lab mean;
	var HGP	HTP TCP TGP LCP HDP FBPSI CRP SGP URP;
run;

/*Part C: Examine maximum values for the variables in the results of the PROC MEANS 
step to identify “fill values.” A fill value will be a whole number consisting entirely 
of 8’s (e.g. 8, 888,  etc.) and are used to designate missing values*/
title "Question 4 Part C";
proc means data = lab mean max;
	var HGP	HTP TCP TGP LCP HDP FBPSI CRP SGP URP;
run;

/*Part D: Use a DATA step to create a new dataset work.labsub2 that replaces all of the 
fill values for all of the variables with ., the SAS missing value*/
title "Question 4 Part D";
data labsub2;
	set q4.labsub1;
	if HGP = 88888 then HGP = .;
	if HTP = 88888 then HTP = .;
	if TCP = 888 then TCP = .;
	if TGP = 8888 then TGP = .;
	if LCP = 888 then LCP = .;
	if HDP = 888 then HDP = .;
	if FBPSI = 8888 then FBPSI = .;
	if CRP = 88888 then CRP = .;
	if SGP = 888 then SGP = .;
	if URP = 88888 then URP = .;
run;

/*Part E: Use a PROC MEANS step with work.labsub2 to verify that the fill values 
have been replaced*/
title "Question 4 Part E";
proc means data = labsub2 mean max nmiss;
	var HGP	HTP TCP TGP LCP HDP FBPSI CRP SGP URP;
run;
