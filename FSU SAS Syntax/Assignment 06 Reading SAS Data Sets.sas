/* Assignment 06 Reading SAS Data Sets */
/* Sarah Ruckman */

/*Question 1 */
/*Part A: create a library called customer that points to the directory with customer_dim */
title "Question 1 Part A";
libname customer '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Using the data set customers.customer_dim, create a temporary data set youth that contains only observations meeting all of the following conditions:
Female customers, Customer_Age is between 18 and 36, and Have the word Gold in their Customer_Group */
title "Question 1 Part B";
data youth; 
	set customer.customer_dim;
	where (Customer_Gender = 'F') and (Customer_Age between 18 and 36) and (Customer_Group contains 'Gold');
run;

proc print data = youth;
run;

/*Part C: The data set youth should contain only the variables: 
	Customer_Name, Customer_Age, Customer_BirthDate, Customer_Gender, and Customer_Group */
title "Question 1 Part C";
data youth;
	set customer.customer_dim;
	where (Customer_Gender = 'F') and (Customer_Age between 18 and 36) 
		and (Customer_Group contains 'Gold');
	keep Customer_Name Customer_Age Customer_BirthDate Customer_Gender Customer_Group;
run;

proc print data = youth noobs;
run;


/*Question 2 */
/*Part A: Create a library called prg1 that points to the data set product dim */
title "Question 2 Part A";
libname prg1 '/home/u62104146/my_shared_file_links/jhshows0/STA5066';

/*Part B: Use the data step to create a temporary data set sports that includes only 
observations with Supplier_Country from Great Britain (GB), Spain (ES), or Netherlands (NL) 
and Product_Category values that end in the word Sports */
title "Question 2 Part B";
data sports;
	set prg1.product_dim;
	where Supplier_Country in ('GB', 'ES', 'NL') and Product_Category like '%Sports';
run;
proc print data = sports noobs;
run;

/* Part C: The data set work.sports should not include the variables Product_ID, Product_Line,
 Product_Group, and Supplier_ID */
title "Question 2 Part C";
data sports;
	set prg1.product_dim;
	where Supplier_Country in ('GB', 'ES', 'NL') and Product_Category like '%Sports';
	drop Product_ID Product_Line Product_Group Supplier_ID;
run;
proc print data = sports noobs;
run;

/*Part D: The data set work.sports should contain the labels Sports Category, 
Product Name (Abbrev), and Supplier Name (Abbrev)*/
title "Question 2 Part D";
data sports;
	set prg1.product_dim;
	where Supplier_Country in ('GB', 'ES', 'NL') and Product_Category like '%Sports';
	drop Product_ID Product_Line Product_Group Supplier_ID;
	label Product_Category = "Sports Category"
		Product_Name = "Product Name (Abbrev)"
		Supplier_Name = "Supplier Name (Abbrev)";
run;
proc print data = sports noobs label;
run;

/*Part E: The data set work.sports should include formats to assure that only 
the first 15 letters of Product_Name and Supplier_Name are displayed. */
title "Question 2 Part E";
data sports;
	set prg1.product_dim;
	where Supplier_Country in ('GB', 'ES', 'NL') and Product_Category like '%Sports';
	drop Product_ID Product_Line Product_Group Supplier_ID;
	label Product_Category = "Sports Category"
		Product_Name = "Product Name (Abbrev)"
		Supplier_Name = "Supplier Name (Abbrev)";
	format Product_Name $15. Supplier_Name $15.;
run;

/*Part F: Include a PROC CONTENTS step and verify that the labels and 
format specifications are included in the descriptor portion. */
title "Question 2 Part F";
proc contents data = sports details;
run;

/*Part G: Include a PROC PRINT step to display 14 observation from the data set work.sports */
title "Question 2 Part G";
proc print data = sports (obs = 14) label;
run;


/*Question 3 */
title "Question 3";
libname Nhanes3 '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part A: Use a data step to create a temporary data set called, examsub1, that contains 
the following subset of variables from the exam data set. The names that these variables 
should have in the data set examsub1 is provided in the last column. */
title "Question 3 Part A";
data examsub1;
	set Nhanes3.exam;
	keep hsageir hssex dmaracer bmpwt bmpht pep6g1 pep6h1 pep6i1 pep6g3 pep6h3 pep6i3 sppfvc sppfev1;
	rename hsageir = age hssex = gender dmaracer = race 
		bmpwt = wt_kg bmpht = ht_cm pep6g1 = sbp1 
		pep6h1 = sbp2 pep6i1 = sbp3 pep6g3 = dbp1
		pep6h3 = dbp2 pep6i3 = dbp3 sppfvc = fvc sppfev1 = fvc1;
run;

proc print data = examsub1 (obs=10);
run;

/*Part B: For the variables pep6g1, peph1, pep6i1, pep6g3, pep6h3, and pep6i3 include 
formats to assure that, when printed, these variables will be displayed as integers (no decimal)*/
title "Question 3 Part B";
data examsub1;
	set Nhanes3.exam;
	keep hsageir hssex dmaracer bmpwt bmpht pep6g1 pep6h1 pep6i1 pep6g3 pep6h3 pep6i3 sppfvc sppfev1;
	rename hsageir = age hssex = gender dmaracer = race 
		bmpwt = wt_kg bmpht = ht_cm pep6g1 = sbp1 
		pep6h1 = sbp2 pep6i1 = sbp3 pep6g3 = dbp1
		pep6h3 = dbp2 pep6i3 = dbp3 sppfvc = fvc sppfev1 = fvc1;
	format pep6g1 3. peph1 3. pep6i1 3. pep6g3 3. pep6h3 3. pep6i3 3.;
run;

/*Part C: Add a step to print the first 7 observations of the data set examsub1 to 
make sure the printing is done correctly*/
title "Question 3 Part C";
proc print data = examsub1 (obs=7);
run;

/*Part D: Add a step to display the entire descriptor portion of the data set examsub1*/
title "Question 3 Part D";
proc contents data = examsub1 details;
run;

/*Question 4 */
/*Part A: Create a library, NH, that points to the location of the data set lab. */
title "Question 4 Part A";
libname NIH '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Create a temporary SAS data set, labsub1, a subset of the NH.lab data set. */
title "Question 4 Part B";
data labsub1;
	set NIH.lab;
run;
proc print data = labsub1 (obs = 10);
run;

/*Part C: work.labsub1 should contain only the following variables */
title "Question 4 Part C";
data labsub1;
	set NIH.lab;
	keep seqn hgp htp tcp tgp lcp hdp fbpsi crp sgp urp;
run;

/*Part D: Use a proc contents step to verify that the data set labsub1 has the correct variables. */
title "Question 4 Part D";
proc contents data = labsub1 details;
run;

/*Part E: Use a proc print step to print the first 5 observations on the data set labsub1. */
title "Question 4 Part E";
proc print data = labsub1 (obs = 5);
run;

/*Question 5 */
/*Part A: Create a library, nh3, that points to the location of the mortality data set */
title "Question 5 Part A";
libname nh3 '/home/u62104146/my_shared_file_links/jhshows0/STA5066/';

/*Part B: Use a data step to create a temporary SAS data set, mortsub1 that contains only those 
observations on the nh3.mortality data set  for which the variable eligstat is equal to 1. */
title "Question 5 Part B";
data mortsub1;
	set nh3.mortality;
	where eligstat = 1;
run;
proc print data = mortsub1 (obs =10);
run;

/*Part C: The data set work.mortsub1 should contain only the variables
SEQN and MORTSTAT. The variable mortstat should be labeled as “Mortality Status.” */
title "Question 5 Part C";
data mortsub1;
	set nh3.mortality;
	where eligstat = 1;
	keep SEQN MORTSTAT;
	label mortstat = "Mortality Status.";
run;

/*Part D: Use a proc contents step to examine the descriptor portion of work.mortsub1 */
title "Question 5 Part D";
proc contents data = mortsub1 details;
run;

/*Part E: Use a proc print step to display the first 100 observations on the data set mortsub1*/
title "Question 5 Part E";
proc print data = mortsub1 (obs =100) label;
run;
