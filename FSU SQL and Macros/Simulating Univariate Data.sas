/*Simulating Univariate Samples*/

/*Question 1a*/
%let seed = 54321;
%let numobs = 1000;
data geo;
call streaminit(&seed);
	do p=0.2 to 0.6 by 0.2;
		do i=1 to &numobs;
		x=rand("geometric", p);
		output;
		end;
	end;
run;

/*Question 1b*/
proc sql;
	create table geomnum as
	select p, x, count(*) as freq
	from geo
	group by p, x;
quit;

/*Question 1c*/
proc sgplot	data = geomnum;
	series x=x y=freq / group = p;
run;

/*Question 2a*/
%let a = -2;
%let b = 2;
%let obs = 1000;
data uni;
	call streaminit(&seed);
	do i=1 to &obs;
	x=rand("uniform", &a,&b);
	output;
	end;
run;

/*Question 2b*/
proc means data=uni n mean min max;
var x;
run;

/*Question 2c*/
%macro unif_a_b(varnm=x,a=0,b=1,seed=54321,obs=100,outdata=unif_a_b);
	data &outdata;
		call streaminit(&seed);
		do i=1 to &obs;
		x=rand("uniform", &a,&b);
		output;
		end;
	run;
%mend unif_a_b;

/*Question 2d*/
%unif_a_b(a=-1, b=3, obs=1000, outdata = tmp);

/*Question 2e*/
proc means data=tmp n mean min max;
var x;
run;

/*Question 3a*/
%let obs=10000;
%let seed=54321;
proc iml;
  x=j(&obs,1,.);
  call randseed(&seed);
  call randgen(x,"negbinomial",.3,3);
  create negbin var {x};
  append from x;
   close negbin;
quit;

/*Question 3b*/
proc sql;
	create table counts as
	select x, count(*) as freq
	from negbin
	group by x;
quit;

/*Question 3c*/
proc sgplot	data = counts;
	series x=x y=freq;
run;