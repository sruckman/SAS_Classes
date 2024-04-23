options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
ods graphics off; /*Turns off any extra graphics*/
/* Create titles */
title1 'Statstics 157 Winter 2018';
title2 'Assignment #1';
title3 'Sarah Ruckman';
title4 'Question 1 Part i';
/*Create SAS temporary dataset called quality2 and use an infile statement with firstobs =2 to read in the data*/
data quality2;
infile 'C:\Users\sarah\Downloads\QUALITY2_W18.DAT' firstobs=2;
/*Use input statement to label variables*/
input defectives;
/*Print as check*/
proc print noobs;
/*Create a one-way table using the proc freq function and tables with input variable*/
proc freq;
tables defectives;
/*Change title 4*/
title4 'Question 1 part ii';
proc means;
var defectives;
/*Change title 4*/
title4 'Question 1 Part v';
/*Create new SAS temporary dataset called IceCream and use an infile statement to read it in firstobs=2*/
data IceCream;
infile 'C:\Users\sarah\Downloads\icecream1_w18.dat' firstobs = 2;
/*Change title4*/
title4 'Question 2 Part i';
/*Read in using do loops do rows then columns*/
do row = 1 to 3;
/*Use if then else structure to label the rows*/
	 if row = 1 then age = '< 21   ';
else if row = 2 then age = '21 - 45';
else                 age = '> 45   ';
/*do columns*/
do brandpref = 1 to 3;
/*Use if then else structure to label the columns*/
	 if brandpref = 1 then brand = 'Breyers          ';
else if brandpref = 2 then brand = 'Dreyers          ';
else                       brand = 'Private Selection';
/*Use an input statement to read in the data*/
input wt @@;
/*Output the data and close both loops with two end statments*/
output;
end;
end; 
/*Print the results*/
proc print noobs;
/*Use proc freq to generate chi square test with the functions:
wt name of the response variable
nopercent suppresses printing cell percents
norow suppresses printing of row percentages
nocol suppresses printing of column percentages
chisq prints test statistic 
expected prints expected frequencies*/
proc freq;
weight wt;
tables age*brand / chisq expected norow nocol nopercent;
/*Modify title 4*/
title4 'Question 2 Part ii';
/*create temporary SAS dataset called jerseys*/
data jerseys;
/*Read in the data using an infile statement firstobs = 2*/
infile 'C:\Users\sarah\Downloads\jerseys1_w18.dat' firstobs = 2;
/*Use do loops to read in the data First do rows then columns*/
do shift = 1 to 2;
/*Use the if then else structure to name the shift time*/
	 if shift = 1 then time = 'Day  ';
else                   time = 'Night';
do classification = 1 to 2;
/*Use the if then else structure to name the classification variables*/
	 if classification = 1 then jersey = 'Nondefective';
else                            jersey = 'Defective   ';
/*Input the response variable*/
input wt @@;
/*Output the data and close both loops*/
output;
end;
end;
/*Modify title 4*/
title4 'Question 3';
/*Print the results as a check*/
proc print noobs;
/*Use proc freq to generate chi square test with the functions:
wt name of the response variable
nopercent suppresses printing cell percents
norow suppresses printing of row percentages
nocol suppresses printing of column percentages
chisq prints test statistic 
expected prints expected frequencies*/
proc freq order = data;
weight wt;
tables shift*classification / chisq expected norow nocol nopercent;
/*Create new SAS temporary dataset called pen*/
data pen;
/*Input the variable as color $(character variable) and ink for the frequency*/
input color $ ink;
datalines;
black 28
blue 26
red 18
other 8
;
/*Modify title 4*/
title4 'Question 4';
/*Print the results as a check*/
proc print noobs;
/*Use the proc freq function with order = data to keep the data together then create a table using the tables function
use the chisq function to do a chisq test and testp with the expected frequencies*/
proc freq order = data;
tables color / chisq testp = (30 30 25 15);
weight ink;
/*Create new sas temporary dataset called hotline*/
data hotline;
/*Use an infile statement with firstobs = 2 to read in the data*/
infile 'C:\Users\sarah\Downloads\HOTLINE_w18.DAT' firstobs = 2;
/*Input the variable*/
input time;
/*Modify title 4*/
title4 'Question 5';
/*Print as check*/
proc print noobs;
/*Use proc univariate to generate goodness of fit information 
ods select GoodnessOfFit suppresses printing of everything except goodness of fit output
histogram / distribution_name(parameter list)*/
proc univariate;
ods select GoodnessOfFit;
var time;
histogram / exponential(sigma=7.5);
/*Create new sas temporary dataset called completion*/
data completion;
/*Use an infile statement with firstobs = 2*/
infile 'C:\Users\sarah\Downloads\completion1_w18.dat' firstobs = 2;
/*Input the variable time*/
input time;
/*Modify title 4*/
title4 'Question 6';
/*Print as check*/
proc print noobs;
/*Use proc univariate to generate goodness of fit information 
ods select GoodnessOfFit suppresses printing of everything except goodness of fit output
histogram / distribution_name(parameter list)*/
proc univariate;
ods select GoodnessOfFit;
var time;
histogram / normal(mu=est sigma=est);
run;
quit;
