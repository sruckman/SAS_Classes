/*Assignment 08 Creating Tables and Views*/

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
proc sql;
create view work.T_Shirts as
   select d.Product_ID, Supplier_Name format = $20., Product_Name, 
   		Unit_Sales_Price as Price label = "Retail_Price"
   from orion.product_dim as d, orion.price_list as l
   where d.Product_ID = l.Product_ID and Product_Name contains "T-Shirt"
;
quit;

/*Question 1b*/
title1 "All Suppliers with T-Shirts For Sale";
title2 "Including Product ID and Prices";
proc sql;
   select *
   from work.T_Shirts
   order by Supplier_Name, Product_ID
;
quit;
title;

/*Question 1c*/
title1 "T-Shirts For Sale Less Than $20";
title2 "Including Product ID and Prices";
proc sql;
   select Product_ID, Product_Name, Price
   from work.T_Shirts
   where Price < 20
   order by Price
;
quit;
title;

/*Question 2a*/
proc sql;
create view work.Current_Catalog as
   select d.*, Unit_Sales_Price * (Factor*(year(Today())-year(Start_Date)))
   		as Price label = "Current_Retail_Price" format = COMMA15.2
   from orion.product_dim as d, orion.price_list as l
   where d.Product_ID = l.Product_ID
;
quit;

/*Question 2b*/
proc sql;
	select Supplier_Name, Product_Name, Price
	from work.Current_Catalog
	where Product_Name contains "Roller Skate"
	order by Supplier_Name, Price
;
quit;

/*Question 2c*/
title "Products with Greater than $5 Increases in Price";
proc sql;
	select Product_Name, Unit_Sales_Price format = DOLLAR20.2, Price format = DOLLAR20.2, 
		Price - Unit_Sales_Price as Increase format = DOLLAR20.2
	from work.Current_Catalog as c, orion.price_list as l
	where calculated Increase > 5 and c.Product_ID = l.Product_ID
	order by calculated Increase DESCENDING
;
quit;
title;
	
/*Question 3a*/
proc sql;
	create table work.Employees as 
	select a.Employee_ID, Employee_Hire_Date as Hire_Date format = MMDDYY10., 
		Salary format = COMMA10.2, Birth_Date format = MMDDYY10., 
		Employee_Gender as Gender, Country, City
	from orion.employee_addresses as a, orion.employee_payroll as p
	where Employee_Term_Date is not missing and a.Employee_ID = p.Employee_ID
	order by year(Employee_Hire_Date), Salary descending
;
quit;

/*Question 3b*/
proc sql;
	select *
	from work.Employees
	where Gender = 'F' and Salary > 75000
;
quit;

/*Question 4*/
proc sql;
	create table work.Direct_Compensation as
	select distinct f.Employee_ID, First_Name || " " || Last_Name as Name format = $80.,
		(scan(Job_Title,-1,' ')) as Level, Salary format = COMMA12.2, 
		(sum(Total_Retail_Price)*0.15) as Commission format = COMMA12.2,
		(sum(Total_Retail_Price)*0.15)+Salary as Direct_Compensation format = COMMA12.2
	from orion.order_fact as f, orion.sales as s
	where Job_Title contains 'I' and year(Order_Date) = 2007 and f.Employee_ID = s.Employee_ID
	group by Name
;
quit;

proc sql;
	select * from work.Direct_Compensation;
quit;

