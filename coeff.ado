cap program drop coeff
program  coeff
	version 13 	
	syntax varlist(min=2)  [if] [in] , [begin(real 0)] [end(integer 0)]  time(varlist) [variables(varlist)] /*Correct*/
	tokenize `varlist'
	local first `1'
	macro shift
	local rest `*'
	/*Check if End date is after being date*/
	if `end' < `begin'{
		di "Error, Begin date must be before end Date"
		error 124
	}
	/*In case they are required*/
	if `end' ==0 & `begin'==0  {                       
		di "Doing Regression"
	}
	if  !missing(`begin') & `end'!=0 {	
		local k=0
		local count=0
		forvalues i=`begin'/`end'{
				local count=`count'+1
				local h=0
				foreach var2 in `variables'{
					local k=`k'+1	
					local h=`h'+1
					qui reg `varlist' `var2' if `time'==`i'  
					
						if `count'==2{
						local legend= "`h'-`var2'  "
						local legenda="`legenda'"+"`legend'"
						}
						local dof=e(df_r)
						matrix b=e(b)
						local coefficient=b[1,1]  
						matrix var=e(V)
						local se=sqrt(var[1,1])
						local tstat=`coefficient'/ `se'
						local pvalue =2*ttail(`dof', abs(`tstat'))
						matrix c= `k',  b[1,1], `pvalue',  `tstat', `dof', `i', `h'
					if `k'==1 {  /*Create a matrix of betas which equals our thing above*/
					matrix betas=c
					}
						else{
						matrix betas=(betas\c)  /*Add to the matrix*/
						}
				} //End of loop foreach var2
		}
		matrix colnames  betas=  Reg_Number Coefficient P-value T-stat DOF  Year Variable 
		*matrix rownames  betas=  Dependent Coefficient P-value Year SE DOF Dummy_ratio Measure

		matrix list betas,  noheader

		di "Regression of  `first' (dependent variable) on (`rest') for years between `begin' and `end' ."
	}
	di "Legend-Column 1 shows the regression number, Column 2 shows the coefficients, Column 3 P values, Column 4 T statistic, Column 5 DOF"
	di "Column 6 shows the year, Column 7 shows the variable we are testing (variables option)"
	di "Legend for Column 7  `legenda'"
	end 
	
	
