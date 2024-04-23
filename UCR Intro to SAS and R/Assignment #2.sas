options ls = 70 ps = 55 nocenter formdlim = '*';
/* ls = linesize, ps = pagesize, nocenter = justifies output, formdlim = overrides the internal page breaks
and replaces them with the designated symbol */
/* Set up some options for gchart and gplot */
goptions reset=global gunit=pct border cback =white ctext=black colors=(blue green red) ftext=swissb ftitle=swissb htitle=5 htext=2.75 hpos = 10;
/* Create titles */
title1 'Statstics 147 Assignment #2';
title2 'Section 002';
title3 'Fall 2017';
title4 'Sarah Ruckman';
title5 'SAS Question 1 Part iii';
/* Read file */
/* Create temporary data set called dfsales */
data dfsales;
infile "C:\Users\sarah\Downloads\DOGFOOD_SALES_F17A.DAT" firstobs = 2 ;
input Variety $ Sales;
/* Print the data as a check */
proc print;
/* Create 3D vbar chart using proc gchart statement, include coloration: background frame = verylightgrayishblue, 
	outline = verydarkblue, hexagon shape of bars, text within = verydarkgreen, 
	bar colors = lightblue, pink, yellow, and lightgreen */
proc gchart;
vbar3d Variety / sumvar = Sales
				outside = sum
				subgroup = Variety
				cframe = verylightgrayishblue
				coutline = verydarkblue
				shape = hexagon
				ctext = verydarkgreen;
				pattern1 color = lightblue;
				pattern2 color = pink;
				pattern3 color = yellow;
				pattern4 color = lightgreen;
/* Use proc means statement to specify which statsitics to display */
proc means mean median stddev;
	by Variety;
run;
quit;
