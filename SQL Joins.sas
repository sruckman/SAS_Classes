/*Assignment 06 SQL Joins */

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";
libname train "&path/train";

/*Question 1*/
title1 "Employees with More than 30 Years of Service";
title2 "As of December 31, 2007";
proc sql;
	select Employee_Name label = "Employee Name", 
		int(('31DEC2007'd - Employee_Hire_Date)/365.25) as YOS label = "Years of Service"
	from orion.employee_addresses as a, orion.employee_payroll as p
	where a.Employee_ID = p.Employee_ID and calculated YOS > 30
	order by Employee_Name
;
quit;
title1;
title2;

/*Question 2*/
proc sql;
	select Employee_Name label = "Name", City, Job_Title
	from orion.sales as s right join orion.employee_addresses as a
	on s.Employee_ID = a.Employee_ID
	order by City, Job_Title, Employee_Name
;
quit;

/*Question 3*/
title "US and Australian Internet Customers Purchasing Foreign Manufactured Products";
proc sql;
	select Customer_Name label = "Name", count(f.Customer_ID) as Purchases 
	from orion.product_dim as d 
		inner join orion.order_fact as f
		on d.Product_ID = f.Product_ID and f.Employee_ID = 99999999
		inner join orion.customer as c
		on f.Customer_ID = c.Customer_ID 
	where c.Country NOT = d.Supplier_Country 
		and c.Country in ('US','AU')
	group by Customer_Name
	order by calculated Purchases descending, Customer_Name
;
quit;
title;

/*Question 4*/
title1 "Employees with More than 30 Years of Service";
title2 "As of December 31, 2007";
proc sql;
	create table names as
	select int(('31DEC2007'd - Employee_Hire_Date)/365.25) as YOS label = "Years of Service",
		a.Employee_Name label = "Employee Name", Manager_ID
	from orion.employee_addresses as a
		inner join orion.employee_organization as o 
		on a.Employee_ID = o.Employee_ID
		inner join orion.employee_payroll as p
		on o.Employee_ID = p.Employee_ID
;
quit;

proc sql;
	select n.Employee_Name label = "Employee Name", n.YOS label = "Years of Service",
		 a.Employee_Name as Manager_Name label = "Manager Name"
	from work.names as n
		inner join orion.employee_addresses as a
		on a.Employee_ID = n.Manager_ID
	where  YOS > 30
	order by Manager_Name, YOS descending, n.Employee_Name
;
quit;
title1;
title2;

/*Question 5*/
title "US Employees";
proc sql;
	select Employee_Name label = 'Name', City, 
	int(('31DEC2007'd - Birth_Date)/365.25) as Age, Employee_Gender
	from orion.employee_payroll as p inner join orion.employee_addresses as a
	on p.Employee_ID = a.Employee_ID
	where a.Country = "US"
	order by calculated Age, City, Employee_Name
;
quit;
title;

/*Question 6*/
title "New Jersey Employees";
proc sql;
	select substr(FirstName,1,1)||". "|| LastName as Name format = $40., JobCode, Gender
	from train.staffmaster as s
	inner join train.payrollmaster as p
	on s.EmpID = p.EmpID
	where State = "NJ"
	order by Gender, JobCode
;
quit;
title;

/*Question 7a*/
data t1 t2;
		call streaminit(54321);
   do id=1,7,4,2,6,11,9;
		chol=int(rand("Normal",240,40));
		sbp=int(rand("Normal",120,20));
		output t1;
  	end;
   do id1=2,1,5,7,3,9;
		chol=int(rand("Normal",240,40));
		sbp=int(rand("Normal",120,20));
		output t2;
	end;
run;
title "t1";
proc print data=t1 noobs;run;
title "t2";
proc print data=t2 noobs;run;
title;

/*Question 7b*/
proc sql;
	select coalesce(a.id,b.id) as id,
      	coalesce(a.chol,b.chol) as chol, 
      	coalesce(a.sbp,b.sbp) as sbp
	from t1 as a inner join t2 as b
		on a.id = b.id1
	order by calculated id
;
quit;











