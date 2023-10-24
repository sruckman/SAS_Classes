/* Assignment Displaying Query Results STA 5067 */

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1*/
proc sql;
title "Single Male Employee Salaries";
	select Employee_ID, Salary format = COMMA10.2, Salary*(1/3) as Tax format = COMMA10.2
	from orion.employee_payroll
	where Employee_Gender="M" and marital_status="S" and employee_term_date is not missing
	order by Salary desc
	;
quit;
title '';

/*Question 2*/
proc sql;
title "Australian Clothing Products";
	select Supplier_Name label = "Supplier", Product_Group label = "Group", 
			Product_Name label = "Product"
	from orion.product_dim
	where Product_Category = "Clothes" and Supplier_Country = "AU"
	;
quit;
title '';

/*Question 3*/
proc sql;
title "US Customers Over 50";
	select Customer_ID format = z6.0, Customer_LastName, Customer_FirstName, Gender, 
		int(('31DEC2007'd - Birth_Date)/365.25) as Age
	from orion.customer
	where Country = "US" and calculated Age > 50
	order by calculated Age desc, Customer_LastName desc, Customer_FirstName desc
	;
quit;
title '';

/*Question 4*/
proc sql;
title "Cities Where Employees Live";
	select City, COUNT(*) as Count
	from orion.employee_addresses
	group by City
	order by City
	;
quit;
title '';

/*Question 5*/
proc sql;
title "Age at Employment";
	select Employee_ID label = "Employee ID", Birth_Date format = MMDDYY10. label = "Birth Date", 
		Employee_Hire_Date format = MMDDYY10. label = "Employee Hire Date", 
		INT((Employee_Hire_Date - Birth_Date)/365.25) as Age label = "Age at Employment"
	from orion.employee_payroll
	;
quit;
title '';

/*Question 6*/
proc sql;
title "Customer Demographics: Gender by Country";
	 select  count(*) as Count label = "Total Number of Customers", 
	 sum((find(Gender,"M","i") > 0)) as MCount label = "Total Number of Males",
	 sum((find(Gender,"M","i") = 0)) as FCount label = "Total Number of Females",
	 calculated MCount/calculated Count as Percent_Male label = 
	 "Percentage of Customers that are Male" format=percent6.2
	 from orion.customer
	 group by Country
	 order by calculated Percent_Male
	 ;
quit;
title '';

/*Question 7*/
proc sql;
title "Countries with more Female than Male Customers";
	select Country, sum((find(Gender,"M","i") > 0)) as MCount label = "Male Customers", 
		sum((find(Gender,"M","i") = 0)) as FCount label = "Female Customers" 
	from orion.customer
	group by Country
	having calculated FCount > calculated MCount
	order by calculated FCount desc
	;
quit;
title '';

