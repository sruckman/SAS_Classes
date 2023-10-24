/*Assignment 04 SQL Subqueries */


%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
proc sql;
	select avg(Quantity) as MeanQuantity
	from orion.order_fact
	;
quit;

/*Question 1b*/
proc sql;
title "Employees whose Average Quantity Items Sold Exceeds the Company's Average Items Sold";
	select Employee_ID, avg(Quantity) as MeanQuantity format = 10.2
	from orion.order_fact
	group by Employee_ID
	having avg(Quantity) > (select avg(Quantity) as MeanQuantity
							from orion.order_fact)
	;
quit;
title '';

/*Question 2a*/
proc sql;
title "Employee IDs for February Anniversaries";
	select Employee_ID
	from orion.employee_payroll
	where month(Employee_Hire_Date) = 2
	;
quit;
title;

/*Question 2b*/
proc sql;
title "Employees with February Anniversaries";
	select Employee_ID, catx(' ',scan(Employee_Name,2)) as FirstName format = $15. label = "First Name", 
	scan(Employee_Name,1) as LastName format = $15. label = "Last Name"
	from orion.employee_addresses
	where Employee_ID in (select Employee_ID from orion.employee_payroll where month(Employee_Hire_Date)=2)
	order by calculated LastName
	;
quit;
title;

/*Question 3*/
proc sql;
title "Level I or II Purchasing Agents who are older than ALL Purchasing Agent IIIs";
	select Employee_ID, Job_Title, Birth_Date, int(('24NOV2007'd - Birth_Date)/365.25) as Age
	from orion.staff
	where Job_Title in ("Purchasing Agent I", "Purchasing Agent II") and calculated Age > all 
		(select int(('24NOV2007'd - Birth_Date)/365.25) as Age
		 from orion.staff
		 where Job_Title = "Purchasing Agent III")
	;
quit;
title;

/*Question 4a*/
proc sql;
create table sale as
	select Employee_ID, (sum((Total_Retail_Price*Quantity))) as Total_Sales format = DOLLAR10.2
	from orion.order_fact
	group by Employee_ID
	having Employee_ID < 99999999  
	;
quit;

proc sql;
title "Employee With Highest Total Sales";
	select *
	from work.sale
	having Total_Sales = max(Total_Sales)
	;
quit;
title;

/*Question 4b*/
proc sql;
title "Name of the Employee With the Highest Total Sales";
	select Employee_ID, Employee_Name
	from orion.employee_addresses
	where Employee_ID in (select Employee_ID from work.sale
	having Total_Sales = max(Total_Sales))
	;
quit;
title;

/*Question 4c*/
proc sql;
title "Employee With Highest Total Sales";
	create table sales as
	select *
	from work.sale
	having Total_Sales = max(Total_Sales)
	;
quit;
title;

proc sql;
title "Employee with the Highest Total Sales";
	create table name as
	select Employee_ID, Employee_Name
	from orion.employee_addresses
	where Employee_ID in (select Employee_ID from work.sale
	having Total_Sales = max(Total_Sales))
	;
quit;

data emp;
	merge name sales;
	by Employee_ID;
run;

proc print data = emp noobs;
run;
title;

/*Question 5*/
proc sql;
title "Australian Employee' Birth Months";
	select Employee_ID, month(Birth_Date) as BirthMonth
	from orion.employee_payroll
	where Employee_ID in (select Employee_ID from orion.employee_addresses where Country = "AU")
	order by calculated BirthMonth
	;
quit;
title;

/*Question 6*/
proc sql;
	create table salary as
	select Employee_ID, Salary, 0.002*Salary as Donate
	from orion.employee_payroll
	order by Employee_ID
	;
quit;

proc sql;
	create table donation as
	select Employee_ID, sum(Qtr1, Qtr2, Qtr3, Qtr4) as Total
	from orion.employee_donations
	group by Employee_ID
	order by Employee_ID
	;
quit;

data combine;
	merge salary donation;
	by Employee_ID;
run;

proc sql;
title "Employees with Donations > 0.002 of their Salary";
	select Employee_ID, Employee_Gender, Marital_Status
	from orion.employee_payroll
	where Employee_ID in (select Employee_ID from work.combine as c
		where c.Total > c.Donate)
	;
quit;
title;

