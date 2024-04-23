/*Assignment 09 SQL Set Operations*/

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1*/
proc sql;
	select Customer_ID
	from orion.order_fact
	intersect 
	select Customer_ID
	from orion.customer
	;
quit;

/*Question 2*/
proc sql;
   select 'Number of employees that did not donate', count(*)
      from (select *
               from orion.employee_organization
            except corr
            select * 
               from orion.employee_donations);
quit;

/*Question 3*/
proc sql;
	select 'Number of customers that placed orders', count(*)
	from (select *
			from orion.order_fact
			intersect corr
			select *
			from orion.customer)
	;
quit;

/*Question 4*/
title "Sales Reps Who Made No Sales in 2007";
proc sql;
	create table no_sales as
	select Employee_ID, year(Order_Date)
	from orion.order_fact
	having year(Order_Date) ne 2007;
	
	create table sales as
	select Employee_ID, year(Order_Date)
	from orion.order_fact
	having year(Order_Date) = 2007;
quit;

proc sql;
	select monotonic() as num,  ex.Employee_ID, Employee_Name
	from orion.employee_addresses as e, 
		(select Employee_ID from no_sales
			except select Employee_ID from sales) as ex
	where e.Employee_ID = ex.Employee_ID
;
quit;
title;

/*Question 5*/
proc sql;
	select Customer_ID, Customer_Name
	from orion.customer
	where Customer_ID in (select Customer_ID from orion.order_fact
			intersect select Customer_ID from orion.customer)
	;
quit;

/*Question 6*/
title "Payroll Report for Sales Representatives";
proc sql;
	select 'Total Paid to ALL Female Sales Representatives', sum(Salary), count(*)
	from orion.sales
	where Gender = 'F' and Job_Title contains 'Rep'
	union
	select 'Total Paid to ALL Male Sales Representatives', sum(Salary), count(*)
	from orion.sales
	where Gender = 'M' and Job_Title contains 'Rep';
quit;
title;

/*Question 7*/
proc sql;
	select *
	from orion.Qtr1_2007
	outer union corr
	select *
	from orion.Qtr2_2007;
quit;

/*Question 8a*/
proc sql;
	select *
	from orion.Qtr1_2007
	union
	select *
	from orion.Qtr2_2007;
quit;

/*Question 8b*/
proc sql;
	select *
	from orion.Qtr1_2007
	outer union
	select *
	from orion.Qtr2_2007;
quit;
