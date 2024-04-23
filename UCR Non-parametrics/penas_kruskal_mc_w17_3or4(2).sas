options ls=78 nocenter ps=55 formdlim='*' mtrace mlogic mprint;
ods graphics off;
/* 
************************************************** 
Kruskal-Wallis Tests with Multiple Comparisons
Dr Linda M. Penas 
Original: Summer 2010
Revised: Winter 2017

This program is designed to perform the calculations for the Kruskal-Wallis
Test, a nonparametric test that is the counterpart of the 1-Way Classification
Design in Analysis of Variance. The program also performs multiple
comparisons, an option not available in the usual SAS routine.

Macros Employed:
     namelst         macro designed to generate a list of names
     whichranks    macro designed to calculate the number of observations in each sample,
                         the sum of the ranks and the sum of the squared ranks for a sample 
     compare1     macro designed to calculate  the least significant difference(s) and the absolute 
                         value of the difference of the average ranks for each pair of populations and
                         determine whether the difference is significant
     indata            macro designed to read in data file and complete calculations by calling 
                         appropriate macros and procedures

Variables: The variables are defined with each macro.
************************************************** 
*/


/*
**********************************************
macro namelst  

USAGE:  generate a list of names

Parameters/Variables Used:
       number   number of columns (populations/samples) in the data file
       names    base name for each column
       i        number to append to the end of each base name
**********************************************
*/

%macro namelst(number,names);
       %do i = 1 %to &number;
	            &names&i
		%end;
%mend namelst;

/* 
*************************************************************
  macro whichranks
  USAGE: macro designed to calculate the number of observations in each sample,
      the sum of the ranks and the sum of the squared ranks for a sample
    Variables designations:
          j             sample number
      which         name associated with the sample
      rankname   variable name assigned to the ranks
*************************************************************
*/
 %macro whichranks(j,which,rankname);
 %* Create new temporary data set for each sampel;
   data rank1_&which;
%*Open SAS data set where the ranks are located;
          set all_rankings;
%* Restrict data;
          if name="&which  ";
%* Print the data;
   proc print;
   %* Use proc means to generate the number of observations in the sample and
   the sum of the ranks and the ranks squared and output to a temporary  SAS dataset
   Variable designation:
         n       number of observations
       sum     sum 
       uss       sum of squares
   Use output statement to output the information to a temporary SAS dataset with the
   appropriate value of j to the SAS dataset and the calculated values.;
   proc means n  sum uss noprint;
       var &rankname;
	   output  out=out&j  sum = sum&j uss=ssq&j n = n&j;
%* Calculate average of the sum of the ranks squared = R_i^2/n_i;
data ave_ranks2&j;
%* Use set command to bring in information from proc means procedure;
      set out&j;
	  ave_rnk_sq&j = (sum&j)**2/n&j;
	  proc print noobs;
%* Close the macro;
%mend whichranks;


/*
*********************************************************************
macro compare1
USAGE: generate the least significant difference(s) and the absolute value of the difference
of the average ranks; If absolute value of the difference
of the average ranks > least significant difference, conclude a significant difference between
the 2 compared populations
Variable designation:
     which1    first population to compare
     which2    second population to compare
   least_diff_XY    least significant difference for comparing population X and population Y
  abs_diff_XY       absolute value of the difference in the average ranks between population
                           X and population Y
   answer_XY       conclusion 
***********************************************************************
*/

%macro compare1(which1,which2,k);
%* Create temporary SAS dataset;
 data data&which1&which2;
 %* Bring in data;
       set all;
%* Calculate LSD and abs value of the diufference in the average ranks;
       least_diff_&which1&which2 = t_value*sqrt(s2)*sqrt((N - 1 - test_stat)/(N - &k))*sqrt(1/n&which1 + 1/n&which2);
       abs_diff_&which1&which2 = abs(sum&which1/n&which1 - sum&which2/n&which2);
%* Use if-then-else structure to draw conclusion;
  if abs_diff_&which1&which2 > least_diff_&which1&which2 then 
      answer_&which1&which2 = "Can conclude a sig diff between  &which1, &which2";
else  answer_&which1&which2 = "Can't conclude a sig diff between &which1,&which2" ; 
%* print the output;
proc print noobs;
    var  least_diff_&which1&which2  abs_diff_&which1&which2   answer_&which1&which2;
	%* Close the macro;
%mend compare1;


/* 
************************************************************************
macro indata
USAGE: read in data file and complete calculations
Variable designation:
     datfile     name of data file including path/location for the data file
     firstline   line in the data file where the data actually begins (line where 
                   SAS should start reading data)
       stopi      number of rows in data file
       stopj      number of columns in data file
   varname1   name of response variable
   rankname   name being assigned to the ranks of the response variable
  name1, name2, name3   names of the samples/populations
*************************************************************************
*/
%macro indata(datfile,firstline,stopi,stopj,varname1,rankname,name1,name2,name3,name4); 
%*Create temporary SAS dataset;
data ranking1;
%* Use infile statement to open data file;
%* CHANGE INFILE STMT;
%*         infile 'a:dogsledding.dat';
     infile "&datfile" firstobs = &firstline;
%* Do loop for the rows of data;
     do  rows = 1 to &stopi;
%* do loop for the columns of data;
       do j = 1 to &stopj;
%* Use if-then-else structure to name the samples/populations;
 %if &stopj = 3 %then %do;
%* THIS WILL HAVE TO BE CHANGED FOR MORE THAN 3 POPULATIONS;
              if j = 1 then name = "&name1  ";
         else if j = 2 then name = "&name2  ";
        else                name = "&name3  ";
		%end;
 %else %do;
             if j = 1 then name = "&name1  ";
        else if j = 2 then name = "&name2  ";
        else if j = 3 then name = "&name3  ";
        else               name = "&name4  ";  
 %end;	
%* Input and output the data;	          
	                input &varname1 @@;
		            output;
%* Close the do loops;
	       end;
end;
%* Print the data as a check;
proc print;
%* Sort the data;
proc sort;
     by &varname1;
%* Use proc rank to generate the ranks of the response variable;
proc rank;
	var &varname1;
	ranks &rankname;
%* Print as a check;	
	proc print;
%*	   var name sales sales_rank;
%* Use proc sort to sort according the sample/population and output tohe information
to an output file named sorted1;
	proc sort out=sorted1;
	     by name;
		 proc print;
%* Create new temporary  SAS dataset to complete calculations;
 data all_rankings;
 %* Bring in sorted dat using the set command;
    set sorted1;
	%* Create a new variable = squares of the ranks;
 ranks_sq = &rankname**2;
%* Print as a check;
proc print;
%* Use proc npar1way with wilcoxon option to generate Kruskal-Wallis test
         class     classification variable name
         var       response variable;
proc npar1way wilcoxon;
       class name;
	   var &varname1;

%* Use proc means to generate the sum of the squares of the ranks;
%* Output the information to a temporary SAS dataset;
	 proc means  sum noprint;
	      var ranks_sq;
		  output out=sdata2 sum=sum_sq_rnks2;
%* Invoke macro whichranks to generate information for each sample/population;	
data whichrank;

%do r = 1 %to &stopj;
 %whichranks(&r,&name&r,&rankname); 
run;
%end;
%* Create new temporary SAS dataset to calculate 
      N          total number of observations
    t_value    critical t-value from the t-distribution
       s2        sample variance associated with ranks
test_stat      Kruskal-Wallis test statistic;
data all; 
%*k = 3;

%* Merge temporary SAS datasets that contain various sums;
   merge %namelst(&stopj,ave_ranks2)  sdata2; 
   N = sum(of n1-n&stopj);
   
%*   k = 3;
%* use tinv function to generate the appropriate critical value of t(area to the left,N-k)
     area to the left = 1 - alpha/2;
   t_value = tinv(0.975,N-&stopj);
%* Calculate s2;
   s2 = (1/(N-1))*(sum_sq_rnks2 - N*(N+1)**2/4);
%* Calculate test statistic value;
sum_ave_ranks_squared = sum(of ave_rnk_sq1 - ave_rnk_sq&stopj);
test_stat = (1/s2)*(sum_ave_ranks_squared - N*(N+1)**2/4);
%* Calculate p-value based on Chi-Squared Distribution;
  p_value = 1 - probchi(test_stat,&stopj-1);
%* Print as a check;
 proc print noobs;
 %* Invoke macro compare1 to make comparisons between every pair of samples/populations; 

%do m = 1 %to &stopj - 1;
     %do n = &m + 1 %to &stopj;
             %compare1(&m,&n,&stopj);
     %end;
%end:

%* Close the macro;

 %mend indata;

 /* Invoke the indata macro
  % indata(datfile,firstline,stopi,stopj,varname1,rankname,name1,name2,name3); 
 where datfile   name, incduing path, of the data file
     firstline   line number to start rewading the data. represents the value of firstobs
       stopi     number of rows of data
       stopj     number of columns of data
     varname1    name of response variable
     rankname    name of response variable ranks
       name1     name of column 1
       name2     name of column 2
       name3     name of column 3
       name4     name of column 4
 */ 
 /* For 3 columns of data, leave name4 blank. Be sure to change the data file, path, and parameter values  */

 %indata(C:\Users\Sarah\Downloads\recipe4_w17.dat,2,10,4,weight,weight_rank,Recipe1,Recipe2,Recipe3,Recipe4); 

/* For 4 columns of data. Be sure to change the data file, path and parameter values. */

/* %indata(c:\linda\winter2017\w17140\datafiles\recipe4_w17.dat,2,10,4,weight,weight_rank,Recipe1,Recipe2,Recipe3,Recipe4); */

run;
quit;


