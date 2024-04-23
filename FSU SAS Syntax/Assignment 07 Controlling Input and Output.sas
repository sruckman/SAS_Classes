/* Assignment 07 Controlling Input and Output */
/* Sarah Ruckman */

/*Question 1 */
/*Part A: create a library called prg, that points to the directory on which the data set prg.discount2016 is located */
title "Question 1 Part A";
libname prg '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a proc contents step to examine the labels of the variables 
as well as the formats they are to be displayed with */
title "Question 1 Part B";
proc contents data = prg.discount2016 details;
run;

/*Part C: Use a proc print step to print the first 7 observations on the data set prg.discount2016 */
title "Question 1 Part C";
proc print data = prg.discount2016 (obs=7) label;
run;

/*Part D: Use a data step to create a new data set work.extended that contains all discounts for the Holidays Bonus */
title "Question 1 Part D";
data extended;
	set prg.discount2016;
	where Start_Date = '01DEC2016'd;
	Promotion = 'Holiday Bonus';
	Season = 'Winter';
	output;
	format Start_Date DATE9. End_Date DATE9.;
	Start_Date = '01Jul2017'd;
	End_Date = '31Jul2017'd;
	Season = 'Summer';
	drop Unit_Sales_Price;
   	output;
run;

/*Part E: Use a proc print step to display the data set */
title "Question 1 Part E";
proc print data = extended;
run;


/*Question 2 */
/*Part A: Create a library, lands, that points to the location of the dataset country */
title "Question 2 Part A";
libname lands '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a proc print step to examine the data set */ 
title "Question 2 Part B";
proc print data = lands.country;
run;

/*Part C: Use a data step to create a new data set work.new_country */
title "Question 2 Part C";
data new_country;
	set lands.country;
	if Country_FormerName = 'East/West Germany' then Country_Name = 'East/West Germany';
	if Country_FormerName = 'East/West Germany' then Outdated = 'Y';
	else Outdated = 'N';
run;

/*Part D: Use a proc print step to display the data set */
title "Question 2 Part D";
proc print data = new_country;
run;


/*Question 3 */
/*Part A: Define a library, nh3, that points to the location of the adultdemographics data set. */
title "Question 3 Part A";
libname nh3 '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a single data step to read nh3.adultdemographics to create two data sets, 
work.males containing only male participants and work.females containing only female participants
1 = male and 2 = female */
title "Question 3 Part B";
data males females;
	set nh3.adultdemographics;
	select (sex);
	 when (1) output males;
	 when (2) output females;
   end;
run;

/*Part C: The variable sex should not be on either of the two data sets created*/
title "Question 3 Part C";
data males females;
	set nh3.adultdemographics;
	drop sex;
	select (sex);
	 when (1) output males;
	 when (2) output females;
   end;
run;

/*Part D: Use two proc print steps to list the first 3 observations on each of the created data sets*/
title "Question 3 Part D Males";
proc print data = males (obs= 3);
run;

title "Question 3 Part D Females";
proc print data = females (obs=3);
run;

/*Part E: Use two proc contents steps to verify that variable sex is not on either data set*/
title "Question 3 Part E Males";
proc contents data = males details;
run;

title "Question 3 Part E Females";
proc contents data = females details;
run;

/*Question 4 */
/*Part A: Define a library, fact, that points to the directory containing the data set orders */
title "Question 4 Part A";
libname fact '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a proc contents step to examine the contents of the dataset fact.orders */
title "Question 4 Part B";
proc contents data = fact.orders details;
run;

/*Part C: Use a proc print step to display the first 10 observations on the data set fact.orders*/
title "Question 4 Part C";
proc print data = fact.orders (obs=10);
run;

/*Part D: Use a data step to read fact.orders and create three new data sets: work.fast, work.slow, 
and work.slowest. The observations on these data sets will depend on how long it took to deliver*/
title "Question 4 Part D";
data fast slow slowest;
	set fact.orders;
	drop Employee_ID;
	ShipDays = Delivery_Date - 	Order_Date;
	if ShipDays < 3 then output fast;
	else if 5 <= ShipDays <= 7 then output slow;
	else if ShipDays > 7 then output slowest;
run;

/*Part E: Use three proc print steps to display the data sets work.fast, work.slow and work.slowest*/
title "Question 4 Part E Fast";
proc print data = fast;
run;

title "Question 4 Part E Slow";
proc print data = slow;
run;

title "Question 4 Part E Slowest";
proc print data = slowest;
run;

/*Question 5 */
/*Part A: Create a library, hr, that points two the directory containing the data set employee_organization */
title "Question 5 Part A";
libname hr '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a proc contents step to examine the contents of the dataset hr.employee_organization */
title "Question 5 Part B";
proc contents data = hr.employee_organization details;
run;

/*Part C: Use a proc print step to display the first 5 observations on the data set employee_organization */
title "Question 5 Part C";
proc print data = hr.employee_organization (obs = 5);
run;

/*Part D: Use a single data step to create two data sets: one for the Sales department (named work.sales) 
and another for the Executive department (named work.exec)*/
title "Question 5 Part D";
data sales (keep = Employee_ID Job_Title Manager_ID) 
	 exec (keep = Employee_ID Job_Title);
	set hr.employee_organization;
	select (Department);
		when ('Sales') output sales;
		when ('Executives') output exec;
		otherwise;
	end;
run;

/*Part E: Use a proc print step to print the first five observations on the work.sales data set*/
title "Question 5 Part E Sales";
proc print data = sales (obs = 5);
run;

/*Part F: use a proc print step to print all of the observations on the work.exec data set*/
title "Question 5 Part F Execs";
proc print data = exec;
run;


/*Question 6 */
/*Part A: Define a library, comp, that points to the location where the data set orders is located */
title "Question 6 Part A";
libname comp '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a proc contents step to examine the contents of comp.orders for information contained 
in variable labels and formats. */
title "Question 6 Part B";
proc contents data = comp.orders details;
run;

/*Part C: Use a proc print step to examine the first 11 records on the comp.orders file */
title "Question 6 Part C";
proc print data = comp.orders (obs = 11);
run;

/*Part D: Use a single data step to read comp.orders and create two files: work.instore and work.delivery */
title "Question 6 Part D";
data instore (keep = Order_ID Customer_ID Order_Date)
	 delivery (keep = Order_ID Customer_ID Order_Date ShipDays);
	set comp.orders;
	ShipDays = Delivery_Date - 	Order_Date;
	if ShipDays = 0 then output instore;
	else output delivery;
run;	

/*Part E: Use a proc print step to examine the first 12 observations in work.delivery */
title "Question 6 Part E Delivery";
proc print data = delivery (obs = 12);
run;

/*Part F: use a proc print step to examine the first 25 observations in work.instore */
title "Question 6 Part F Instore";
proc print data = instore (obs = 25);
run;

/*Question 7 */
/*Part A: Create a library, prg2, that points to the directory on which the SAS data set 
employee_organization resides*/
title "Question 7 Part A";
libname prg2 '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Copy or type the following program into the SAS editor and submit it*/
title "Question 7 Part B";
proc freq data=prg2.employee_organization;
tables department;
run;

/*Part C: Use a single data step and conditional output to create three files: admin, stock, and purchasing*/
title "Question 7 Part C";
data admin stock purchasing;
	set prg2.employee_organization;
	select (Department);
		when ('Administration') output admin;
		when ('Stock & Shipping') output stock;
		when ('Purchasing') output purchasing;
		otherwise;
	end;
run;

/*Part D: Check the log to make sure the number of observations on the created data sets matches 
those displayed in the results of the proc freq step above */
/*log matches output */

/*Part E: Use three proc print steps to print the first 3 observations on each of the created data sets*/
title "Question 7 Part E Admin";
proc print data = admin (obs = 3);
run;

title "Question 7 Part E Stock";
proc print data = stock (obs = 3);
run;

title "Question 7 Part E Purchasing";
proc print data = purchasing (obs = 3);
run;