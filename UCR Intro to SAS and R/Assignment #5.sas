options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #5';
title2 'Fall 2017';
title3 'Sarah Ruckman';
title4 'Section 002';
title5 'SAS Question 1';
/*Read infile using do loops do rows and then columns and there are 2 lines of headers*/
/*Create temporary SAS dataset called geysers*/
data geysers;
infile "C:\Users\sarah\Downloads\geysers_f17.dat" firstobs = 3;
do rows = 1 to 10;
do col = 1 to 3;
/*Create if then else statements to label the columns and end with an else statement*/
if      col = 1 then name = 'Old Faithful';
else if col = 2 then name = 'Grand Geysir';
else                 name = 'Strokkur    ';
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
/*Create temporary data set onlyGG*/
data onlyGG;
/*Use set and if command to create dataset with only GG*/
set geysers;
if col =2;
/*Transform the mean to zero*/
newmean = values - 175;
/*Print as a check*/
proc print noobs;
/*Use proc means to generate test information t, t test, and var new mean*/
proc means n mean t probt;
var newmean;
/*Use proc means to create confidence interval for GG and change alpha to 0.02*/
proc means n mean clm alpha=0.02;
by name;
/*Create new temporary SAS dataset called bothGGS*/
data bothGGS;
/*Use set command to call back to the original dataset and if statement to grab only GG and S*/
set geysers;
if col not=1;
/*Print as check*/
proc print noobs;
/*Use proc ttest to generate a test of variances and t test if approporiate*/
proc ttest;
class col;
var values;
run;
quit;
