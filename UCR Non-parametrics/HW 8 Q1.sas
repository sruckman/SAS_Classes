options ls = 78 ps = 55 formdlim = '#' nocenter nodate;
ods graphics off;
data q1;
input users $ observed1 prop1;
n = 500;
expected1 = n*prop1;
chisq1 = (observed1 - expected1)**2/expected1;
datalines;
a 245 0.49
b 200 0.39
c 45 0.08
d 10 0.04
;
proc print noobs;
proc means sum noprint;
var chisq1;
output out = a1 sum = chisq_sum;
proc print noobs;
data pvalue1;
set a1;
pvalue = 1 - probchi(chisq_sum,3);
proc print noobs;
run;
quit;
