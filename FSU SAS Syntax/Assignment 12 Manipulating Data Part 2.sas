/* Assignment 12 Manipulating Data Part 2 */
/* Sarah Ruckman */

/*Exercise 1*/
/*Question 1: Proc Print to examine data on au_salesforce */
title "Exercise 1 Q1";
libname ex '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

proc print data = ex.au_salesforce;
run;

/*Question 2: */
title "Exercise 1 Q2";
data codes;
	set ex.au_salesforce;
	FCode1 = substr(First_Name,1,1);
	FCode2 = left(substr(right(First_Name),12));
	LCode = substr(Last_Name,1,4);
	User_ID = compress(lowcase(FCode1||FCode2||LCode));
run;

/*Question 3: Proc Print and print only First_Name, FCode1, FCode2, Last_Name, 
LCode, and User_ID*/
title "Exercise 1 Q3";
proc print data = codes;
	var First_Name FCode1 FCode2 Last_Name LCode User_ID;
run;

/*Exercise 2 */
/*Question 1: Proc Print to examine newcompetitors*/
title "Exercise 2 Q1";
proc print data = ex.newcompetitors;
run;

/*Question 2: Data step to create work.smallstores that contains only small retail stores*/
title "Exercise 2 Q2";
data smallstores (drop = Num);
	set ex.newcompetitors;
	City = propcase(City);
	Num = substr(compress(ID),3,1);
	if Num = 1 then output smallstores;
run;

/*Question 3: Proc Print*/
title "Exercise 2 Q3";
proc print data = smallstores;
run;

/*Exercise 3*/
/*Question 1: Proc Contents*/
title "Exercise 3 Q1";
proc contents data = ex.contacts details;
run;

/*Question 2: Proc Print*/
title "Exercise 3 Q2";
proc print data = ex.contacts;
run;

/*Question 3: Data Step: states with ID, Name, and Location*/
title "Exercise 3 Q3";
data states (keep = ID Name Location);
	set ex.contacts;
	Location = propcase(zipname(left(substr(right(Address2),19))));
run;

/*Question 4: Proc Print*/
title "Exercise 3 Q4";
proc print data = states;
run;

/*Exercise 4*/
/*Question 1: Proc Contents step to examine customers_ex5*/
title "Exercise 4 Q1";
proc contents data = ex.customers_ex5 details;
run; 

/*Question 2: Proc Print to examine first 15 obs*/
title "Exercise 4 Q2";
proc print data = ex.customers_ex5 (obs=15);
run;

/*Question 3: Data step to create new data set names and fix variables*/
title "Exercise 4 Q3";
data names (keep = New_Name Name Gender);
	set ex.customers_ex5;
	FName = scan(Name,2,",");
	LName = propcase(scan(Name,1,","));
	if Gender = "M" then Titles = "Mr.";
	if Gender = "F" then Titles = "Ms.";
	New_Name = catx(" ", Titles,FName,LName);
run;

/*Question 4: Proc Print*/
title "Exercise 4 Q4";
proc print data = names;
run;

/*Exercise 5*/
/*Question 1: Proc Print*/
title "Exercise 5 Q1";
proc print data = ex.customers_ex5;
run;

/*Question 2: Data step to create three outputs silver, gold, and platinum*/
title "Exercise 5 Q2";
data silver (keep = Customer_ID Name Country) gold (keep = Customer_ID Name Country) 
	 platinum (keep = Customer_ID Name Country);
	set ex.customers_ex5;
	Customer_ID = Tranwrd(Customer_ID,"-00-","-15-");
	Silver = find(Customer_ID,"Silver","I");
	Gold = find(Customer_ID, "Gold","I");
	Platinum = find(Customer_ID,"Platinum","I");
	if Silver = 1 then output silver;
	if Gold = 1 then output gold;
	if Platinum = 1 then output platinum;
run;

/*Question 3: Proc Print the three datasets*/
title "Exercise 5 Q3 Silver";
proc print data = silver;
run;

title "Exercise 5 Q3 Gold";
proc print data = gold;
run;

title "Exercise 5 Q3 Platinum";
proc print data = platinum;
run;

/*Exercise 6*/
/*Question 1: Proc Print employee_donations*/
title "Exercise 6 Q1";
proc print data = ex.employee_donations;
run;

/*Question 2: Data step to create data set split*/
title "Exercise 6 Q2";
data split;
	set ex.employee_donations;
	PctLoc = find(Recipients,"%");
	if PctLoc = 0 then do;
	Charity = Recipients;
	output;
	end;
	if PctLoc not= 0 then do;
	Charity = substr(Recipients,1,PctLoc);
	output;
	Charity = substr(Recipients,PctLoc+3);
	output;
	end;
run;

/*Question 3: Proc Print*/
title "Exercise 6 Q3";
proc print data = split;
run;

/*Exercise 7*/
/*Question 1: proc print orders_midyear*/
title "Exercise 7 Q1";
proc print data = ex.orders_midyear;
run;

/*Question 2: Data step to create data set sale_stats*/
title "Exercise 7 Q2";
data sale_stats;
	set ex.orders_midyear;
	MonthAvg = mean(of Month1--Month6);
	MonthMax = max(of Month1--Month6);
	MonthSum = sum(of Month1--Month6);
run;

/*Question 3: Proc Print with variables Customer_ID, MonthAvg, MonthMAx, and MonthSum*/
title "Exercise 7 Q3";
proc print data = sale_stats;
	var Customer_ID MonthAvg MonthMax MonthSum;
run;

/*Exercise 8*/
/*Question 1: Proc Print orders midyear*/
title "Exercise 8 Q1";
proc print data = ex.orders_midyear;
run;

/*Question 2: Data step with stats requested*/
title "Exercise 8 Q2";
data freqcustomers (drop = MMax);
	set ex.orders_midyear;
	Mon = n(of Month1-Month6);
	Med = median(of Month1-Month6);
	MMax = largest(2,of Month1-Month6);
	Top1 = max(of Month1-Month6);
	Top2 = substr(MMax,6);
	if Mon >= 5 then output freqcustomers;
run;
	
/*Question 3: Proc Print*/
title "Exercise 8 Q3";
proc print data = freqcustomers;
run;

/*Exercise 9*/
/*Question 1: proc contents*/
title "Exercise 9 Q1";
proc contents data = ex.shipped details;
run;

/*Question 2: Proc Print*/
title "Exercise 9 Q2";
proc print data = ex.shipped;
run;

/*Question 3: Calculate total price of items shipped and create a comment that includes ship date*/
title "Exercise 9 Q3";
data shipping_notes; 
	set ex.shipped; 
	length Comment $ 21.; 
	Comment = cat("Shipped on ",Ship_Date); 
	Price = input(Price, dollar7.2);
	Total = Quantity * Price; 
run; 

proc print data = shipping_notes noobs; 
	format Total dollar7.2; 
run; 

/*Exercise 10*/
/*Question 1: Proc Contents*/
title "Exercise 10 Q1";
proc contents data = ex.US_NEWHIRE details;
run;

/*Question 2: Proc Print*/
title "Exercise 10 Q2";
proc print data = ex.US_NEWHIRE;
run;

/*Question 3: Data step to create US_converted*/
title "Exercise 10 Q3";
data US_converted (drop = CID Tele Birth);
	set ex.US_NEWHIRE (rename = ID = CID rename = Telephone = Tele rename = Birthday = Birth);
	ID = input(compress(tranwrd(CID,"-","")),12.);
	Telephone = put(substr(left(Tele),1,3),3.)||"-"||put(substr(left(Tele),4,4),4.);
	Birthday = input(Birth,DATE9.);
run;

/*Question 4: Proc Contents*/
title "Exercise 10 Q4";
proc contents data = US_converted details;
run;

/*Question 5: Proc Print*/
title "Exercise 10 Q5";
proc print data = US_converted;
run;
