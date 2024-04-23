options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Create titles */
title1 'Statstics 147 Assignment #3';
title2 'Section 002';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'SAS Question 2';
/* Create temporary data set called candy */
data candy;
/* input variables mu=52 sigma=3.6 x1=50 x2=51 x3=55.5 x4=47.5 */
input mu sigma x1 x2 x3 x4;
/* use cdf function to find prob that is less than 50*/
p1 = cdf('Norm', x1,mu,sigma);
/* use sdf to determine more than 51*/
p2 = sdf('Norm',x2,mu,sigma); 
/* Use cdf to find between 55.5 and 47.5 */
p3 = cdf('Norm',x3,mu,sigma) - cdf('Norm',x4,mu,sigma);
/* Use 1-p3 to determine out of control prob*/
p4 = 1-p3;
/* Use quantile function to find 98 percentile */
q98 = quantile('Norm', 0.98,mu,sigma);
/*Put in datalines*/
datalines;
52 3.6 50 51 55.5 47.5
;
/*Print the data and show only variables mu, sigma, p1, p2, p3, p4, and q98*/
proc print noobs;
var mu sigma p1 p2 p3 p4 q98;
run;
quit;
