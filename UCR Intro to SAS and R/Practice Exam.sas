options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/*Set up some options for gchart*/
goptions reset=global colors=(red,blue,green,yellow,pink,purple);
/* Create titles */
title1 'Statstics 147 Exam 1 Practice, Part 2:SAS';
title2 'Fall 2017';
title3 'Sarah Ruckman';
title4 'Question 1';
/*Create temporary data set*/
data quest2;
input x @@;
y = 2*x**3 +4;
datalines;
11 12 13 14 15 16 20
;
proc print;
title4 'Question 2';
/*Do Loops*/
/*Make loops for m and n*/
do m 1 to 2;
do n 1 to 3;
y = sqrt(m**2 + n**2);
/*Output the data*/
output;
/*Close the loops*/
end;
end;
proc print;
/*Revise title 4*/
title4 'Question 3';
/*Create temporary dataset*/
data quest;
input x y;
datalines;
1 1
3 8
5 24
7 40
9 80
11 20
13 150
;
/*Print as check*/
proc print;
/*Create plot using symbol option to change symbol, value=dot,height=2*/
symbol1 color=black
value=dot
height=2;
proc gplot;
plot y*x;
data quest2;
infile "C:\Users\sarah\Downloads\hallmk17.dat" firstobs=2;
input amount @@;
title4 'Question 4';
proc print;
proc means mean median stddev var min max;
var amount;
proc gchart;
vbar3d amount / midpoints = 20 to 36 by 4
caxis = orange
cfr=verylightpurplishblue
coutline=verydarkblue
shape=hexagon
ctext=red;
pattern color=pink;
proc gchart;
vbar3d amount / midpoints = 20 to 36 by 1
caxis = orange
cfr=verylightpurplishblue
coutline=verydarkblue
shape=hexagon
ctext=red;
pattern color=pink;
data quest5;
title4 'Question 5';
infile "C:\Users\sarah\Downloads\aussie17.dat" firstobs=2;
do rows 2 to 11;
do dog 1 to 2;
if dog = 1 then breed = 'Cattle Dog';
else            breed = 'Shephard  ';
input weight @@;
output;
end;
end;
proc print noobs;
proc sort;
by breed;
proc means mean var;
 by breed;
 var weight;
 data quest6;
 title4 'Question 6';
 input n p;
 p1 = pdf('binomial', 4, 0.15,20);
 p2=cdf('Binomial',5,0.15,20)-cdf('Binomial',1,0.15,20);
 p3=1-cdf('Binomial',4,0.15,20);
p3a =sdf('binomial',4,0.15,20);
mean_binomial=n*p;
datalines;
20 0.15
;
proc print;
data quest7;
title4 'Question 7';
input mu sigma;
p1=cdf('Normal',43,mu,sigma);
p2=1-p1;
p3 = cdf('Normal',47,mu,sigma)-cdf('Normal',42,mu,sigma);
x3 = quantile('normal',0.975,mu,sigma);
datalines;
45 5 
;
proc print noobs;
run;
quit; 
