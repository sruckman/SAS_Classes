/*Set up format for the output*/
options ls = 78 ps = 55 nodate nonumber nocenter mtrace mlogic mprint;
ods graphics off;
/********************************************************************
Create the indata1 macro to read in and print out the data
Variables
newdata temporary sas dataset name
name datafile name
first firstobs number
end ending obs line
which which do loop to use
var1 variable name to input
rows row number
cols column number
rsample row name
csample column name
********************************************************************/
%macro indata1(newdata,name,first,end,which,var1,rows,cols,rsample,csample);
%*Create temporary SAS dataset called die;
data &newdata;
%*Use an infile statement to read in the data;
infile "&name" firstobs = &first obs = &end;
%*Use do loops and if then else to read in the data;
%if &which = 1 %then
	%do;
		input &var1 @@;
	%end;
%else
	%do;
	%do rownum = 1 %to &rows;
		%do colnum = 1 %to &cols;
		input &var1 @@;
		&csample = &colnum;
		&rsample = &rownum;
		output;
		%end;
	%end;
	%end;
proc print;
%*Close the macro;
%mend indata1;
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
/******************************************************************
Macro indata2 to read in and print out the regression data
Variables
newdata name of new SAS temporary dataset
dataname datafile to be read in
first firstobs line number
yvar name of dependent variable
name name of sequential variable (independent)
number number of sequentially named variables to be created
******************************************************************/
%macro indata2(newdata,dataname,first,yvar,name,number);
data &newdata;
	infile "&dataname" firstobs = &first;
	input &yvar %namelst(&name,&number) @@;
proc print noobs;
run;
%mend indata2;
/*************************************************************************************
Macro rselect macro designed to invoke proc reg to do multiple regression and select for
					one of the following:
					1. stepwise
					2. best subset
					3. none
Variables:
olddata name of existing SAS dataset
yvar name of dependent variable
indep name of sequential indep variable
number number of independent variables
which variable to select options:
	which = 1 invokes stepwise
	which = 2 invokes best subset
	which = 3 invokes proc reg with no specified options
**************************************************************************************/
%macro rselect(olddata,yvar,indep,number,which);
%if &which = 1 %then
%do;
	proc reg data = &olddata;
		model &yvar = %namelst(&indep,&number)/selection = stepwise
			sle = 0.05 sls = 0.05;
			run;
%end;
%else %if &which = 2 %then
%do;
	proc reg data = &olddata;
		model &yvar = %namelst(&indep,&number)/selection = rsquare cp
			mse adjrsq best = 1;
			run;
%end;
%else
%do;
	proc reg data = &olddata;
		model &yvar = %namelst(&indep,&number);
		run;
%end;
%mend rselect;
/*Invoke the macro indata1
	Format: %indata1(newdata,name,first,end,which,var1,rows,cols,rsample,csample); */
%indata1(dice,E:\Data Files\pr2datw18.dat,3,5,1,number, , , , );
%indata1(city,E:\Data Files\pr2datw18.dat,8,10,2,watchers,3,4,party,network);
%indata1(city2,E:\Data Files\pr2datw18.dat,8,10,2,watchers,3,4,rows,network);
/*Invoke the macro indata2
	Format: %indata2(newdata,dataname,first,yvar,name,number); */
%indata2(auto,E:\Data Files\auto2.dat,3,y,indep,6);
/*Invoke the macro rselect
	Format: %rselect(olddata,yvar,indep,number,which); */
%rselect(auto,y,indep,6,1);
%rselect(auto,y,indep,6,2);
%rselect(auto,y,indep,6,3);
run;
quit;
