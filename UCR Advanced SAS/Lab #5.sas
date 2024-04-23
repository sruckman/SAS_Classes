options nocenter nodate nonumber ps=55 ls=78 mtrace mprint mlogic;
ods graphics off;
/*
*******************************************************************
Macro namelst macro designed to generate a list of sequential data
	file names where the name and the number of the files are
	specified by the user
Variable specification:
name name of the sequential data files to be generated in the list
number number of the data files names to be generated in the list
*******************************************************************
*/
%macro namelst(name,number);
%do n = 1 %to &number;
	&name&n
%end;
%mend namelst;
/*
*******************************************************************
macro heading1 macro to generate titles
Parameters
what parameter to identify what object
number1 number of the object
qnum question number
quarter1 quarter and year
whichdata which data file (1 or 2)
*******************************************************************
*/
%macro heading1(what,number1,quarter1,qnum,whichdata);
	title1 "Stats 157 &what &number1 &quarter1";
	title2 "Sarah Ruckman";
	title3 "Question &qnum";
	title4 "Data Set &whichdata";
%*Close the macro;
%mend heading1;
/*
********************************************************************
macro reg1 macro designed to generate linear regression output
	including predicted and residuals and residual plot
Parameters
dep dependent variable
indep independent variables base
number_indep number of independent variables
whichdata number to append to predicted and residual values and temp
	SAS dataset
********************************************************************
*/
%macro reg1(dep,indep,number_indep,whichdata);
%*Generate regression model;
proc reg;
model &dep = %namelst(&indep,&number_indep) / P R;
%*Output the information;
output out = a&whichdata P = pred&whichdata R = resid&whichdata
	Student = stdres&whichdata;
%*Create high res plot of student residuals vs predicted values;
proc gplot;
plot stdres&whichdata*pred&whichdata;
%*Use proc univariate to test for normality of the studentized residuals;
proc univariate normal;
ods select TestsForNormality;
%*Use var statement to only get the studentized residuals;
var stdres&whichdata;
run;
%*Close the macro;
%mend reg1;
data dataset1;
infile 'C:\Users\sarah\Downloads\achieve1_w18.dat' firstobs = 3;
input y x1 x2 x3 x4;
proc print noobs;

/*
*************************************************************
marco indata1 macro to read in  and print out sequentially 
	named data files
whichdata which data files
what parameter to identify what object this is (lab assign)
number1 number of the object
qnum question number
quarter1 quarter and year (separarted by a space)
numb_files number of data files
indep name of independent variable
number_indep number of independent variables
*************************************************************
*/
%macro indata1(what,number1,qnum,quarter1,numb_files,indep,number_indep);
%*Use macro do loop to read in and print out the multiple data files;
%do whichdata = 1 %to &numb_files;
%*Create temporary data set for each data file;
data dataset&whichdata;
	%heading1(Lab,5,Winter 2018,1,&whichdata);
%*Use infile statement to open the data file;
%*Be sure to change the path and use double quotes;
%*Dont forget the &sign and a dot at the end of the word;
infile "C:\Users\sarah\Downloads\achieve&whichdata._w18.dat" firstobs = 3;
%*Use an input statement to read in the data;
input y %namelst(&indep,&number_indep);
%*Print as check;
proc print;
%*Invoke the reg1 macro to generate regression information and plot;
%reg1(y,&indep,&number_indep,&whichdata);
%*Close the do loop;
%end;
%*Close the macro;
%mend indata1;
/*Invoke the macro Format: indata1(what,number1,qnum,quarter1,numb_files)*/
%indata1(Lab,5,1,Winter 2018,2,x,4);
run;
quit;
