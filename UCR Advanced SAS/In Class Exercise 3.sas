/*Set up format for the output*/
options ls = 78 ps = 55 nodate nonumber nocenter mtrace mlogic mprint;
/* ******************************************************************
macro importing
USAGE: to read in multiple worksheets in an Excel file
Variables:
start sheet number to start
stop sheet number to stop
name1 base name of the worksheets
name2 name to add on for new SAS dataset
filename name and path to Excel file to be read in
******************************************************************* */
%macro importing(start,stop,name1,name2,filename);
%*Setup macro do loop to read in series of worksheets;
%do i = &start %to &stop;
%* Use proc import to import the excel file;
PROC IMPORT OUT = WORK.&name1&i
	DATAFILE= "&filename"
	DBMS=xls REPLACE;
	SHEET="&name1&i";
	GETNAMES=YES;
%*Create new SAS temporary dataset;
	data &name1&i&name2;
%*Set up titles;
	title "Site &i";
%*USe set command to get information from output file;
	set &name1&i;
%*Print the data as check;
	proc print noobs;
%*Use proc means to generate descriptive stats;
	proc means mean median stddev;
%*Close the marco do loop;
	%end;
%*Close the macro;
	%mend importing;
/*Execute the macro
	Format %importing(start,stop,name1,name2,filename_including_path)
Be sure you change the path to your file*/
	%importing(1,3,site,b,C:\Users\sarah\Downloads\xcel_sample_w18.xls);
	run;
	quit;
