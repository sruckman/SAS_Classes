options ls = 78 nocenter ps = 55 nonumber nodate formdlim ='*';
data age_level;
infile 'C:\Users\sarah\Downloads\agesf17.dat' firstobs = 2;
title1 'Stats 147 Lab #2';
title2 'Sarah Ruckman';
title3 'Section 2';
input Father Mother;
proc contents;
proc print;
proc gchart;
hbar3d Mother / midpoints = 15 to 35 by 5
				caxis = orange
				cfr=verylightpurplishblue
				coutline = verydarkblue
				shape = hexagon
				ctext = red;
proc gchart;
	vbar3d Mother / midpoints = 15 to 35 by 5
					caxis = green
					coutline = verydarkblue
					shape = prism
					ctext = green;
pattern color = purple;
symbol value = +
	height =3 
	cv = blue;
proc gplot;
plot Father*Mother / 
	caxis = darkgreen
	ctext = darkred;
proc univariate;
	var Father;
run;
quit;
