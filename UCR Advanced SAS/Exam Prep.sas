/*Set up format for the output*/
options ls = 78 ps = 55 nodate nonumber nocenter mtrace mlogic mprint;
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
quarter1 quarter and year
filenum which data file (1 or 2)
*******************************************************************
*/
%macro heading1(filenum);
	title1 "Statistics 157 Exam II Prep";
	title2 "Winter 2018";
	title3 "Sarah Ruckman";
	title4 "DVM inc";
	title5 "Veterinarian File &filenum";
%*Close the macro;
%mend heading1;
/******************************************************************
macro indata1 to read in and print out the data
Parameters:
start first file number
stop ending file number
newdata name of data set
first line for the first observations
filepath path to the file
******************************************************************/
%macro indata1(start,stop,newdata,first,filepath);
%*Use a do loop to read in both files;
%do i = &start %to &stop;
%*Create a temporary SAS dataset;
data &newdata&i;
%*Use an infile statement to read in the data with the parameters;
infile "&filepath&i..dat" firstobs = &first;
%*Input the variables with 1-10 to not cut off the names;
input Name $ 1-10 Years Spec1 $ Spec2 $ Gender $;
%*Run the heading1 marco;
%heading1(&i);
%*Print the data as a check;
proc print noobs;
%*Close the macro do loop;
%end;
%*Close the macro;
%mend indata1;
/*************************************************************************
	macro combine1 macro to combine all data files

	Variable Specification:
	basename base name of existing SAS dataset
	number number of files to combine
*************************************************************************/
	%macro combine2(basename,number);
%*Create new temporary SAS dataset called combine1;
	data combine2;
%*Use the set command to concatenate all of the files;
	set %namelst(&basename,&number);
%*Create new title 6;
	title5 'Veterinarian File Combined Data';
%*Print as check;
	proc print;
%*Close the macro;
	%mend combine2;
/*Invoke the macro
	Format: %indata1(start,stop,newdata,first,filepath); */
%indata1(1,2,newvet,3,C:\Users\sarah\Downloads\newvet);
/*Invoke the macro
	Format: %combine2(basename,number); */
%combine2(newvet,2);
run;
quit;

