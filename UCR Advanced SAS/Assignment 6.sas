/*Set up format for the output*/
options ls = 78 ps = 55 nodate nonumber nocenter mtrace mlogic mprint;
ods graphics off;
/*
*******************************************************************
Macro namelst macro designed to generate a list of sequential data
	file names where the name and the number of the files are
	specified by the user
Variable specification:
name name of the sequential data files to be generated in the list
number number of the data files names to be generated in the list
*******************************************************************
*/
%macro namelst(name,number);
%do n = 1 %to &number;
	&name&n
%end;
%mend namelst;
/*
*******************************************************************
macro heading1 macro to generate titles
Parameters
what parameter to identify what object
number1 number of the object
quarter1 quarter and year
filenum which data file (1 or 2)
*******************************************************************
*/
%macro heading1(what,number1,quarter1,filenum);
	title1 "Statistics 157 &quarter1";
	title2 "&what &number1";
	title3 "Sarah Ruckman";
	title4 "Macro Veterinarians, Inc.";
	title5 "Ura Vet, DVM";
	title6 "Veterinarian File &filenum";
%*Close the macro;
%mend heading1;
/********************************************************************
Macro sizing to classify each dog according to size
Variable specifications:
size name of size variable
********************************************************************/
%macro sizing;
%* Use if then else structure to classify size;
	 if Weight <= 10      then size = 'Toy Canine   ';
else if 10 < Weight <= 25 then size = 'Small Canine ';
else if 25 < Weight <= 50 then size = 'Medium Canine';
else if 50 < Weight <= 90 then size = 'Large Canine ';
else                           size = 'Giant Canine ';
%*Close the macro;
%mend sizing;
/********************************************************************
Macro ageclass macro to classify an animal according to age
Variable Specification:
agelevel name of age class variable
********************************************************************/
%macro ageclass;
%* Use if then else structure to classify age;
	 if     age <= 2 then agelevel = 'Puppy Dog ';
else if 2 < age <= 8 then agelevel = 'Adult Dog ';
else                      agelevel = 'Senior Dog';
%*Close the macro;
%mend ageclass;
/********************************************************************
macro univar1 to be used to find descriptive statistics for each data 
file using proc means and specifying mean, sample size, median, and 
standard deviation
Variables:
varname name of variable to be specified in indata1 macro
*********************************************************************/
%macro univar1(varname);
proc means n mean median stddev;
%*Use a var statement to input the variable of interest;
var &varname;
%*Close the univar1 macro;
%mend univar1;
/********************************************************************
macro classify1 to be used to classify the dog breeds as mixed or pure breed
Variable specification:
BreedType name of breed classification 
*********************************************************************/
%macro classify1;
%*Use if then else structure to classify breed type;
     if breed = ShepherdMix  then BreedType = 'Mixed Breed';
else if breed = HuskyMix  then BreedType = 'Mixed Breed';
else if breed = LabMix    then BreedType = 'Mixed Breed';
else if breed = AussieMix then BreedType = 'Mixed Breed';
else 					       BreedType = 'Pure Breed ';
%*Close the macro classify1;
%mend classify1; 
/* ******************************************************************
macro importing
USAGE: to read in Excel files
Variables:
start sheet number to start
stop sheet number to stop
name1 base name of the worksheets
name2 name to add on for new SAS dataset
filename name and path to Excel file to be read in
varname the variable name to use to find descriptive statistics
******************************************************************* */
%macro indata1(start,stop,name1,name2,filename,varname);
%*Setup macro do loop to read in series of worksheets;
%do i = &start %to &stop;
%* Use proc import to import the excel file;
PROC IMPORT OUT = WORK.&name1&i
	DATAFILE= "&filename&i..xls"
	DBMS=xls REPLACE;
	SHEET="&name1&i";
	GETNAMES=YES;
%*Create new SAS temporary dataset;
	data &name1&i&name2;
%*	Format %heading1(what,number1,quarter1,&i);
	%heading1(Assignment,6,Winter 2018,&i);
%*Use set command to get information from output file;
	set &name1&i;
%* Classify dogs according to size;
	%sizing;
%*CLassify dogs according to age;
	%ageclass;
proc print noobs;
title7 'Age class';
%*Classify dog breed using classify1;
	%classify1;
proc print noobs;
title7 'Classify';
%*Invoke the macro univar1 and have the parameter varname to add any variable later;
	%univar1(&varname);
%*Print the data as check;
	proc print noobs;
%*Close the marco do loop;
	%end;
%*Close the macro;
	%mend indata1;
/*************************************************************************
	macro combine1 macro to combine all data files

	Variable Specification:
	basename base name of existing SAS dataset
	number number of files to combine
*************************************************************************/
	%macro combine1(basename,number);
%*Create new temporary SAS dataset called combine1;
	data combine1;
%*Use the set command to concatenate all of the files;
	set %namelst(&basename,&number);
%*Classify dogs according to size;
	%sizing;
%*Classify dogs according to age;
	%ageclass;
%*Classify dog breed using classify1;
	%classify1;
%*Create new title 6;
	title6 'Veterinarian File Combined Data';
%*Print as check;
	proc print;
%*Close the macro;
	%mend combine1;
/*Execute the macro
	Format %indata1(start,stop,name1,name2,filename_including_path,varname)
Be sure you change the path to your file*/
	%indata1(1,2,dog,b,C:\Users\sarah\Downloads\dogs_w18,weight);
/*Execute the macro combined
	Format %combined(basename,number)*/
	%combine1(dog,2);
run;
quit;
