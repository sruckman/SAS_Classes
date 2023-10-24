/* Assignment 11 Processing Data Iteratively */
/* Sarah Ruckman */

/*Exercise 1*/
/*Question 1 Part A: initialize variables with present values*/
title "Exercise 1 Q1 Part A";
data future_costs;
	wages = 12874000;
	retire = 1765000;
	medicine = 649000;
run;

/*Part B: use a do loop to calculate the total costs for each of the next 10 years*/
title "Exercise 1 Q1 Part B";
data future_costs (keep = total_costs year);
	retain wages 12874000;
	retain retire 1765000;
	retain medicine 649000;
	do year = 1 to 10;
		Yearw+((Yearw+wages)*0.03);
		Yearr+((Yearr+retire)*0.014);
		Yearm+((Yearm+medicine)*0.095);
		total_costs=Yearw+Yearr+Yearm+wages+retire+medicine;
		output;
	end;
run;

/*Question 2: Use a proc print step to display the data portion of future_costs */
title "Exercise 1 Q2";
proc print data = future_costs noobs;
var year total_costs;
run;

/*Question 3: The present corporate income is $50,000,000 and is expected to grow 
at a rate of 1% per year. Write another data step that modifies the one above and examines 
how long it is before total_costs exceeds income*/
title "Exercise 1 Q3";
data future_costs (keep = income total_costs year);
	retain wages 12874000;
	retain retire 1765000;
	retain medicine 649000;
	retain inco 50000000;
	do year = 1 to 100 until (income < total_costs);
		Yeari+((Yeari + inco)*0.01);
		Yearw+((Yearw+wages)*0.03);
		Yearr+((Yearr+retire)*0.014);
		Yearm+((Yearm+medicine)*0.095);
		total_costs=Yearw+Yearr+Yearm+wages+retire+medicine;
		income = inco+Yeari;
	end;
run;
/*42 years*/

/*Exercise 2*/
/*Question 1: Use a data step to create a SAS data set named work.expenses 
that contains each years projected income and expenses. Use an iterative DO statement 
with a conditional clause. Stop the loop when expenses exceed income or after 30 years, 
whichever comes first*/
title "Exercise 2 Q1";
data expenses (keep = year income expenses);
	retain inco 50000000;
	retain expen 38750000;
	do year = 1 to 100 until (income < expenses or year > 30);
		Yeari+((Yeari + inco)*0.01);
		Yeare+((Yeare + expen)*0.02);
		income = Yeari + inco;
		expenses = Yeare + expen;
	end;
run;
/*Year 26*/

/*Question 2: Proc Print to display the results and format to have $ and 2 decimal points*/
title "Exercise 2 Q2";
proc print data = expenses noobs;
format income dollar14.2 expenses dollar14.2;
run;

/*Exercise 3*/
/*Question 1 Part A: Use an iterative DO statement to calculate projected income and expenses 
for the next 75 years*/
title "Exercise 3 Q1 Part A";
data income (keep = year income expenses);
	retain inco 50000000;
	retain expen 38750000;
	do year = 1 to 75;
		Yeari+((Yeari + inco)*0.01);
		Yeare+((Yeare + expen)*0.02);
		income = Yeari + inco;
		expenses = Yeare + expen;
	end;
run;

/*Part B/C: Include the appropriate loop control statement (continue/leave) to stop the loop
when espenses exceeds income*/
title "Exercise 3 Q1 Part B/C";
data income (keep = year income expenses);
	retain inco 50000000;
	retain expen 38750000;
	do year = 1 to 75;
		Yeari+((Yeari + inco)*0.01);
		Yeare+((Yeare + expen)*0.02);
		income = Yeari + inco;
		expenses = Yeare + expen;
		if expenses ge income then leave;
	end;
run; /*26 years*/

/*Question 2: Proc Print to display the results and format to have $ and 2 decimal points*/
title "Exercise 3 Q2";
proc print data = income noobs;
format income dollar14.2 expenses dollar14.2;
run;

/*Exercise 4*/
/*Question 1: Use a PROC CONTENTS step to examine the descriptor portion of the data set*/
title "Exercise 4 Q1";
libname ex4 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';
proc contents data = ex4.orders_midyear details;
run;

/*Question 2: Use a DATA step to read orders_midyears and create a new data set, discount_sales, 
that reflects the five-percent discount*/
/*Part A: Create an array, Mon, to access Month1 through Month6 using a SAS variable list*/
title "Exercise 4 Q2 Part A";
data discount_sales;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
run;

/*Part B: Use a DO loop to adjust each customer’s monthly data by applying the 5% discount*/
title "Exercise 4 Q2 Part B";
data discount_sales (drop = i);
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	 do i=1 to dim(Mon);
      Mon{i}=Mon{i}*0.95;
   end; 
run;

/*Question 3: Use a PROC PRINT step to display the resulting data set and verify your results. 
Use the DOLLAR. format for the monthly sales amounts*/
title "Exercise 4 Q3";
proc print data = discount_sales;
format Month1 dollar8.2 Month2 dollar8.2 Month3 dollar8.2 Month4 dollar8.2 Month5 dollar8.2 Month6 dollar8.2;
run;

/*Exercise 5*/
/*Question 1 Part A: Create an array, Mon, to access Month1 through Month3*/
title "Exercise 5 Q1 Part A";
data special_offer;
	set ex4.orders_midyear;
	array Mon{3} Month1-Month3;
run;

/*Part B: Use a DO loop to calculate each customers monthly data to include 
the 10-percent discount (Month1 through Month3 only)*/
title "Exercise 5 Q1 Part B";
data special_offer (drop = i);
	set ex4.orders_midyear;
	array Mon{3} Month1-Month3;
	do i=1 to dim(Mon);
      Mon{i}=Mon{i}*0.90;
  	end; 
run;

/*Part C: Create 3 new variables*/
title "Exercise 5 Q1 Part C";
data special_offer (keep = Total_Sales Projected_Sales Difference);
	set ex4.orders_midyear;
	Total_Sales = sum(Month1,Month2,Month3,Month4,Month5,Month6);
	array Mon{3} Month1-Month3;
	do i=1 to dim(Mon);
      Mon{i}=Mon{i}*0.90;
     end; 
     Projected_Sales = sum(of Mon{*},Month4,Month5,Month6);
     Difference = Total_Sales - Projected_Sales;
run;

/*Question 2: Use a PROC PRINT step to print the resulting data set and verify your results*/
title "Exercise 5 Q2";
proc print data = special_offer;
format Total_Sales dollar10.2 Projected_Sales dollar10.2 Difference dollar10.2;
sum Difference;
run;

/*Exercise 6*/
/*Question 1: Use an array to refer to the values in the variables month1 to month6*/
title "Exercise 6 Q1";
data preferred_cust;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
run;

/*Question 2: Create a temporary array called Target*/
title "Exercise 6 Q2";
data preferred_cust;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	array Target{6} _temporary_ (200,400,300,100,100,200);
run;

/*Question 3/4: Create new variables to hold the amount from target and Use a 
DO loop to calculate the values of Over1 through Over6 when the corresponding month’s 
sales amount exceeds the target*/
title "Exercise 6 Q3/4";
data preferred_cust;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	array Target{6} _temporary_ (200,400,300,100,100,200);
	do i = 1 to 6;
		if Target{1}>Mon{1} then Over1 = Target{1}-Mon{1};
		if Target{2}>Mon{2} then Over2 = Target{2}-Mon{2};
		if Target{3}>Mon{3} then Over3 = Target{3}-Mon{3};
		if Target{4}>Mon{4} then Over4 = Target{4}-Mon{4};
		if Target{5}>Mon{5} then Over5 = Target{5}-Mon{5};
		if Target{6}>Mon{6} then Over6 = Target{6}-Mon{6};
		else;
		end;
run;

/*Question 5: Store the sum of Over1 to Over6 in a new variable Total_Over*/
title "Exercise 6 Q5";
data preferred_cust;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	array Target{6} _temporary_ (200,400,300,100,100,200);
	do i = 1 to 6;
		if Target{1}>Mon{1} then Over1 = Target{1}-Mon{1};
		if Target{2}>Mon{2} then Over2 = Target{2}-Mon{2};
		if Target{3}>Mon{3} then Over3 = Target{3}-Mon{3};
		if Target{4}>Mon{4} then Over4 = Target{4}-Mon{4};
		if Target{5}>Mon{5} then Over5 = Target{5}-Mon{5};
		if Target{6}>Mon{6} then Over6 = Target{6}-Mon{6};
		else;
		end;
	array Over{6} Over1-Over6;
	Total_Over = sum(of Over{*});
run;

/*Question 6: Write an observation only if Total Over is greater than 500*/
title "Exercise 6 Q6";
data preferred_cust;
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	array Target{6} _temporary_ (200,400,300,100,100,200);
	do i = 1 to 6;
		if Target{1}>Mon{1} then Over1 = Target{1}-Mon{1};
		if Target{2}>Mon{2} then Over2 = Target{2}-Mon{2};
		if Target{3}>Mon{3} then Over3 = Target{3}-Mon{3};
		if Target{4}>Mon{4} then Over4 = Target{4}-Mon{4};
		if Target{5}>Mon{5} then Over5 = Target{5}-Mon{5};
		if Target{6}>Mon{6} then Over6 = Target{6}-Mon{6};
		else;
		end;
	array Over{6} Over1-Over6;
	Total_Over = sum(of Over{*});
	if Total_Over > 500 then output;
run;

/*Question 7: The new data set, preferred cust, should include only the variables Customer ID,
 Over1 through Over6, and Total_Over */
title "Exercise 6 Q7";
data preferred_cust (keep = Customer_ID Over1 Over2 Over3 Over4 Over5 Over6 Total_Over);
	set ex4.orders_midyear;
	array Mon{6} Month1-Month6;
	array Target{6} _temporary_ (200,400,300,100,100,200);
	do i = 1 to 6;
		if Target{1}>Mon{1} then Over1 = Target{1}-Mon{1};
		if Target{2}>Mon{2} then Over2 = Target{2}-Mon{2};
		if Target{3}>Mon{3} then Over3 = Target{3}-Mon{3};
		if Target{4}>Mon{4} then Over4 = Target{4}-Mon{4};
		if Target{5}>Mon{5} then Over5 = Target{5}-Mon{5};
		if Target{6}>Mon{6} then Over6 = Target{6}-Mon{6};
		else;
		end;
	array Over{6} Over1-Over6;
	Total_Over = sum(of Over{*});
	if Total_Over > 500 then output;
run;

/*Question 8: Proc Print step*/
title "Exercise 6 Q8";
proc print data = preferred_cust;
format Over1 dollar8.2 Over2 dollar8.2 Over3 dollar8.2 Over4 dollar8.2 Over5 dollar8.2 
	   Over6 dollar8.2 Total_Over dollar8.2;
run;

/*Exercise 7*/
/*Question 1: proc print to examine test answers*/
title "Exercise 7 Q1";
proc print data = ex4.test_answers;
run;

/*Question 2: Use the data set test_answers to determine whether each person passed or 
failed the test and to create two new SAS data sets, passed, and failed*/
/*Part A: Compute a variable Score that contains the total number of correct answers for 
each person. Part B: Use a temporary array for the answer key. 
(You will need $ after array name)*/
title "Exercise 7 Q2 Part A/B";
data test;
	set ex4.test_answers;
	array Correct{10} $ _temporary_ ('A','C','C','B','E','E','D','B','B','A');
	array Test{10} $ Q1-Q10;
	do i = 1 to 10;
	if Correct{i} = Test{i} then Score = sum(Score,1);
	else;
	end;
run;

/*Part C/D: If an employee scores 7 or higher, write the observation to a data set named passed
If an employee scores less than 7, write the observation to a data set named failed*/
title "Exercise 7 Q2 Part C/D";
data test passed (drop = i) failed (drop = i);
	set ex4.test_answers;
	array Correct{10} $ _temporary_ ('A','C','C','B','E','E','D','B','B','A');
	array Test{10} $ Q1-Q10;
	do i = 1 to 10;
	if Correct{i} = Test{i} then Score = sum(Score,1);
	else;
	end;
	if Score >= 7 then output passed;
	else output failed;
run;

/*Question 3: Use PROC PRINT steps to verify that passed contains 12 observations and 
failed contains three observations*/
title "Exercise 7 Q3 Passed";
proc print data = passed;
run;

title "Exercise 7 Q3 Failed";
proc print data = failed;
run;

/*Exercise 8*/
/*Question 1: Use a PROC MEANS step to determine which variables on the dataset have fill 
values (whole number consisting of 8s, such as 8, 888, etc.)*/
title "Exercise 8 Q1";
proc means data = ex4.labsubset;
run;

/*Question 2: Use a DATA step that creates a file work.examsub2 and recodes all values that 
correspond to fill values to SAS unknown values*/
title "Exercise 8 Q2";
data examsub2;
	set ex4.labsubset;
	array fills{10} HGP--URP;
	array unknown{6} _temporary_ (8,88,888,8888,88888,888888);
	do i = 1 to 10;
	if fills{i} eq unknown{1} then fills{i}=.;
	if fills{i} eq unknown{2} then fills{i}=.;
	if fills{i} eq unknown{3} then fills{i}=.;
	if fills{i} eq unknown{4} then fills{i}=.;
	if fills{i} eq unknown{5} then fills{i}=.;
	if fills{i} eq unknown{6} then fills{i}=.;
	end;
run;

/*Question 3: Use a PROC MEANS step to check that your program has run correctly*/
title "Exercise 8 Q3";
proc means data = examsub2;
run;












