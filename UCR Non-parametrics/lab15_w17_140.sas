options ls = 78 ps = 55 nocenter formdlim='#' nodate nonumber;
ods graphics off;
/* Question 1 */
/* Create a temporary SAS data set */
data quest1;
/* Create titles */
   title1 'Statistics 140 LAB #15, Winter 2017';
   title2 'Sarah Ruckman';
   title3 'Question 1';
/* Use an infile statement to open the data file. Be sure to change the path! */
   infile 'C:\Users\Sarah\Downloads\homes1.dat' firstobs = 2;
/* Use nested do loops to read in the data 
   do loop for rows first then do loop for columns */
 do rows = 1 to 10;
     do cols = 1 to 2;
	 /* us if-then-esle strictur to name the columsn */
	          if cols = 1 then name = 'Program A';
		  else                 name = 'Program B';
		  /* inout and output the data */
		     input savings @@;
			 output;
	/* CLose the do loops */
	end;
end;
/* Print the data as a check */
proc print;
proc npar1way edf;
class name;
var savings;
exact ks;
run;
quit;
