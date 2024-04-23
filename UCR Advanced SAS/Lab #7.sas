options ls=78 ps=55 mprint mtrace nodate nonumber mlogic nocenter formdlim ='#';
/*
*****************************************************************
*****************************************************************
** Macro namelst macro designed to generate a list of **
** sequential data file names where the **
** name and the number of files are **
** specified by the user **
** Variable specification: **
** name name of the sequential data files to be **
** generated in the list **
** number number of data files names to be generated in **
** the list **
*****************************************************************
*****************************************************************
*/
%macro namelst(name,number);
%do n = 1 %to &number;
&name&n
%end;
%mend namelst;
%macro semhead(semnum,name1);
	title1 "Transcript for &name1, Semester &semnum";
	title2 "Wishful University";
	title3 "Anywhere, Any State";
%mend semhead;
%macro gradcode;
	if grade = "A" then pts = 4;
else if grade = "B" then pts = 3;
else if grade = "C" then pts = 2;
else if grade = "D" then pts = 1;
else pts = 0;
%mend gradcode;
%macro gpa1(whdata,i,sum1,sum2,gpa,out1);
proc means data = &whdata&i noprint;
var units;
output out= a&i sum = &sum1;
run;
proc means data = &whdata&i noprint;
var tpts;
output out= b&i sum = &sum2;
run;
data &out1&i;
merge a&i b&i;
semster = &i;
&gpa = &sum2/&sum1;
proc print noobs;
var semster &sum1 &sum2 &gpa;
run;
%mend gpa1;
%macro indata1(olddata, newdata, semnum, number, name1);
%do i=1 %to &number;
data &semnum&i;
%semhead(&i,&name1);
infile "C:\Users\sarah\Downloads\SEM&i..DAT" firstobs=4;
input dept $ 1-4 crsnm crsdesc $ 16-40 units grade $;
	%gradcode;
	tpts=units*pts;
	title4 "Individual Semester Information";
proc print noobs;
	var dept crsnm crsdesc units grade tpts;
data &newdata&i;
set %namelst(&semnum,&i);
%gpa1(&semnum,&i,sumsem_1,sumsem_2,sem_gpa,sd);
%* Generate cumulative gpa information;
%* Recall: sumcum_1 = sum of course points;
%* sumcum_2 = sum of units;
%* cumm_gpa = sumsem_1/sumsem_2;
%* = overall gpa;
title4 "Cumulative Information";
%gpa1(&newdata,&i,sumcum_1,sumcum_2,cum_gpa,cd);
%end;
%mend indata1;
%indata1(restr,cumul,semstr,6,Sarah Ruckman);
run;
quit;
