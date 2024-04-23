options nocenter nodate ps=55 ls=78;
%macro doloops(startx,stopx,starty,stopy,incx,incy);
	%do x = &startx %to &stopx %by &incx;
		%do y = &starty %to &stopy %by &incy;
			t = &x + 3*&y;
		%end;
	%end;
proc print;
title 'Test 1';
%mend doloops;

%doloops(1,10,1,5,3,2);
run;
quit;
