options ls = 78 nocenter nodate nonumber ps = 55;
ods graphics off;
data lab4f17;
infile 'C:\Users\sarah\Downloads\PLANTF17.DAT' firstobs = 2;
do row = 1 to 10;
do plant = 1 to 4;
if      plant = 1 then name = 'Plant A';
else if plant = 2 then name = 'Plant B';
else if plant = 3 then name = 'Plant C';
else                   name = 'Plant D';
input dischrg @@;
output;
end;
end;
proc print noobs;
proc sort;
by plant;
proc means n mean var;
by plant;
var dischrg;
data onlyB;
set lab4f17;
if plant = 2;
new_data = dischrg - 1.75;
proc means n mean t probt;
var new_data;
proc univariate mu0 =1.75;
ods select TestsForLocation;
var dischrg;
proc means n mean stddev clm alpha =0.01;
var dischrg;
proc print noobs;
proc means n mean stddev;
var dischrg;
data BothAB;
set lab4f17;
if plant = 1 or plant =2;
proc print;
proc means n mean stddev;
by plant;
var dischrg;
data looptry;
do x = 1 to 2;
do t = 3 to 9 by 3;
y = 2*x**2*(t**(1.0/3.0));
output;
end;
end;
proc print noobs;
var x t y;
run;
quit;
