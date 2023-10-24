/*MLR Assignment 3*/
/*STATS 5207*/

/*Exercise 1 Question 1-5 and 7-8*/
FILENAME prop '/home/u62104146/Sarah/properties.csv';

PROC IMPORT DATAFILE=prop
	DBMS=CSV
	OUT=WORK.prop;
	GETNAMES=YES;
RUN;

DATA fake;
INPUT rental_rate age tax_rate vacancy_rate cost;
DATALINES;
. 5 4.1 0.16 100000
;
RUN;

/*Add to original data set*/
DATA prop2;
SET prop fake;
RUN;

PROC REG DATA=prop2 ;
MODEL rental_rate = age tax_rate vacancy_rate cost/ CLI CLM CLB ALPHA=.01;
RUN;

/*Exercise 1 Question 6*/
PROC REG DATA=prop2 ;
MODEL rental_rate = age tax_rate vacancy_rate cost/ CLI CLM CLB ALPHA=.10;
RUN;

/*Exercise 2 Question 1-3*/
FILENAME sat '/home/u62104146/Sarah/sat.csv';

PROC IMPORT DATAFILE=sat
	DBMS=CSV
	OUT=WORK.sat;
	GETNAMES=YES;
RUN;

PROC REG DATA=sat ;
MODEL total = expend salary ratio / CLI CLM CLB ALPHA=.05;
RUN;

/*Exercise 2 Question 4*/
PROC REG DATA = sat;
MODEL total = expend;
RUN;

PROC REG DATA = sat;
MODEL total = salary;
RUN;

PROC REG DATA = sat;
MODEL total = ratio;
RUN;

/*Exercise 3 Question 1*/
FILENAME goal '/home/u62104146/Sarah/goalies_subset.csv';

PROC IMPORT DATAFILE=goal
	DBMS=CSV
	OUT=WORK.goal;
	GETNAMES=YES;
RUN;

PROC REG DATA = goal;
MODEL W = GA SV; /*Restricted model*/
MODEL W = GA SV SA MIN SO; /*Full model*/
TEST SA=0, MIN=0, SO=0;
RUN;

/*Exercise 3 Question 2*/
PROC REG DATA = goal;
MODEL W = GA SV SA MIN SO; /*Restricted Model*/
MODEL W = GA SV SA MIN SO SV_PCT GAA PIM; /*Full model*/
TEST SV_PCT=0, GAA=0, PIM=0;
RUN;
