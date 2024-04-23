/*HW 14 Macro SQL Interface*/
%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/

%let start=01Jan2007;
%let stop=31Dec2007;
proc means data=orion.order_fact noprint;
   var Total_Retail_Price;
   output out=stats n=count mean=avg;
   run;
data _null_;
   set stats;
   call symputx('orders',count);
   call symputx('average',avg);
run;

proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&average;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period: " c=b "&orders";
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      "%sysfunc(putn(&average,dollar4.))";
run;
quit;

/*Question 1b*/
%let start=01Jan2007;
%let stop=31Dec2007;

proc sql outobs=1 noprint;
   select mean(Total_Retail_Price), count(Total_Retail_Price)
     	into :mprice, :count1
	from orion.order_fact;
quit;

proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&mprice;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period: " c=b "&count1";
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      "%sysfunc(putn(&mprice,dollar4.))";
run;
quit;

/*Question 1c*/
%let start=01Jan2007;
%let stop=31Dec2007;

proc sql outobs=1 noprint;
   select mean(Total_Retail_Price), count(Total_Retail_Price)
     	into :mprice, :count1
	from orion.order_fact;
quit;

proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&mprice;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period:" c=b %cmpres("&count1");
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      "%sysfunc(putn(&mprice,dollar4.))";
run;
quit;

%put &mprice &count1;

/*Question 1d*/
%let start=01Jan2007;
%let stop=31Dec2007;

proc sql outobs=1 noprint;
   select mean(Total_Retail_Price), count(Total_Retail_Price)
     	into :mprice, :count1
	from orion.order_fact;
quit;

proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&mprice;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period:" c=b %cmpres("&count1");
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      "%sysfunc(putn(&mprice,dollar4.))";
run;
quit;

%put &mprice &count1;

/*Question 1e*/
%let start=01Jan2007;
%let stop=31Dec2007;

proc sql outobs=1 noprint;
   select mean(Total_Retail_Price), count(Total_Retail_Price), 
   		  mean(Total_Retail_Price) format = dollar4.
     	into :mprice, :count1, :FMTAVG
	from orion.order_fact;
quit;


proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&mprice;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period:" c=b %cmpres("&count1");
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      "%sysfunc(putn(&mprice,dollar4.))";
run;
quit;

%put &mprice &count1 &FMTAVG;

/*Question 1f*/
%let start=01Jan2007;
%let stop=31Dec2007;

proc sql outobs=1 noprint;
   select mean(Total_Retail_Price), count(Total_Retail_Price), 
   		  mean(Total_Retail_Price) format = dollar4.
     	into :mprice, :count1, :FMTAVG
	from orion.order_fact;
quit;


proc gchart data=orion.order_fact;
   vbar3d Order_Type 
      / patternid=midpoint cframe=w shape=c discrete
        sumvar=Total_Retail_Price type=mean ref=&mprice;
   format Total_Retail_Price dollar4.;
   label Total_Retail_Price='Average Order';
   title1 h=1 "Report from &start to &stop";
   title2 h=1 f=swiss "Orders this period:" c=b %cmpres("&count1");
   footnote1 h=1 f=swiss "Overall Average: " c=b 
      %cmpres("&FMTAVG");
run;
quit;

%put &mprice &count1 &FMTAVG;

/*Question 2a and b*/
proc sql outobs=3;
	select customer_id into :TOP3 separated by ', '
	from orion.order_fact
	group by Customer_ID
	order by total_retail_price descending;
quit;

%put Top 3 customers: &TOP3;

/*Question 3a*/
proc sql;
	select count(Customer_Type_ID) into :nrows
	from orion.customer_type;
	%let nrows=&nrows;
	select Customer_Type_ID into :CTYPE1-:CTYPE&nrows
	from orion.customer_type;
quit; 

%put &nrows &CTYPE1 &CTYPE2;

/*Question 3b*/
proc sql;
   select name, value
      from dictionary.macros
	 where name like "CTYPE%";
quit;
