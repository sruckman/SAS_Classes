/*Create SAS data set called age_level by opening file using an infile statement*/
data age_level;
infile 'C:\Users\Sarah\Downloads\agesw17.dat' firstobs = 2;
title3 'SAS Question 2';
input Father Mother;
pro contents;
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
cfr=verylightpurple
coutline = verydarkblue
shape = prism
ctext = green;
pattern color = purple;
symbol1 value =+
height =3 
cv=blue;
proc gplot;
plot Father*Mother/
caxis = darkgreen
ctext = darkred;
proc univariate;
var Father;
run;
quit;
