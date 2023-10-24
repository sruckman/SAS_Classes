/*Assignment 07 Complex Queries */

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
title1 "2007 Sales Force Sales Statistics";
title2 "For Employees With 200.00 or More In Sales";
proc sql;
	select Country, First_Name, Last_Name, sum(Total_Retail_Price) as Value_Sold format = COMMA10.2, 
			count(*) as Orders, (calculated Value_Sold/calculated Orders) as Avg_Order format = COMMA10.2
	from orion.order_fact as o, orion.sales as s 
	where o.Employee_ID = s.Employee_ID and year(Order_Date) = 2007
	group by Country, First_Name, Last_Name
	having calculated Value_Sold >= 200 
	order by Country, calculated Value_Sold descending, calculated Orders descending
;
quit;
title;

/*Question 1b*/
title "2007 Sales Summary by Country";
proc sql;
	select Country, max(Value_Sold) as maxV label = "Max Value Sold" format = COMMA10.2, 
			max(Orders) as maxO label = "Max Orders", max(Avg_Order) as maxA label = "Max Average" format = COMMA10.2,
			min(Avg_Order) as min label = "Min Average" format = COMMA10.2
	from (select Country, First_Name, Last_Name, sum(Total_Retail_Price) as Value_Sold format = COMMA10.2, 
			count(*) as Orders, (calculated Value_Sold/calculated Orders) as Avg_Order format = COMMA10.2
			from orion.order_fact as o, orion.sales as s 
			where o.Employee_ID = s.Employee_ID and year(Order_Date) = 2007
			group by Country, First_Name, Last_Name
			having calculated Value_Sold >= 200 )
	group by Country
	order by Country
;
quit;
title;

/*Question 2a*/
title1 "2007 Sales Force Sales Statistics";
title2 "For Employees With 200.00 or More In Sales";
proc sql;
	select Department, sum(Salary) as Dept_Salary_Total
	from orion.employee_payroll as p, orion.employee_organization as o
	where p.Employee_ID = o.Employee_ID
	group by Department
	order by Department
;
quit;
title;

/*Question 2b*/
title1 "2007 Sales Force Sales Statistics";
title2 "For Employees With 200.00 or More In Sales";
proc sql;
	select a.Employee_ID, Employee_Name, Department 
	from orion.employee_addresses as a, orion.employee_organization as o
	where a.Employee_ID = o.Employee_ID
;
quit;
title;

/*Question 2c*/
title "Employee Salaries as a Percent of Department Total";
proc sql;
	select op.Department, Employee_Name, Salary format = COMMA12.2, 
			Salary/Dept_Salary_Total as Percent format = PERCENT8.1
	from orion.employee_payroll as pay, (select Department, sum(Salary) as Dept_Salary_Total
		from orion.employee_payroll as p, orion.employee_organization as o
		where p.Employee_ID = o.Employee_ID
		group by Department) as op, (select a.Employee_ID, Employee_Name, Department 
		from orion.employee_addresses as a, orion.employee_organization as o
		where a.Employee_ID = o.Employee_ID) as ao 
	where ao.Department = op.Department and pay.Employee_ID = ao.Employee_ID
	order by op.Department, calculated Percent descending
;
quit;
title;

/*Question 3*/
title "2007 Total Sales Figures";
/*Employee Names with Manager IDs*/
proc sql;
	create table name as
	select catx(" ", scan(Employee_Name, 2, ","), scan(Employee_Name, 1, ",")) as Emp, Manager_ID
		 from orion.employee_addresses as a
		 inner join orion.employee_organization as o 
		 on a.Employee_ID = o.Employee_ID
;
quit;

title "2007 Total Sales Figures";
proc sql;
	select Manager_Name as Manager, Employee, Total_Sales format = COMMA15.2
	from (select n.Emp label = "Employee Name", n.Manager_ID, Country,
		 catx(" ", scan(a.Employee_Name, 2, ","), scan(a.Employee_Name, 1, ",")) as Manager_Name label = "Manager Name"
		from work.name as n inner join orion.employee_addresses as a on a.Employee_ID = n.Manager_ID) as n,
		(select distinct catx(" ", scan(Employee_Name, 2, ","), scan(Employee_Name, 1, ",")) as Employee, 
		sum(Total_Retail_Price) as Total_Sales, f.Employee_ID
		from orion.order_fact as f inner join orion.employee_addresses as a
		 on f.Employee_ID = a.Employee_ID where year(Order_Date) = 2007 group by Employee) as s
	where s.Employee = n.Emp
	group by Employee, Manager
	order by Country, scan(Manager, 2, " "), scan(Manager, 1, " "), Total_Sales descending
;
quit;
title;