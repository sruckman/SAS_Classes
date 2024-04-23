options ls = 78 nocenter nodate ps = 55;
data rent;
title1 'Statistics 140 Winter 2017';
title2 'Lab #3';
title3 'Sarah Ruckman';
input length @@;
datalines;
5.96 8.84 8.03 7.29 11.48
10.68 9.49 8.51 9.58 8.15
;
proc print noobs;
proc means n mean stddev clm alpha = 0.10;
var length;
proc means n mean stddev clm alpha = 0.05;
var length;
proc means n mean stddev clm alpha = 0.01;
var length;
run;
quit;
