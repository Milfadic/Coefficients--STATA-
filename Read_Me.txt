/**********************************************************/
/*Created 			Sept 10, 2016 		  */
/*Last Updated			Sept 17, 2016	          */
/*Regress multiple variables			          */
/**********************************************************/
The purpose of this program is to provide a summary of multiple
OLS regression results over a time period over a set of variables.

To illustrate, suppose we have a treatment (Z) we would like to evaluate
for two years (t=2010-2011) individually (one regression for 2010 and the other for 2011).
In addition, we have several definitions of such treatment such that (Z=1,2). This might occur in cases where the treatment might be defined slightly different or in different units. 
Our basic estimation takes the form
y_t= a+ Z_it+ e

Where a is the intercept,  y_t is our dependent variable at year t, and Z_it is treatment I at year t.
We could run 4 separate regressions and then compare the results. However, 
as our time periods/treatments increase, it becomes increasingly difficult 
to succinctly view and compare the results. 

The program coeff runs and presents the estimations mentioned above.
The syntax is as follows 
syntax varlist(min=2)  [if] [in] , [begin(real 0)] [end(integer 0)]  time(varlist) [variables(varlist)]

The varlist contains the basic regression (without the treatment variable). Begin (end) contains the starting (final) period while time  sets the period (minute, week, month, etc..). Variablesshows the different "treatments" we regress over. 

The example provided in this file is:

coeff mpg price  weight, time(year) begin(2008) end(2009) variables(length turn trunk headroom  ) 

This runs the following regression 
reg  mpg price  weight length  if year==2008
reg  mpg price  weight length  if year==2009
reg  mpg price  weight turn  if year==2008
reg  mpg price  weight turn  if year==2009
reg  mpg price  weight trunk  if year==2008
reg  mpg price  weight trunk  if year==2009
reg  mpg price  weight headroom if year==2008
reg  mpg price  weight headroom  if year==2009
And displays the results on the screen. 
This program was created as part of a tutorial on programming. It does not allow to cluster
standard errors or other OLS options. Its main purpose is pedagogical yet it can be easily modified fit your needs. 
Regards,  


