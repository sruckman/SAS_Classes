options nocenter nodate nonumber ps =55 ls=78;
proc import out = work.qual_w18
datafile = "C:\Users\sarah\Downloads\quality1_w18.xls"
dbms = xls replace;
sheet = 'defectives';
getnames = YES;
data defect;
set qual_w18;
proc print noobs;
proc freq;
tables defectives1/ nopercent nocum;
proc means mean sum stddev;
var defectives1;
proc gchart;
title1 'A proc gchart example';
title2 rotate=75 f=swissb 'Sarah Ruckman';
title3 rotate =10 h=6 c=green f=swissb 'Stats 157';
footnote1 rotate=-25 h=3 c=blue f=swiss 'Lab #2';
footnote2 rotate=25 h=2 c=purple f=swiss 'proc import practice';
var3d defectives1 /caxis = orange cfr=verylightpurplishblue 
coutline = verydarkblue shape=prism ctext=red;
pattern color=pink;
run;
quit;
