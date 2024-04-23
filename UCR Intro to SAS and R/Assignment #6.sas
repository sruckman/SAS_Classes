options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
ods graphics off;
/*Turns off extra graphics*/
/* Create titles */
title1 'Statstics 147 Assignment #6';
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
/*Use proc univariate with the normal options to test normality*/
/*Use ods select TestsForNormality to supress printing of everything except the test for normailty*/
/*Use by class statement and then var input variable*/
proc univariate normal;
ods select TestsForNormality;
by name;
var values;
/*Use proc glm to generate appropriate output for homogenity of variances and ANOVA*/
/*Use format:
class name of classification variable
model dependent = class
means class/HOVTEST = bartlett*/
proc glm;
class name;
model values = name;
means name /HOVTEST=bartlett;
/*Add means class/Tukey LSD and clm Tukey LSD CLDIFF to test for significant differences*/
means name /Tukey LSD;
means name / CLM Tukey LSD CLDIFF;
run;
quit;
