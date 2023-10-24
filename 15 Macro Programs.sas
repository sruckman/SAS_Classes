/*HW 15 Macro Programs*/
%let path= /home/u62104146/my_shared_file_links/jhshows0/STA5067/SAS Data;
libname orion "&path/orion";

/*Question 1a*/
%macro custtype(type);
	%let type=%upcase(&type);
	proc print data=orion.customer_dim;
		var Customer_Group Customer_Name Customer_Gender Customer_Age;
		where upcase(Customer_Group) contains "&type";
		title "&type Customers";
	run;
%mend custtype;
%custtype(Internet)

/*Question 1b*/
%macro custtype(type)/minoperator;
	%let type=%upcase(&type);
	%if &type in INTERNET GOLD %then %do; 
	proc print data=orion.customer_dim;
		var Customer_Group Customer_Name Customer_Gender Customer_Age;
		where upcase(Customer_Group) contains "&type";
		title "&type Customers";
	run;
	%end;
	%else %do;
	%put ERROR: Value of TYPE: &type is not valid.;
	%put ERROR: Valid values are INTERNET or GOLD;
	%end; 
%mend custtype;

/*Question 1c*/
%custtype(Internet) /*Vaild*/
%custtype(Corgi) /*Invaild*/

/*Question 1d*/
%macro custtype(type)/minoperator;
	%if &type= %then %do;
		%put ERROR: You must provide a value for TYPE;
		%put ERROR: Valid values are INTERNET or GOLD;
	%end;
	%else %do;
 		%let type=%upcase(&type);
 		%end;
 		%if &type in INTERNET GOLD %then %do; 
	    proc print data=orion.customer_dim;
	       var Customer_Group Customer_Name Customer_Gender Customer_Age;
	       where upcase(Customer_Group) contains "&type";
	       title "&type Customers";
	    run;
    %end;
    %else %do;
	    %put ERROR: Value of TYPE: &type is not valid.;
	 	%put ERROR: Valid values are INTERNET or GOLD;
 	%end; 
%mend custtype;

/*Question 1e*/
%custtype() /*Null*/
%custtype(Gold) /*Vaild*/
%custtype(Corgi) /*Invaild*/

/*Question 2a*/
%macro listing(custtype);
	proc print data=orion.customer noobs;
	run;
%mend listing;
%listing(2010)

/*Question 2b*/
%macro listing(custtype);
	proc print data=orion.customer noobs;
	%if &custtype= %then %do;
		var Customer_ID Customer_Name Customer_Type_ID;
		title "A Listing of All Customers";
	%end;
	%else %do;
		where Customer_Type_ID = &custtype;
		var Customer_ID Customer_Name;
		title "A Listing of &custtype Customers";
	%end;
	run;
%mend listing; 

/*Question 2c*/
%listing() /*Null*/
%listing(2010) /*Vaild*/

/*Question 2d ERROR!!*/
%macro listing(custtype)/minoperator;
	proc sql noprint;
		select distinct Customer_Type_ID
		into :IDLIST separated by ' '
		from orion.customer_type;
	quit;
	%if &custtype= %then %let FLAG=0;
	%else %if &custtype in &IDLIST %then %let FLAG=0; 
	%else %let FLAG=1;
	%if &FLAG = 0 %then %do;
		proc print data=orion.customer noobs;
		%if &custtype= %then %do;
		var customer_id customer_name customer_type_id;
		title "A Listing of All Customers";
		%end;
		%else %do;
		where Customer_Type_ID =&custtype;
		var Customer_ID Customer_Name;
		title "A Listing of &custtype Customers";
		%end;
		run;
	%end;
	%if &FLAG=1 %then %do;
		%put ERROR: Value for CUSTTYPE is invalid.;
		%put ERROR- Valid values are &IDLIST;
	%end;
%mend listing;

/*Question 2e*/
%listing() /*Null*/
%listing(2010) /*Vaild*/
%listing(2) /*Invaild*/

/*Question 3a*/
%macro generatecode(bartype=VBAR, dims=3D, 
                    var=Customer_Age_Group, color=pink, 
                    surface=S);
    proc gchart data=orion.customer_dim;
       &bartype&dims &var;
       pattern color=&color value=&surface;
    run;
    quit;
%mend generatecode;
%generatecode()

/*Question 3b*/
%macro generatecode(bartype=VBAR, dims=3D, var=Customer_Age_Group, color=pink, 
					surface=S)/minoperator;
    %let numerrors = 0;
    %if not(&bartype in VBAR HBAR) %then %do;
    	%let numerrors=%eval(&numerrors+1);
    	%put ERROR: Invalid Bar Type was supplied.;
    	%put ERROR- Valid Values are VBAR or HBAR.;
    	%end;
    %if not(&dims in 3D NULL) %then %do;
    	%let numerrors=%eval(&numerrors+1);
    	%put ERROR: Invalid Dimension Value.;
        %put ERROR- The value can be 3D or a null value.;
    	%end;
    %if not(&surface in S X1 X2 X3 X4 X5) %then %do;
    	%let numerrors=%eval(&numerrors+1);
    	%put ERROR: Invalid Surface Value.;
        %put ERROR- The value can be S, X1, X2, X3, X4, X5.;
    	%end;
    %if &numerrors = 0 %then %do;
	    proc gchart data=orion.customer_dim;
	       &bartype&dims &var;
	       pattern color=&color value=&surface;
	    run;
	    quit;
    %end;
    %else %do;
    	%put ERROR: Due to parameter errors SAS code will not execute.;
    	%put ERROR- You have &numerrors errors.; 
    %end;
%mend generatecode;

/*Question 3c*/
%generatecode(bartype=sbar, dims=1t ,surface=99)

/*Question 4a*/
proc means data=orion.order_fact sum mean maxdec=2;
	where Order_Type = 1;
	var Total_Retail_Price CostPrice_Per_Unit;  
	title "Summary Report for Order Type 1";
run;

/*Question 4b*/
%macro separate;
	%do i=1 %to 3;
	proc means data=orion.order_fact sum mean maxdec=2;
		where Order_Type = &i;
		var Total_Retail_Price CostPrice_Per_Unit;
		title "Summary Report for Order Type &i";
	run;
	%end;
%mend separate;
%separate

/*Question 5a*/
%macro tops(obs=3);
	proc means data=orion.order_fact sum nway noprint; 
		var Total_Retail_Price;
		class Customer_ID;
		output out=customer_freq sum=sum;
	run;
	proc sort data=customer_freq;
		by descending sum;
	run;
	data _null_;
		set customer_freq(obs=&obs);
		call symputx('top'||left(_n_), Customer_ID);
	run;
%mend tops;

%tops()
%tops(obs=5)

/*Question 5b*/
%macro tops(obs=3);
	proc means data=orion.order_fact sum nway noprint;
		var Total_Retail_Price;
		class Customer_ID;
		output out=customer_freq sum=sum;
	run;
	proc sort data=customer_freq;
		by descending sum;
	run;
	data _null_;
		set customer_freq(obs=&obs);
		call symputx('top'||left(_n_), Customer_ID);
	run;
	proc print data=orion.customer_dim noobs;
		where Customer_ID in (%do i=1 %to &obs; &&top&i %end;);
		var Customer_ID Customer_Name Customer_Type;
		title "Top &obs Customers";
	run;
%mend tops;

%tops()
%tops(obs=5)

/*Question 6a*/
%macro memberlist(custtype);
	proc print data=Orion.Customer_dim;
		var Customer_Name Customer_ID Customer_Age_Group;
		where Customer_Type="&custtype";
		title "A List of &custtype";
	run;
%mend memberlist;

%macro listall;
	data _null_;
		set orion.customer_type end=final;
		call symputx('type'||left(_n_), Customer_Type);
		if final then call symputx('n',_n_);
	run;
	%put _user_; 
%mend listall;

%listall

/*Question 6b*/
%macro memberlist(custtype);
	proc print data=Orion.Customer_dim;
		var Customer_Name Customer_ID Customer_Age_Group;
		where Customer_Type="&custtype";
		title "A List of &custtype";
	run;
%mend memberlist;
%macro listall;
	data _null_;
		set orion.customer_type end=final;
		call symputx('type'||left(_n_), Customer_Type);
		if final then call symputx('n',_n_);
	run;
	%do i=1 %to &n;
	%memberlist(&&type&i)
	%end;
%mend listall;
%listall 

/*Question 7a*/
%macro varscope;
	data _null_;
		set orion.customer_type end=final;
		call symputx('localtype'||left(_n_), Customer_Type);
		if final then call symputx('localn',_n_);
	run;
	%put _user_;
%mend varscope;

%varscope

/*Question 7b*/
%macro varscope;
	data _null_;
		set orion.customer_type end=final;
		call symputx('localtype'||left(_n_), Customer_Type,'L');
		if final then call symputx('localn',_n_,'L');
	run;
	%put _user_;
%mend varscope;

%varscope 