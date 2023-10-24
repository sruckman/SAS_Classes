/* Assignment 09 Manipulating Data */
/* Sarah Ruckman */

/*Question 1 */
/*Part A: Create two new variables, Increase and NewSalary. Increase is 10% of the Salary.   
NewSalary is increase added to salary.*/
title "Question 1 Part A";
libname q1 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data increase;
	set q1.staff;
	Increase = 0.1*Salary;
	NewSalary = Increase+Salary;
run;

/*Part B: The data set work.increase should include only the variables: 
Employee_ID, Salary, Increase, and NewSalary */
title "Question 1 Part B";
data increase (keep = Employee_ID Salary Increase NewSalary);
	set q1.staff;
	Increase = 0.1*Salary;
	NewSalary = Increase+Salary;
run;

/*Part C: Formats for displaying commas should be stored for Salary, Increase, and NewSalary*/
title "Question 1 Part C";
data increase (keep = Employee_ID Salary Increase NewSalary);
	set q1.staff;
	Increase = 0.1*Salary;
	NewSalary  = Increase+Salary;
	format Increase DOLLAR8. NewSalary DOLLAR8.;
run;

/*Part D: Include a PROC PRINT step in your program to display the data portion of the 
SAS data set work.increase*/
title "Question 1 Part D";
proc print data = increase;
run;

/*Question 2*/
/*Part A: Create three new variables: BDay2017, BDayBOW201, and Age2017*/
title "Question 2 Part A";
libname q2 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data birthday;
	set q2.customer;
	Bday2017 = mdy(month(Birth_Date),day(Birth_Date),2017);
	BdayDOW2017 = WEEKDAY(Bday2017);
	Age2017 = (Bday2017-Birth_Date)/365.25;
run;

/*Part B: The data set should include only the  variables: Customer_Name, 
Birth_Date, Bday2017, BdayDOW2017, and Age2017*/
title "Question 2 Part B";
data birthday (keep = Customer_Name Birth_Date Bday2017 BdayDOW2017 Age2017);
	set q2.customer;
	Bday2017 = mdy(month(Birth_Date),day(Birth_Date),2017);
	BdayDOW2017 = WEEKDAY(Bday2017);
	Age2017 = (Bday2017-Birth_Date)/365.25;
run;

/*Part C: Bday2017should be formatted to look like a two-digit day,
 a three-letter month, and a four-digit year*/
title "Question 2 Part C";
data birthday (keep = Customer_Name Birth_Date Bday2017 BdayDOW2017 Age2017);
	set q2.customer;
	Bday2017 = mdy(month(Birth_Date),day(Birth_Date),2017);
	BdayDOW2017 = WEEKDAY(Bday2017);
	Age2017 = (Bday2017-Birth_Date)/365.25;
	format Bday2017 DATE9.;
run;

/*Part D: Age2017 should be formatted to display no digits after the decimal point*/
title "Question 2 Part D";
data birthday (keep = Customer_Name Birth_Date Bday2017 BdayDOW2017 Age2017);
	set q2.customer;
	Bday2017 = mdy(month(Birth_Date),day(Birth_Date),2017);
	BdayDOW2017 = WEEKDAY(Bday2017);
	Age2017 = (Bday2017-Birth_Date)/365.25;
	format Bday2017 DATE9. Age2017 2.;
run;

/*Part E: Add a  PROC PRINT step to display the 23 observations of the data set*/
title "Question 2 Part E";
proc print data = birthday (obs=23);
run;


/*Question 3*/
/*Part A: Create  three new variables Discount, DiscountType and Region*/
title "Question 3 Part A";
libname q3 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data region;
	set q3.supplier;
	Discount = "";
	DiscountType = "";
	Region = "";
run;

/*Part B: IF country = CA or US*/
title "Question 3 Part B";
data region;
	set q3.supplier;
	if Country = "CA" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
	else if Country = "US" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
run;

/*Part C: If country is another value */
title "Question 3 Part C";
data region;
	set q3.supplier;
	format Region $18.;
	if Country = "CA" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
	else if Country = "US" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
	else do;
		Discount = 5;
		DiscountType = "Optional";
		Region = "Not North America";
	end;
run;

/*Part D: The data set work.region should include only the variables: 
Supplier_Name, Country, Discount, DiscountType, and Region*/
title "Question 3 Part D";
data region (keep = Supplier_Name Country Discount DiscountType Region);
	set q3.supplier;
	format Region $18.;
	if Country = "CA" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
	else if Country = "US" then do;
		Discount = 10;
		DiscountType = "Required";
		Region = "North America";
	end;
	else do;
		Discount = 5;
		DiscountType = "Optional";
		Region = "Not North America";
	end;
run;

/*Part E: Use a PROC PRINT step to display the data in work.region*/
title "Question 3 Part E";
proc print data =  region;
run;


/*Question 4*/
/*Part A: Create the new variable DayOfWeek, which is equal to the week day of Order_Date*/
title "Question 4 Part A";
libname q4 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data ordertype;
	set q4.orders;
	DayOfWeek = WEEKDAY(Order_Date);
run;

/*Part B: Create a new variable type*/
title "Question 4 Part B";
data ordertype;
	set q4.orders;
	format Type $14.;
	DayOfWeek = WEEKDAY(Order_Date);
	if Order_Type = 1 then Type = "Catalog Sale";
	else if Order_Type = 2 then Type = "Internet Sale";
	else if Order_Type = 3 then Type = "Retail Sale";
run;

/*Part C: Create the new variable SaleAds */
title "Question 4 Part C";
data ordertype;
	set q4.orders;
	format Type $14. SaleAds $5.;
	DayOfWeek = WEEKDAY(Order_Date);
	if Order_Type = 1 then do;
		Type = "Catalog Sale";
		SaleAds = "Mail";
	end;
	else if Order_Type = 2 then do;
		Type = "Internet Sale";
		SaleAds = "Email";
	end;
	else if Order_Type = 3 then Type = "Retail Sale";
run;

/*Part D: Data set work.ordertype should not include the variables 
Order_Type, Employee_ID, and Customer_ID*/
title "Question 4 Part D";
data ordertype (drop = Order_Type Employee_ID Customer_ID);
	set q4.orders;
	format Type $14. SaleAds $5.;
	DayOfWeek = WEEKDAY(Order_Date);
	if Order_Type = 1 then do;
		Type = "Catalog Sale";
		SaleAds = "Mail";
	end;
	else if Order_Type = 2 then do;
		Type = "Internet Sale";
		SaleAds = "Email";
	end;
	else if Order_Type = 3 then Type = "Retail Sale";
run;

/*Part E: Use a PROC PRINT step to display the first 25 observations of the data in work.ordertype*/
title "Question 4 Part E";
proc print data = ordertype (obs=25);
run;


/*Question 5*/
/*Part A: Create two new variables, Gift1 and Gift2, using a SELECT group with WHEN statements*/
title "Question 5 Part A";
libname q5 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data gifts;
	set q5.nonsales;
	Gift1 = "";
	Gift2 = "";
run;

/*Part B: If Gender is equal to F*/
title "Question 5 Part B";
data gifts;
	set q5.nonsales;
	select (Gender);
		when ('F') do;
		Gift1 = "Perfume";
		Gift2 = "Cookware";
	end;
	otherwise;
	end;
run;

/*Part C: IF Gender is equal to M*/
title "Question 5 Part C";
data gifts;
	set q5.nonsales;
	format Gift1 $7. Gift2 $14.;
	select (Gender);
		when ('F') do;
		Gift1 = "Perfume";
		Gift2 = "Cookware";
	end;
		when ('M') do;
		Gift1 = "Cologne";
		Gift2 = "Lawn Equipment";
	end;
	otherwise;
	end;
run;

/*Part D: If Gender is not equal to F or M*/
title "Question 5 Part D";
data gifts;
	set q5.nonsales;
	format Gift1 $7. Gift2 $14.;
	select (Gender);
		when ('F') do;
		Gift1 = "Perfume";
		Gift2 = "Cookware";
	end;
		when ('M') do;
		Gift1 = "Cologne";
		Gift2 = "Lawn Equipment";
	end;
	otherwise do;
		Gift1 = "Coffee";
		Gift2 = "Lawn Calendar";
	end;
	end;
run;

/*Part E: work.gifts should include only the variables: Employee_ID, First, Last, Gift1, and Gift2*/
title "Question 5 Part E";
data gifts (keep = Employee_ID First Last Gift1 Gift2);
	set q5.nonsales;
	format Gift1 $7. Gift2 $14.;
	select (Gender);
		when ('F') do;
		Gift1 = "Perfume";
		Gift2 = "Cookware";
	end;
		when ('M') do;
		Gift1 = "Cologne";
		Gift2 = "Lawn Equipment";
	end;
	otherwise do;
		Gift1 = "Coffee";
		Gift2 = "Lawn Calendar";
	end;
	end;
run;

/*Part F: Use a PROC PRINT step to display the first 27 records of work.gifts*/
title "Question 5 Part F";
proc print data = gifts (obs=27);
run;


/*Question 6*/
/*Part A: Use a where statement to select only the observations that 
have Emp_Hire_Date on or after July 1, 2006*/
title "Question 6 Part A";
libname q6 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data increase;
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
run;

/*Part B: Create a new variable increase that is 10% of salary*/
title "Question 6 Part B";
data increase;
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
	Increase = 0.1*Salary;
run;

/*Part C: Use the sum function to create a variable NewSalary that is the sum of salary and increase*/
title "Question 6 Part C";
data increase;
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
	Increase = 0.1*Salary;
	NewSalary = SUM(Increase,Salary);
run;

/*Part D: Use a subsetting IF statement to select only the observations 
that have an increase greater than 3000*/
title "Question 6 Part D";
data increase;
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
	Increase = 0.1*Salary;
	NewSalary = SUM(Increase,Salary);
	if Increase > 3000;
run;

/*Part E: Include a comma10. format for the variables Salary, Increase, and NewSalary*/
title "Question 6 Part E";
data increase;
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
	Increase = 0.1*Salary;
	NewSalary = SUM(Increase,Salary);
	if Increase > 3000;
	format Increase COMMA10. Salary COMMA10. NewSalary COMMA10.;
run;

/*Part F: work.increase should contain only the variables 
Employee_ID, Emp_Hire_Date, Salary, Increase, and NewSalary*/
title "Question 6 Part F";
data increase (keep = Employee_ID Emp_Hire_Date Salary Increase NewSalary);
	set q6.staff;
	where Emp_Hire_Date >= '01Jul2006'd;
	Increase = 0.1*Salary;
	NewSalary = SUM(Increase,Salary);
	if Increase > 3000;
	format Increase COMMA10. Salary COMMA10. NewSalary COMMA10.;
run;

/*Part G: Use a PROC PRINT step to display the data portion of work.increase*/
title "Question 6 Part G";
proc print data = increase;
run;


/*Question 7*/
/*Part A: Use the sum function to create the new variable Total, 
which is equal to sum of Qtr1, Qtr2, Qtr3, and Qtr4 */
title "Question 7 Part A";
libname q7 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data bigdonations;
	set q7.employee_donations;
	Total = SUM(Qtr1,Qtr2,Qtr3,Qtr4);
run;

/*Part B: Create a new variable NoDonation, which is equal to the count 
of missing values in Qtr1, Qtr2, Qtr3, and Qtr4.  Use the NMISS function. 
(google to find documentation on the nmiss function)*/
title "Question 7 Part B";
data bigdonations;
	set q7.employee_donations;
	Total = SUM(Qtr1,Qtr2,Qtr3,Qtr4);
	NoDonation = nmiss(of Qtr1,Qtr2,Qtr3,Qtr4);
run;

/*Part C: The data set should contain only observations meeting the following two conditions:
Total values greater than or equal to 50
NoDonation values equal to 0*/
title "Question 7 Part C";
data bigdonations;
	set q7.employee_donations;
	Total = SUM(Qtr1,Qtr2,Qtr3,Qtr4);
	NoDonation = nmiss(of Qtr1,Qtr2,Qtr3,Qtr4);
	if (Total < 50) OR (NoDonation not = 0) then delete;
run;

/*Part D: Use a PROC PRINT step to display the data portion of work.bigdonations.  
Only print the variables: Employee_ID, Qtr1, Qtr2, Qtr3, Qtr4, Total, and NoDonation */
title "Question 7 Part D";
proc print data = bigdonations;
	var Employee_ID Qtr1 Qtr2 Qtr3 Qtr4 Total NoDonation;
run;


/*Question 8*/
/*Part A: Include a keep option in the set statement to keep only the variables 
SEQN, DMARETHN, HSSEX, HSAGEIR, HAD1, HAD3, HAD4 */
title "Question 8 Part A";
libname q8 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

data diabetes;
	set q8.adult;
	keep SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4;
run;

/*Part B: Include a drop option in the data statement to drop HAD1, HAD3, and HAD4 on work.diabetes*/
title "Question 8 Part B";
data diabetes (drop = HAD1 HAD3 HAD4);
	set q8.adult;
	keep SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4;
run;

/*Part C: Drop any observations for which HAD1 is neither 1 nor 2*/
title "Question 8 Part C";
data diabetes (drop = HAD1 HAD3 HAD4);
	set q8.adult;
	keep SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4;
	if HAD1 > 2 then delete;
run;

/*Part D: Define a new variable diabetic that is 1, if had1 is 1 and 0 otherwise*/
title "Question 8 Part D";
data diabetes (drop = HAD1 HAD3 HAD4);
	set q8.adult;
	keep SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4 diabetic;
	if HAD1 > 2 then delete;
	if HAD1 = 1 then diabetic =1;
	else diabetic = 0;
run;

/*Part E: If the patient is female (hssex=2) and diabetic=1 and had4=2 
then diabetic should be changed to 0 */
title "Question 8 Part E";
data diabetes /*(drop = HAD1 HAD3 HAD4)*/;
	set q8.adult;
	keep SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4 diabetic;
	if HAD1 > 2 then delete;
	if HAD1 = 1 then diabetic = 1;
	else diabetic = 0;
	if (HSSEX = 2) AND (diabetic = 1) AND (HAD4 = 2) then diabetic = 0;
run;

/*Part F: Use a PROC FREQ step to obtain a one-way frequency of the variable diabetic.  
The correct number of diabetics (diabetic=1) is 1509 */
title "Question 8 Part F";
proc freq data = diabetes;
tables diabetic;
run;


