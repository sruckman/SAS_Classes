options ls = 78 ps = 55 nocenter nodate nonumber;
data sasq1;
infile 'C:\Users\Sarah\Downloads\data_lab7_140_w17.dat' firstobs =3 obs=4;
do accidnt = 1 to 2;
if accidnt = 1 then type = 'Fatal/Crit   ';
			   else type = 'No Fatal/Crit';
do auto = 1 to 2;
if auto = 1 then size = 'subcompact';
			else size = 'compact   ';
input wt @@;
output;
end;
end;
data sasq2;
infile 'C:\Users\Sarah\Downloads\data_lab7_140_w17.dat' firstobs = 6 obs =9;
do level = 1 to 4;
     if level = 1 then number = 'None         ';
else if level = 2 then number = 'One          ';
else if level = 3 then number = 'Two          ';
                  else number = 'More than two';
do income = 1 to 4;
	 if income = 1 then amt = '< 15       ';
else if income = 2 then amt = '15-24,999  ';
else if income = 3 then amt = '25-34,999  ';
				   else amt = 'At least 35';
input wt @@;
output;
end;
end;
proc print;
proc freq order = data;
weight wt;
tables number*amt/chisq expected nopercent norow nocol;
run;
quit;
