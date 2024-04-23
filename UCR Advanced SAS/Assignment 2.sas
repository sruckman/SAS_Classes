/*Set up options and turn off extra graphics*/
options nocenter nodate nonumber ps=55 ls=78;
ods graphics off;
/*Use proc import to read in the data in the excel worksheet
out = name of output SAS dataset
dbms= xls since it is an excel .xls file 
replace replaces the directory
sheet = name of sheet
getnames = YES since their is a header in the file */
proc import out = WORK.chips2
datafile= "C:\Users\sarah\Downloads\chips_asmt2_w18.xls"
dbms = xls replace;
sheet = 'chips';
getnames=YES;
/*Create new temporary SAS dataset called chips*/
data chips;
/*Set up titles*/
title1 'Statistics 157';
title2 'Assignment #2';
title3 'Sarah Ruckman';
title4 'Question 1';
/*Use the set command to bring in the data*/
set chips2;
/*Print as check*/
proc print noobs;
/*Create a one-way table using proc freq and remove percentages and cumulative 
values from table using nopercent and nocum*/
proc freq;
tables defectives/ nopercent nocum;
/*Modify title4*/
title4 'Question 2';
/*Use proc means to find the sum of the data*/
proc means sum;
var defectives;
/*Modify title 4*/
title4 'Question 3';
/*Use proc means to find the mean of the data*/
proc means mean;
var defectives;
/*Modify title 4*/
title4 'Question 4';
/*Use proc gchart to create a vertical bar chart that is 3d*/
proc gchart;
/*Set up output
rotate rotates the text
h = height of the font c = color of the text
f = font caxis = color of the axis cfr = color of graph/chart background frame
coutline = color of the outline shape = shape of bars
ctext = color of text within chart/graph*/
title rotate=15 f=swiss h=6 c=teal 'Defective Chips per Shipment';
var3d defectives / caxis=blue cfr = verylightpurplishblue
	coutline = verydarkblue shape =prism ctext = purple;
run;
quit;
