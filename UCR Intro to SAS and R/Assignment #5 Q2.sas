options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
ods graphics off;
/*Turns off the extra graphs*/
/* Create titles */
title1 'Statstics 147 Assignment #5';
title2 'Fall 2017';
title3 'Sarah Ruckman';
title4 'Section 002';
title5 'SAS Question 2';
/*Create new dataset with infile statement for question 2*/
data dogdive;
infile "C:\Users\sarah\Downloads\dogdive_f17.dat" firstobs = 3;
/*input the variables Dog which is a character variable, Dive1, and Dive2*/
input Dog$ Dive1 Dive2;
/*Print the results without observation numbers*/
proc print noobs;
/*Use the proc ttest with paired Dive1*Dive2 to test differences of means and use the sides option with L to test less than*/
proc ttest sides=L;
paired Dive1*Dive2;
run;
quit;
