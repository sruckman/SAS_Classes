 options ls =78 ps = 55 nocenter nodate nonumber;
 ods graphics off;
 data candy1;
 input color $ obs1;
 datalines;
brown 8
red 7
yellow 3
blue 5
green 18
orange 13
;
proc print noobs;
var color obs1;
proc freq order = data;
tables color/ chisq testp = (30 20 20 10 10 10);
weight obs1;
run;
quit;
