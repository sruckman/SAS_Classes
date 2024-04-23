options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #3';
title2 'Section 002';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'SAS Question 3';
/*Create temporary data set called loops*/
data loops;
/*Set up loop for n = 1,3,5 and m=2 to 8 in increments of 3 */
do n = 1 to 5 by 2;
do m = 2 to 8 by 3;
/*Calculate y*/
y = 3*n**2 + sqrt(4.5*m**(-0.5*n));
/*Output the information*/
output;
/*end the loops*/
end;
end;
/*Print the results*/
proc print noobs;
run;
quit;
