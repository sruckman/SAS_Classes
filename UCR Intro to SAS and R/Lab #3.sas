options ls = 78 nocenter nodate ps= 55;
/* Create temporary SAS dataset called norm1*/
data norm1;
/*Create titles*/
title1 'Stats 147 Fall 2017';
title2 'Lab 3';
title3 'Sarah Ruckman';
title4 'Question 1';
title5 'Part 1';
/*X Normal with mu and sigma Use an input statement to read in the value of mu, sigma, x1, and x2*/
input mu sigma x1 x2;
/*P(x1 <= X <= x2) = P(X <= x2) - P(X < x1)*/
/*Use cdf function and format: cdf('normal', x,mu,sigma)*/
p1 = cdf('Normal', x2, mu, sigma) - cdf('Normal', x1, mu, sigma);
datalines;
60 6 48 62
;
/*Print the results*/
proc print noobs;
data part_ii;
/*Revise title5*/
title5 'Part ii';
/*Input variable list*/
input mu sigma x3;
/*Use sdf function format: sdf('normal', x,mu,sigma)*/
p2 = sdf('Normal', x3, mu, sigma);
datalines;
60 6 63
;
/*Print the results*/
proc print noobs;
var mu sigma x3 p2;
data part_iii;
/*Revise title 5*/
title5 'Part iii';
/*Input mu sigma and prob*/
input mu sigma prob1;
/*Find X such that P(X <=x) = prob1 and X is normal*/
/*Use quantile function format: quantile('normal',percentile,mu,sigma)*/
x4 = quantile('Normal', prob1, mu, sigma);
datalines;
60 6 0.96
;
/*Print the results*/
proc print noobs;
data binom1;
/*Revise title4 and title5*/
title4 'Question 2';
title5 ' ';
/*Input the values of p n x1 x2 x3 x4 x5 and x6*/
input p n x1 x2 x3 x4 x5 x6;
/*Note x1=9 x2=11 x3=10 x4=8 x5=12 x6=7*/
/*Let 
Part i = p1= P(X=9)=pdf('Binom',x1,p,n)
Partii = p2 = P(X<=11)=cdf('Binom',x2,p,n)
Part iii = p3 = P(X>10)= 1-P(X<=10)=1-cdf('Binom',x4,p,n)
Partiv=p4=P(X>=10)=1-P(X<9)=1-P(X<=8)=1-cdf('binom',x4,p,n)
Partv=p5=P(8<=X<=12)=P(X<=12)-P(X<=7)=cdf('Binom',x5,p,n)-cdf('Binom',x6,p,n)*/
/*Create variables*/
/*Using pdf cdf sdf format:
P(X=x)=pdf('Binom',x,p,n)
P(X<=x)=cdf('Binom',x,p,n)
P(X>x)=sdf('Binom',x,p,n)*/
p1 = pdf('Binom',x1,p,n);
p2 = cdf('Binom',x2, p, n);
p3 = 1-cdf('Binom', x3,p,n);
p3a = sdf('Binom', x3,p,n);
p4 = 1-cdf('Binom',x4,p,n);
p5 = cdf('Binom',x5,p,n) - cdf('Binom',x6,p,n);
datalines;
0.45 20 9 11 10 8 12 7
;
proc print noobs;
var n p p1 p2 p3 p3a p4 p5;
run;
quit;
