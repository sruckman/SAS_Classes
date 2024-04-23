options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #4';
title2 'Fall 2017';
title3 'Sarah Ruckman';
title4 'Section 002';
title5 'SAS Question 1';
/*Read infile using do loops do rows and then columns and there are 2 lines of headers*/
/*Create temporary SAS dataset called geysers*/
data geysers;
infile "C:\Users\sarah\Downloads\geysers_f17.dat" firstobs = 3;
do rows = 3 to 12;
do col = 1 to 3;
/*Create if then else statements to label the columns and end with an else statement*/
if      col = 1 then name = 'OF';
else if col = 2 then name = 'GG';
else                 name = 'S ';
/*input the values and add @@ to denote that the values are on the same line*/
input values @@;
/*Output the results*/
output;
/*Close both loops*/
end;
end;
/*Sort the data by column using proc sort*/
proc sort;
by name;
/*Print as check without observations*/
proc print noobs;
/*Use proc means to find the mean stddev and var for each geyser*/
proc means mean stddev var;
by name;
/*Use the set command and an if statement to create a data set with only GG*/
/*Create a temporary SAS dataset*/
data onlyGG;
set geysers;
if col =2;
/*Print the results*/
proc print noobs;
/*Use the set command and an if statement to create a data set with GG and S using a not=1*/
/*Create temporary SAS dataset*/
data bothGGS;
set geysers;
if col not= 1;
/*Print the results*/
proc print noobs;
/*Create new dataset with infile statement for question 2*/
data dogdive;
infile "C:\Users\sarah\Downloads\dogdive_f17.dat" firstobs = 3;
/*input the variable feet*/
input Dog$ Dive1 Dive2;
/*Change title 5*/
title5 'SAS Question 2';
/*Print the results without observation numbers*/
proc print noobs;
/*Use proc means statement to find the mean median and stddev*/
proc means mean median stddev;
var Dive1;
run;
quit;
