options ls= 78 ps= 55 nocenter nodate;
ods graphics off;
data rope;
input brand strength @@;
datalines;
1 89.8 1 90.2 1 98.1 1 91.2 1 88.9 1 90.3 1 99.2 1 94 1 88.7
2 87.3 2 76 2 66.7 2 77.3 2 86.4 2 86.4 2 93.1 2 89.2 2 90.1
;
proc sort;
by brand strength;
proc print;
proc npar1way edf;
class brand;
var strength;
exact ks;
run;
quit;
