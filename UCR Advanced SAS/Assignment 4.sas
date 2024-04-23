/*Set up options and turn off extra graphics*/
options nocenter nodate nonumber ps=55 ls=78;
ods graphics off;
/*goptions formats the plot
	cback color of the plot background
	colors colors to use
	ftitle font of plot title
	htitle height of the title
	htext height of the text on the plot */
goptions reset = all colors=(blue,red,green,purple) ftitle = swissb ftext=swissb htitle=3;
/*Set up titles*/
title1 'Statistics 157 Winter 2018';
title2 'Assignment #4';
title3 'Sarah Ruckman';
title4 'Question 1';
/*Create new SAS temporary dataset*/
data foot;
/*Use an infile statement to read in the data */
infile 'C:\Users\sarah\Downloads\footballw18.dat' firstobs = 2;
/*Input the variables*/
input HangTime RLS LLS RHF LHF Power @@;
/*Print as a check*/
proc print noobs;
/*Use proc corr to find the correlation between the variables*/
proc corr nosimple noprob;
/*Revise title4*/
title4 'Question 2';
/*Use proc reg to find the regression equation for all of the variables*/
proc reg;
model HangTime = RLS LLS RHF LHF Power / P R;
/*Revise title 4*/
title4 'Question 3';
/*Use proc reg with the options selection = rsquare, adjrsq, mse, cp, and best = 2 to create a new reg equation*/
proc reg;
model HangTime = RLS LLS RHF LHF Power / selection = rsquare adjrsq mse cp best=2;
/*Revise title 4*/
title4 'Question 4';
/*Use proc reg with the options selection = stepwise sle = 0.05 entering less than, and leaving alpha sls = 0.05*/
proc reg;
model HangTime = RLS LLS RHF LHF Power / P R selection = stepwise sle = 0.05 sls = 0.05;
/*Revise title 4*/
title4 'Question 5';
/*Output the data*/
output out = hangtime2 P = pred R = resid Student = stdres;
/*Create a residual plot using proc gplot*/
proc gplot data = hangtime2;
/*Revise title 4 and 5*/
title4 'Question 5 Part V';
title5 height = 2 color = red 'Residual Plot';
plot stdres*pred;
/*Use proc univariate with the normal option to generate the test for normality information*/
proc univariate data = hangtime2 normal;
ods select TestsForNormality;
var stdres;
/*Revise title 4 and 5*/
title4 'Question 5 Part vi';
title5 ' ';
/*Create a new SAS temporary dataset to remove the last data point*/
data football2;
/*Use an infile statement with firstobs and obs options to remove the last data point*/
infile 'C:\Users\sarah\Downloads\footballw18.dat' firstobs = 2 obs = 10;
/*input the variables*/
input HangTime RLS LLS RHF LHF Power @@;
/*Print as check*/
proc print noobs;
/*Revise title 4*/
title4 'Question 6';
/*Use proc reg with the options selection = stepwise sle = 0.05 entering less than, and leaving alpha sls = 0.05*/
proc reg;
model HangTime = RLS LLS RHF LHF Power / P R selection = stepwise sle = 0.05 sls = 0.05;
/*Revise title 5*/
title5 'Regression Model 2';
/*Output the data*/
output out = hangtime3 P = pred1 R = resid1 Student = stdres1;
/*Create a residual plot using proc gplot*/
proc gplot data = hangtime3;
/*Revise title 5*/
title5 height = 2 color = red 'Residual Plot of Model 2';
plot stdres1*pred1;
/*Use proc univariate with the normal option to generate the test for normality information*/
proc univariate data = hangtime3 normal;
ods select TestsForNormality;
var stdres1;
/*Revise title 5*/
title5 'Test for Normality';
run;
quit;
