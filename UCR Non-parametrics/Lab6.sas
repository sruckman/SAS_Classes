data mcnemar2;
title1 'Statistics 140 Ex 5.27';
title2 'School Referendum';
do before = 1 to 2;
if before = 1 then align1 = 'Support';
else               align1 = 'Oppose ';
do after = 1 to 2;
if after = 1 then align2 = 'Support';
else              align2 = 'Oppose ';
input wt @@;
output;
end;
end;
datalines;
35 12
15 38
;
proc print;
proc freq order = data;
ods select McNemarsTest;
weight wt;
tables align1*align2 / agree;
proc freq order = data;
weight wt;
exact mcnem;
tables align1*align2;
run;
quit;

