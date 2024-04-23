/*Set up options and turn off extra graphics*/
options nocenter nodate nonumber ps=55 ls=78 formdlim '*';
ods graphics off;
/*goptions formats the plot
	colors colors to use
	ftitle font of plot title
	ftext font of the text in the plot except the title
	htitle height of the title
	htext height of the text on the plot except the title*/
goptions reset = all colors=(blue,red,green,purple) ftitle = swissb ftext=swissb htitle=3 htext=1.5;
/*Set up titles*/
title1 'Statistics 157 Exam I Winter 2018';
title2 'Version XXX';
title3 'Sarah Ruckman';
title4 'Question 1';
/*Use proc import to import the data from the excel file
output the data to a temporary SAS dataset called papers1*/
PROC IMPORT OUT = WORK.papers1
/*Read in the data file from the Excel file and the worksheet "reviews"
Use DBMS = xls since the data file is an Excel file
Use GETNAMES = YEs since the column header is included in the data file*/
Datafile = "E:\Data Files\papers1_w18.xls"
DBMS = xls REPLACE;
SHEET = 'reviews';
GETNAMES = YES;
/*Print as check*/
proc print noobs;
run;
quit;
