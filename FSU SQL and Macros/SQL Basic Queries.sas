/* Assignment SQL Basic Queries STA 5067 */

%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/* Question 1 */
/*Part a*/
proc sql;
	select *
	from orion.employee_payroll
	;
quit;

/*Part b*/
proc sql;
	select Employee_ID, Employee_Gender, Marital_Status, Salary
	from orion.employee_payroll
	;
quit;

/*Question 2*/
proc sql;
	select Employee_ID, Employee_Gender, Marital_Status, Salary,
	Salary*(1/3) as Tax
	from orion.employee_payroll
	;
quit;

/*Question 3*/
proc sql;
	select Employee_ID, Salary,
		case scan(Job_Title, -1, ' ')
			when 'Manager' then 'Managar'
			when 'Director' then 'Director'
			when 'Officer' then 'Executive'
			when 'President' then 'Executive'
			else 'N/A'
			end as Level,
		case 
			when scan(Job_Title, -1, ' ') = 'Manager' AND Salary < 52000 then 'Low'
			when scan(Job_Title, -1, ' ') = 'Manager' AND 52000 < Salary < 72000 then 'Medium'
			when scan(Job_Title, -1, ' ') = 'Manager' AND Salary > 72000 then 'High'
			when scan(Job_Title, -1, ' ') = 'Director' AND Salary < 108000 then 'Low'
			when scan(Job_Title, -1, ' ') = 'Director' AND 108000 < Salary < 135000 then 'Medium'
			when scan(Job_Title, -1, ' ') = 'Director' AND Salary > 135000 then 'High'
			when scan(Job_Title, -1, ' ') = 'Officer' AND Salary < 240000 then 'Low'
			when scan(Job_Title, -1, ' ') = 'Officer' AND 240000 < Salary < 300000 then 'Medium'
			when scan(Job_Title, -1, ' ') = 'Officer' AND Salary > 300000 then 'High'
			when scan(Job_Title, -1, ' ') = 'President' AND Salary < 240000 then 'Low'
			when scan(Job_Title, -1, ' ') = 'President' AND 240000 < Salary < 300000 then 'Medium'
			when scan(Job_Title, -1, ' ') = 'President' AND Salary > 300000 then 'High'
			else ' '
			end as Salary_Range
	from orion.staff
	where calculated Level NOT = 'N/A'
	;
quit;

/*Question 4*/
title 'Cities Where Employees Live';
proc sql;
	select unique City
	from orion.employee_addresses
	;
quit;
title '';

/*Question 5*/
title 'Donations Exceeding $90.00';
proc sql;
	select Employee_ID, Recipients, sum(Qtr1, Qtr2, Qtr3, Qtr4) as Total
	from orion.employee_donations
	where calculated Total > 90
	;
quit;
title '';
