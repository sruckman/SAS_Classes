options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #3';
title2 'Section 002';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'SAS Question 1';
/* Create temporary data set called students and input n=26, p=0.30, x1=10, x2=8, x3=13 */
data students;
input n p x1 x2 x3;
/*use pdf to determine exactly 10 students*/
p1 = pdf('Binom', x1,p,n); 
/* use cdf to determine no more than 10 students */
p2 = cdf('Binom', x1,p,n);
/*use cdf of 13 - cdf of 8 to find value between */
p3 = cdf('Binom', x3,p,n)-cdf('Binom',x2,p,n);
/* use formula mean = n*p to determine average */
mean1 = n*p;
datalines;
26 0.30 10 8 13
;
/* Print the data only showing variables n p p1 p2 p3 and mean1 */
proc print noobs;
var n p p1 p2 p3 mean1;
run;
quit;
