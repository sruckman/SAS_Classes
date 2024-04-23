options ls = 78 nocenter nodate nonumber ps = 55 formdlim = '#';
ods graphics off;
data fill_amt;
input mu sigma x1 x2;
p1 = cdf('Normal', x1, mu, sigma);
p2 = cdf('Normal', x1, mu, sigma);
p2 = 1 - p1;
p2a = sdf('Normal',x1, mu, sigma);
p3 = cdf('Normal', x2, mu, sigma)- cdf('Normal', x1, mu, sigma);
p96 = quantile('Normal', 0.96, mu, sigma);
datalines;
40 0.5 38.75 41.25
;
proc print noobs;
var p96;
run;
quit;
