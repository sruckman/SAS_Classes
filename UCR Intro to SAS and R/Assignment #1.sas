options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #1';
title2 'Section 002';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'SAS Question 1 Part ii';
/* Read file */
/* Create temporary data set called wheat */
data wheat;
infile 'C:\Users\sarah\Downloads\wheat2.dat' firstobs = 2;
input HardRed SoftRed;
/* Print the data as a check */
proc print;
/* Sort by the variable HardRed */
proc sort;
by HardRed;
/* Print the data*/
proc print;
run;
quit;
