options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter justifies the output so it is not centered on the page, and formdlim overrides 
the internal page breaks and replaces themwith the designed symbol */
/* create SAS data set and variable input list*/
data quizzes;
title1 'Stats 140 Lab#1';
title2 'Sarah Ruckman';
title3 'SAS Question 1';
input quiz section1 section2 @@;
overall_average = mean(of section1-section2);
datalines;
1 7.6 6.6 2 6.2 8.2 3 8.0 6.5 4 5.6 4.8
5 9.7 9.0 6 7.6 7.2 7 6.6 5.7
;
proc print;
proc sort;
by overall_average;
proc print noobs;
var overall_average;
run;
quit;

