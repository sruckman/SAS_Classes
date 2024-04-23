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
/* Create temporary data set called dog1 using infile statement */
data dog1;
infile "E:\dog1a_judge_f17.dat" firstobs = 3;
/* Input variables Dog (character = $), J1, and J2*/
input Dog$ J1 J2;
/* Print the data as a check without obeservation numbers*/
proc print noobs;
run;
quit;
