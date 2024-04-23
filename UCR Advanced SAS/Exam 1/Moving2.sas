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
/*Create a new SAS temporary dataset called moving2*/
data moving2;
/*Use an infile statement to read in the data*/
infile 'E:\Data Files\moving2_w18.dat' firstobs = 3;
/*input the variables*/
input Strength Percent @@;
/*Print as check*/
proc print noobs;
run;
quit;
