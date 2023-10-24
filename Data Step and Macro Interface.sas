/*HW 13 Data Step and Macro Interface*/
%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
%macro emporders(idnum=121044);
   proc print data=orion.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Received by Employee &idnum";
   run;
%mend emporders;

%emporders()

/*Question 1b*/
%macro emporders(idnum=121044);
	data names;
		set orion.employee_addresses;
		where Employee_ID = &idnum;
		call symputx('name',Employee_Name);
	run;
   proc print data=orion.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Received by Employee &idnum";
   run;
%mend emporders;

%emporders()

/*Question 1c*/
%macro emporders(idnum=121044);
	data names;
		set orion.employee_addresses;
		where Employee_ID = &idnum;
		call symputx('name',Employee_Name);
	run;
   proc print data=orion.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Received by Employee &name";
   run;
%mend emporders;

%emporders()

/*Question 1d*/
%emporders(idnum = 121066)

/*Question 2a*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum; 
   by descending CustTotalPurchase;
run;

proc print data=customer_sum(drop=_type_);
run;

/*Question 2b*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum out = sortcust; 
   by descending CustTotalPurchase;
run;

data top1;
	set sortcust;
	if _n_=1 then call symputx('top', Customer_ID);
run;

proc print data = orion.order_fact noobs;
	where Customer_ID = &top;
	var Order_ID Order_Type Order_Date Delivery_Date;
	title "Orders for Customer &top - Orion's Top Customer";
run;

/*Question 2c*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum out = sortcust; 
   by descending CustTotalPurchase;
run;

data top1;
	set sortcust;
	if _n_=1 then call symputx('top', Customer_ID);
run;

data names;
		set orion.customer_dim;
		where Customer_ID = &top;
		call symputx('name',Customer_Name);
	run;

proc print data = orion.order_fact noobs;
	where Customer_ID = &top;
	var Order_ID Order_Type Order_Date Delivery_Date;
	title "Orders for Customer &name - Orion's Top Customer";
run;

/*Question 3a*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum ;
   by descending CustTotalPurchase;
run;

proc print data=customer_sum(drop=_type_);
run;

/*Question 3b*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum out = sorted;
   by descending CustTotalPurchase;
run;

data _null_;
  set sorted(obs = 3);
  call symputx('a'||left(_n_),Customer_ID);
run;
%let TOP3 = &a1 &a2 &a3; 
%put &TOP3;

proc print data=customer_sum(drop=_type_);
run;

/*Question 3c*/
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum out = sorted;
   by descending CustTotalPurchase;
run;

data _null_;
  set sorted(obs = 3);
  call symputx('a'||left(_n_),Customer_ID);
run;
%let TOP3 = &a1 &a2 &a3; 
%put &TOP3;

proc print data=customer_sum(drop=_type_);
run;

proc print data=orion.customer_dim noobs;
	where Customer_ID in (&TOP3);
	var Customer_ID Customer_Name Customer_Type;
	title "Top 3 Customers";
run;

/*Question 4a*/
%macro memberlist(id=1020);
   %put _user_;
   title "A List of &id";
   proc print data=orion.customer;
      var Customer_Name Customer_ID Gender;
      where Customer_Type_ID=&id;
   run;
%mend memberlist;

%memberlist()

/*Questin 4b*/
%macro memberlist(id=1020);
   %put _user_;
   data _null_;
   set orion.customer_type;
   call symputx('TYPE'||left(Customer_Type_ID),Customer_Type);
run;
   title "A List of &id";
   proc print data=orion.customer;
      var Customer_Name Customer_ID Gender;
      where Customer_Type_ID=&id;
   run;
%mend memberlist;

%memberlist()

/*Question 4c*/
%macro memberlist(id=1020);
   %put _user_;
   data _null_;
   set orion.customer_type;
   call symputx('TYPE'||left(Customer_Type_ID),Customer_Type);
run;
   title "A List of &&TYPE&id";
   proc print data=orion.customer;
      var Customer_Name Customer_ID Gender;
      where Customer_Type_ID=&id;
   run;
%mend memberlist;

%memberlist()

/*Question 4d*/
%memberlist(id=2030)

/*Question 5a*/
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

%macro memberlist(custtype);
   proc print data=orion.customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;

/*Question 5b*/
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

%macro memberlist(custtype);
   proc print data=orion.customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;
%let NUM = 2010;

%memberlist(custtype= &&type&NUM);

/*Question 6a*/ /*SAME ISSUE AS 3*/
data _null_;
	set orion.country;
	call symputx('a'||left(_n_), Country_Name);
run;
%let Country = &a1 &a2 &a3 &a4 &a5 &a6 &a7;
%put &Country;

/*Question 6b*/
%let code=AU;
proc print data=Orion.Employee_Addresses;
   var Employee_Name City;
   where Country="&code";
   title "A List of xxxxx Employees";
run;

/*Question 6c*/
%let code=AU;
data _null_;
	set orion.country;
	where Country = "&code";
	call symputx('Country', Country_Name);
run;

proc print data=Orion.Employee_Addresses;
   var Employee_Name City;
   where Country="&code";
   title "A List of &Country Employees";
run;

/*Question 7a*/
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

data us;
   set orion.customer;
   where Country="US";
   keep Customer_ID Customer_Name Customer_Type_ID;
run;

proc print data=us noobs;
   title "US Customers";
run;

/*Question 7b*/
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

data us;
   set orion.customer;
   where Country="US";
   CustType = symget('type'||left(Customer_Type_ID));
   keep Customer_ID Customer_Name Customer_Type_ID CustType;
run;

proc print data=us noobs;
   title "US Customers";
run;
