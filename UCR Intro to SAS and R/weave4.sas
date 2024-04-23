options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Exam 1: Part 1 SAS';
title2 'Version YYY';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'Question XXX';
/* Read file */
/* Create temporary data set called weave4 using do loops */
data weave4;
infile "E:\ext_weave4_f17.dat" firstobs = 3;
/*Create do loops for rows and columns to read in data, rows = 3 to 11 and columns(weaves) 1 to 3*/
do row = 3 to 12;
do weave = 1 to 3;
/*Create if then else statements to label the columns and end with a else statment*/
if      weave = 1 then name = 'AS';
else if weave = 2 then name = 'BC';
else                   name = 'SS';
/*input the values and add @@ to denote that the values are on the same line*/
input values @@;
/* Use output to output the results*/
output;
/*Close both loops*/
end;
end;
/* Sort the data by weave(columns) using proc sort and a by statement*/ 
proc sort;
by weave;
/*Print the results without observations*/
proc print noobs;
run;
quit;
