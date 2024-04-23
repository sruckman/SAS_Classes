options ls=78 nocenter nodate ps=55;
data rent;
title1 'Stats 140 Lab #4';
title2 'Sarah Ruckman';
input length @@;
new_data = length - 9.50;
datalines;
5.96 8.84 8.03 7.29 11.48
10.68 9.49 8.51 9.58 8.15
;
proc means n mean stddev clm alpha = 0.1;
var length;
proc means n mean stddev clm alpha = 0.05;
var length;
proc means n mean stddev clm alpha = 0.01;
var length;
proc means n mean t probt;
var new_data;
proc univariate mu0 = 9.50;
ods select TestsForLocation;
var length;
run;
quit;

