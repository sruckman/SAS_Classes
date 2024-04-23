/*Set up format for the output*/
options ls = 78 ps = 55 nodate nonumber nocenter mtrace mlogic mprint;
ods graphics off;
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
%macro heading1(what,number1,quarter1,filenum);
	title1 "Statistics 157 &quarter1";
	title2 "&what &number1";
	title3 "Sarah Ruckman";
	title4 "Macro Veterinarians, Inc.";
	title5 "Ura Vet, DVM";
	title6 "Veterinarian File &filenum";
%*Close the macro;
%mend heading1;
/* ******************************************************************
macro importing
USAGE: to read in Excel files
Variables:
start sheet number to start
stop sheet number to stop
name1 base name of the worksheets
name2 name to add on for new SAS dataset
filename name and path to Excel file to be read in
******************************************************************* */
%macro indata1(start,stop,name1,name2,filename);
%*Setup macro do loop to read in series of worksheets;
%do i = &start %to &stop;
%* Use proc import to import the excel file;
PROC IMPORT OUT = WORK.&name1&i
	DATAFILE= "&filename&i..xls"
	DBMS=xls REPLACE;
	SHEET="&name1&i";
	GETNAMES=YES;
%*Create new SAS temporary dataset;
	data &name1&i&name2;
%*	Format %heading1(what,number1,quarter1,&i);
	%heading1(Assignment,5,Winter 2018,&i);
%*Use set command to get information from output file;
	set &name1&i;
%*Print the data as check;
	proc print noobs;
%*Close the marco do loop;
	%end;
%*Close the macro;
	%mend indata1;
/*Execute the macro
	Format %indata1(start,stop,name1,name2,filename_including_path)
Be sure you change the path to your file*/
	%indata1(1,2,dog,b,C:\Users\sarah\Downloads\dogs_w18);
run;
quit;
