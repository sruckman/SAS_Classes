options ls = 78 ps = 55 nocenter nodate nonumber;
data wait1;
title1 'Stats 140 Lab #11';
title2 'Sarah Ruckman';
infile 'C:\Users\Sarah\Downloads\WAITING_TIME_140.DAT' firstobs =2;
input time;
proc print;
proc univariate mu0=15;
ods select TestsForLocation;
var time;
run;
quit;
