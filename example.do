*In order to run this example, first run the program Coeff. 

sysuse auto.dta, clear
gen year=2008 if _n<50
replace year=2009 if _n>=50
coeff mpg price  weight, time(year) begin(2008) end(2009) variables(length turn trunk headroom  ) 
