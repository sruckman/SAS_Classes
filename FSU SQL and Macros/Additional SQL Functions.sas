/* Assignment Proc SQL Additional Features*/

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
title 'Highest Salary in the Employee Payroll';
proc sql;
	select max(Salary)
	from orion.employee_payroll
;
quit;
title;

/*Question 1b*/
%let DataSet = employee_payroll;
%let VariableName = Salary;

%put &DataSet;
%put &VariableName;

/*Question 1c*/
title "Highest &VariableName in the &DataSet";
proc sql;
	select max(&VariableName)
	from orion.&DataSet
;
quit;
title;

/*Question 1d*/
%let DataSet = price_list;
%let VariableName = Unit_Sales_Price;

%put &DataSet;
%put &VariableName;

title "Highest &VariableName in the &DataSet";
proc sql;
	select max(&VariableName)
	from orion.&DataSet
;
quit;
title;

/*Question 2a*/
title "2007 Purchases by Country";
proc sql;
	select Country, sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007
	group by Country
	order by calculated Purchases descending
;
quit;
title;

/*Question 2b*/
title1 "2007 US Purchases";
title2 "Total US Purchases: $10,655.97";
proc sql;
	select Customer_Name label = 'Customer Name', sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007 and Country = 'US'
	group by Customer_Name
	order by calculated Purchases descending
;
quit;
title;

/*Question 2c*/
proc sql noprint;
   select Country, sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
   		into :Country, :Country_Purchases
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007
	group by Country
	order by calculated Purchases descending
;
quit;

title1 "2007 &Country Purchases";
title2 "Total &Country Purchases: &Country_Purchases";
proc sql;
	select Customer_Name label = 'Customer Name', sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007 and Country = "&Country"
	group by Customer_Name
	order by calculated Purchases descending
;
quit;
title;

/*Question 2d*/
proc sql noprint;
   select Country, sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
   		into :Country, :Country_Purchases
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007
	group by Country
	order by calculated Purchases
;
quit;

title1 "2007 &Country Purchases";
title2 "Total &Country Purchases: &Country_Purchases";
proc sql;
	select Customer_Name label = 'Customer Name', sum(Total_Retail_Price) as Purchases format = DOLLAR12.2
	from orion.order_fact as o, orion.customer as c
	where o.Customer_ID = c.Customer_ID and year(Order_Date) = 2007 and Country = "&Country"
	group by Customer_Name
	order by calculated Purchases descending
;
quit;
title;