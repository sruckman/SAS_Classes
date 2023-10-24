/*Assignment 14 Summary Reports 1*/
/*Sarah Ruckman*/

libname hw14 "/home/u62104146/my_shared_file_links/jhshows0/STA5066";

/*Exercise 1*/
/*Q1:Proc Freq for retail orders*/
title "Unique Customers and Salespersons for Retail Sales";
proc freq data = hw14.orders nlevels;
	where Order_Type = 1;
	tables Customer_ID Employee_ID/noprint;
run;

/*Q2:Proc Freq for catalog and internet orders */
title "Unique Customers for Catalog and Internet";
proc freq data = hw14.orders nlevels;
	where Order_Type ne 1;
	tables Customer_ID Employee_ID/noprint;
run;

/*Exercise 2*/
/*Q1: Proc format*/
title "Exercise 2";
proc format; 
value ordertypes 1=’Retail’ 2=’Catalog’ 3=’Internet’; 
run; 

/*Q2: Proc freq to produce 3 frequency reports*/
proc freq data = hw14.orders;
	format Order_Date YEAR4. Order_Type ordertypes.;
	tables Order_DAte*Order_Type/nocum nopercent nocol norow;
run;

/*Exercise 3*/
/*Q1: proc freq table based on prduct id*/
title "Exercise 3";
proc freq data = hw14.order_fact;
	table Product_ID/out = freqcount;
run;
	
/*Q2: Merge freqcount and product_list to obtain product name*/
data ex3;
	merge freqcount hw14.product_list;
run;

/*Q3: sort merged data by Count*/
proc sort data = ex3;
	by descending Count;
run;

/*Q4: print first 10 obs*/
proc print data = ex3 (obs = 10);
run;

/*Exercise 4*/
proc format; 
value ordertypes 1=’Retail’ 2=’Catalog’ 3=’Internet’; 
run; 

title "Revenue (in U.S. Dollars) Earned from All Orders";
proc means data = hw14.order_fact sum;
	var Total_Retail_Price;
	class Order_Date Order_Type;
	format Order_Type ordertypes. Order_Date YEAR4.;
run;

/*Exercise 5*/
title "Number of Missing and Non-Missing Date Values";
proc means data = hw14.staff nmiss n nonobs;
	var Birth_Date Emp_Hire_Date Emp_Term_Date;
	class Gender;
run;

/*Exercise 6*/
/*Q1: proc means to output data*/
title "Exercise 6";
proc means data = hw14.order_fact sum;
	var Total_Retail_Price;
	class Product_ID;
	output out = prod
		   sum = Revenue;
run;

/*Q2: merge datasets*/
data ex6;
	merge prod hw14.product_list;
run;

/*Q3: Sort the data higher revenue on top*/
proc sort data = ex6;
	by desending Revenue;
run;

/*Q4: proc print first 10 obs*/
proc print data = ex6 (obs=10);
run;

/*Exercise 7*/
/*Q1: data step*/
title "Exercise 7";
data AnalysisTmp (keep = seqn dmaracer dmarethn dmaethnr hssex hsageir);
	set hw14.analysis;
run;

/*Q2: proc freq for dmaracer, dmarethn, and hssex (cell freq)*/
proc freq data = AnalysisTmp;
	tables dmaracer dmarethn hssex/nocol norow nopercent nocum;
run;

/*Q3: proc freq restricted to females under 50*/
proc freq data = AnalysisTmp;
	where hssex = 2 AND hsageir < 50;
	tables dmaracer dmarethn hssex/nocol norow nopercent nocum;
run;

/*Q4: proc format*/
proc format; 
	value agef low-<45='<45' 45-59='45-59' 60-high='60+';
run;

/*Q5: proc freq with two way tables*/
proc freq data = AnalysisTmp;
	tables dmaracer*dmarethn*hssex*hsageir;
	format hsageir agef.;
run;

/*Exercise 8*/
title "Exercise 8";
proc univariate data = sashelp.heart;
	var cholesterol;
	histogram cholesterol/normal;
	inset mean(6.1) std(5.1) n /position=ne header = 'Summary Statistics';
	qqplot cholesterol;
	inset mean(6.1) std(5.1) n/position=n header = 'Summary Statistics';
run;





