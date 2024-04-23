options ls =78 ps=55 nodate nocenter;
ods graphics off;
proc import out=work.circuit1_w18
datafile="C:\Users\sarah\Downloads\circuits_w18.xls"
DBMS=xls replace;
sheet ='circuit';
getnames=YES;
proc print noobs;
data defect;
set circuit1_w18;
proc freq;
tables defectives/ nopercent nocum;
proc means mean;
var defectives;
proc gchart;
title1 'A Proc gChart Example';
title2 rotate =75 f=swissb 'Sarah Ruckman';
title3 rotate = 10 h=6 c=blue f =swissb 'Stats 157';
footnote1 rotate=25 h=3 c=green f=swiss 'Jan. 16, 2018';
footnote2 rotate=-25 h=2 c=purple f=swiss 'Proc Import Practice';
var3d defectives /caxis = orange cfr=verylightpurplishblue
coutline=verydarkblue shape=hexagon ctext=red;
pattern color=pink; 
run;
quit;
