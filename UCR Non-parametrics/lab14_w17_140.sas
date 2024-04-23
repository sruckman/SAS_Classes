options ls = 78 ps = 55 nocenter formdlim='#' nodate nonumber;
ods graphics off;
/* Question 1 */
/* Create a temporary SAS data set */
data quest1;
/* Create titles */
   title1 'Statistics 140 LAB #14, Winter 2017';
   title2 'Sarah Ruckman';
   title3 'Question 1';
/* Input variable list */
      input quiz @@;
/* Use the datalines statement to indicate the data is about to follow */
datalines;
9.1  5.0  7.2  7.4  5.5  
8.6  7.0  4.3  4.7  8.0
4.0  8.5  6.4  6.1  5.8
9.5  5.2  6.7  8.3  9.2
9.7  9.8  8.4  8.9  9.3
;
/* Print the data as a a check */
proc print;
proc univariate;
ods select GoodnessOfFit;
var quiz;
histogram/normal(mu=7 sigma=1.5);
run;
/* QUESTION 2 */
/* Create a temporary SAS data set */
data quest2;
/* Modify title3 */
    title3 'Question 2';
/* Input variable list */
     input  time @@;
/* Use the datalines statement to indicate the data is about to follow */
datalines;
3.6 6.2 12.7 14.2 38 3.8 10.8  6.1
10.1 22.1 4.2 4.6 1.4 3.3 8.2
;
proc print;
proc univariate;
ods select GoodnessOfFit;
var time;
histogram/exponential(sigma=10);
run;
/* Question 3 */

data quest3;
    input gift $ 1 - 10 obs1;
	title3 'Question 3';
	datalines;
Sweatshirt 280
Coffee_mug 180
Earrings  40
; 

/* Print the data as a check */
proc print;
proc freq order = data;
tables gift /chisq testp = (50 40 10);
weight obs1;
run;
quit;
