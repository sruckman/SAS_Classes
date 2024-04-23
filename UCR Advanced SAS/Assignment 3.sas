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
/*Create new SAS temporary dataset*/
data mat1;
/*Set up titles*/
title1 'Statistics 157 Winter 2018';
title2 'Assignment #3';
title3 'Sarah Ruckman';
title4 'Question 1 Part i';
/*Invoke proc iml to complete matrix calculations*/
proc iml;
/*initialize matricies*/
A = {3 -2 1, 2 1 -1, 1 -4 3};
B = {4.5, 1.5, 8.5};
/*Use trace(A) to find the trace of matrix A*/
TraceA = trace(A);
/*Print the results*/
print ,,, A, B, 'Trace of A',, TraceA;
/*Find the product of A and B by creating a new variable PROD1*/
PROD1 = A*B;
/*Revise title4*/
title4 'Question 1 Part ii';
/*Print the results*/
print ,,,'Product of A and B',, PROD1;
/*Find the determinat of A*/
/*Revise title4*/
title4 'Question 1 Part iii';
DET1 = det(A);
/*Print the results*/
print ,,, 'Determinat of A', DET1;
/*Find the inverse of matrix A*/
/*Revise title4*/
title4 'Question 1 Part iv';
/*Use do loops with if then else to get the answer*/
if DET1 = 0 then
do;
	print ,,, 'Since the determinant = 0, the matrix A is singular and does not have an inverse';
end;
else
do;
AINV = inv(A);
/*Check Product*/
PROD2 = A*AINV;
/*Print the results*/
print ,,, A, 'Inverse of A', AINV, 'Product check', PROD2;
end;
/*Find the solution to the system of equations using AINV*B*/
/*Revise title4*/
title4 'Question 1 part v';
SOLN = AINV*B;
/*Print the results*/
print ,,, 'Solution is' SOLN;
/*Create new SAS temporary dataset*/
data q2;
/*Revise title4*/
title4 'Question 2 part i';
/*Invoke proc iml to complete matrix calculations*/
proc iml;
/*Create matricies*/
A = {4 2, 2 1};
B = {21, 12};
/*Use det(A) to find the determinant of A*/
DETA = det(A);
/*Print the results*/
print ,,,A, 'Determinant of A', DETA;
/*Find the inverse of matrix A*/
/*Revise title4*/
title4 'Question 2 Part ii';
/*Use do loops with if then else to get the answer*/
if DETA = 0 then
do;
	print ,,, 'Since the determinant = 0, the matrix A is singular and does not have an inverse';
end;
else
do;
AINV = inv(A);
/*Check Product*/
PROD2 = A*AINV;
/*Print the results*/
print ,,, A, 'Inverse of A', AINV, 'Product check', PROD2;
end;
/*Find the solution to the system of equations using AINV*B*/
/*Revise title4*/
title4 'Question 2 part iii';
/*Use do loops with if then else to get the answer*/
if DETA = 0 then
do;
print,'Since the determinant = 0, the matrix A is singular and does not have an inverse nor a solution to the system of equations';
end;
else
do;
INVA = inv(A);
SOLN1 = INVA*B;
/*Print the results*/
print ,,, 'Inverse of A', AINV, 'The solution is' SOLN1;
end;
/*Create a new SAS temporary dataset called assign3q3*/
data assign3q3;
/*Revise title4*/
title4 'Question 3 part i';
/*Read in the data using an infile statement it starts on line 3*/
infile 'C:\Users\sarah\Downloads\REPAIR1_w18.dat' firstobs = 3;
/*Input the variables x (Mileage) and y (Amount)*/
input x y @@;
/*Print as check*/
proc print noobs;
/*Create a high resolution plot of y versus x*/
/*Revise title4*/
title4 'Question 3 Part ii';
/*Use a symbol statement to set up the format of the plt symbols
	value symbol of the data points
	height height of the symbol of the data points
	cv color of the symbol*/
symbol1 value = star height = 3 cv = red;
/*Use proc gplot to generate the high resolution plot 
plot vertical(y) vs horizontal(x)
caxis color of the axes
ctext color of the text on the plot*/
proc gplot;
title5 'Scatterplot of Amount vs. Mileage';
plot y*x / caxis = darkred ctext=black;
/*Find the correlation coefficient using proc corr
Use proc corr to generate correlation between x and y
Use nosimple to supress the printing of the descriptive stats
Use noprob to suppress printing of the stats for testing the correlation = 0*/
proc corr nosimple noprob;
/*Revise title 4 and 5*/
title4 'Question 3 Part iii';
title5 'Correlation Between Mileage and Amount';
var x y;
/*Use proc reg to compute ANOVA table for linear regression
model dependent_variable = independent_variable*/
proc reg;
/*Revise title 4 and 5*/
title4 'Question 3 Part iv';
title5 'Regression Information';
model y = x; 
/*Use proc reg to compute ANOVA table for linear regression. Use the P and R options to generate the predicted residual
values Output the data so that a residual plot may be generated*/
proc reg;
/*Revise title 4 and 5*/
title4 'Question 3 Part vi';
title5 ' ';
model y = x / P R;
/*Output the data to a SAS data set named q3*/
output out = q3 P = pred R = resid Student = stdres;
/*Create a residual plot using proc gplot*/
proc gplot data = q3;
/*Revise title 4 and 5*/
title4 'Question 3 Part vii';
title5 'Residual Plot';
plot stdres*pred;
/*Create a new SAS temporary dataset called assign3q4*/
data assign3q4;
/*Revise title4*/
title4 'Question 4 part i';
/*Read in the data using an infile statement it starts on line 3, but I need to remove the first obs as it is a suspect outlier*/
infile 'C:\Users\sarah\Downloads\REPAIR1_w18.dat' firstobs = 4;
/*Input the variables x (Mileage) and y (Amount)*/
input x y @@;
/*Print as check*/
proc print noobs;
/*Find the correlation coefficient using proc corr
Use proc corr to generate correlation between x and y
Use nosimple to supress the printing of the descriptive stats
Use noprob to suppress printing of the stats for testing the correlation = 0*/
proc corr nosimple noprob;
/*Revise title 4 and 5*/
title5 'Correlation Between Mileage and Amount';
var x y;
/*Use proc reg to compute ANOVA table for linear regression
model dependent_variable = independent_variable*/
proc reg;
/*Revise title 4 and 5*/
title4 'Question 4 Part ii and iii';
title5 'Regression Information';
model y = x; 
/*Use proc reg to compute ANOVA table for linear regression. Use the P and R options to generate the predicted residual
values Output the data so that a residual plot may be generated*/
proc reg;
/*Revise title 4 and 5*/
title4 'Question 4 Part iv';
title5 ' ';
model y = x / P R;
/*Output the data to a SAS data set named q3*/
output out = q4 P = pred1 R = resid1 Student = stdres1;
/*Create a residual plot using proc gplot*/
proc gplot data = q4;
/*Revise title 4 and 5*/
title4 'Question 4 Part v';
title5 'Residual Plot';
plot stdres1*pred1;
/*Test for normality of the student residuals using proc univariate with the normal option
	Use ods select TestsForNormality to only print the normality test information*/
proc univariate data = q4 normal;
ods select TestsForNormality;
var stdres1;
/*Revise title 4 and 5*/
title4 'Question 4 Part vi';
title5 'Test for Normality of Residuals'; 
run;
quit;
