options ls =78 ps =55 nocenter formdlim='*';
data corr1;
infile 'C:\Users\Sarah\Downloads\CORR_LAB12_W17.dat' firstobs = 2;
input systolic diastolic;
proc print;
proc corr nosimple spearman kendall;
var systolic diastolic;
run;
quit;

