options ls = 78 nocenter ps = 55 nodate;
goptions reset = global colors =(red,blue,gree,yellow,pink,purple,brown);
ods graphics off;
/*Set up temporary SAS Data Set */
data tryloop1;
title1 'Stats 147 SAS Practice 4';
title2 'My First Do Loop';
title3 'Sarah Ruckman';
/* Set up loop format: do start to stop by increment*/
do x = 1 to 9 by 2;
/*Calculate y exp function rasies e to the indicated power*/
y = 0.5*x*exp(0.5*x);
/*Output the information each time through the loop*/
output;
/*Cloes the loop*/
end;
/*Print the results*/
proc print noobs;
/*Note: interpol = join will connect the plot points*/
symbol1 color=blue interpol=join
	value=trianglefilled height=2.5;
/*Use the axis command to define the look of the axes
	value = (f=font to use h = height of the font)
	label = (h = height of the axis label f = font of the label)
	vaxis = vertical axis haxis = horizontal axis*/
	axis1 value= (f=swissb h=1.5) label =(h=1.5 f = swissb);
	axis2 value = (f=swissb h=1.5) label =(h=1.75 f = swissb);
	proc gplot;
	plot y*x /ctext = darkred vaxis = axis2 haxis = axis1;
	title4 c = blue f = swissb 'My First Do Loop Plot';
/*Set up temporary SAS dataset*/
data tryloop2;
/*Revise title 4*/
title4 'SAS Question 2';
/*Set up the do loops format do start to stop by increment*/
/*Do loop for x*/
do x = 1 to 9 by 4;
/*Do loop for y*/
do y = 1 to 5 by 2;
/*Calculate t*/
t = y*sqrt(5*x);
/*Output the information*/
output;
/*Close the loops*/
end;
end;
/*Print the reseults*/
proc print noobs;
run;
quit;
