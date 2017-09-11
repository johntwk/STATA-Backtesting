//********************************************
// Name   : John Tsang
// Purpose: Implement back-testing for forecasting errors
// File   : back_testing.ado
// Date   : 2nd May 2017 
**********************************************..
capture program drop back_testing
program define back_testing, rclass
  syntax varlist(ts min=2 max=2) [if] [in] [, num_decimals(integer 4)]
  
  // Check if option is valid
  if (`num_decimals' < 0 | `num_decimals' > 8) {
    display as error "Invalid Number of decimals (Valid number of decimals: 0 to 8)"
    exit
  }
  
  tempname touse
  mark `touse' `if' `in'
  qui tsset
  local time_var r(timevar)
  
  tokenize `varlist'
  local actual_var `1'
  local forecast_var `2'
  local RMSE = 0
  local MAPE = 0
  local MAE  = 0
  display as text ""
  display as result "Back-Testing: `actual_var' (Actual) Vs. `forecast_var' (Forecast)"
  display as text ""
  
  preserve
    qui keep if `touse'
	local is_MAPE = 1
    local sample_size = _N

	forvalues i = 1/`sample_size' {
	  if (`actual_var'[`i'] == 0) {
	    local is_MAPE = 0
	  }
	  if (`actual_var'[`i'] == .) {
	    display as error "Observation `i' of `actual_var' is missing"
		exit
	  }
	  if (`forecast_var'[`i'] == .) {
	    display as error "Observation `i' of `forecast_var' is missing"
		exit
	  }
	  
	  local deviation_ = (`actual_var'[`i'] - `forecast_var'[`i'])
	  local RMSE = `RMSE' + (`deviation_')^2
	  if (`is_MAPE' == 1) {
	    local MAPE = `MAPE' + abs(`deviation_')/`actual_var'[`i']
	  }
	  local MAE  = `MAE'  + abs(`deviation_')
	}
	local RMSE = sqrt(`RMSE'/`sample_size')
	if (`is_MAPE' == 1) {
	  local MAPE = `MAPE'/`sample_size'
	}
	local MAE = `MAE'/`sample_size'
  restore 
  local a = 4
  display as text "{hline 10}{c TT}{hline 20}"
  display as text " RMSE     {c |}", _continue
  display as result %9.`num_decimals'f `RMSE'
  display as text "{hline 10}{c +}{hline 20}"
  display as text " MAPE     {c |}", _continue
  if (`is_MAPE' == 1) {
    display as result  %9.`num_decimals'f `MAPE'
  }
  else {
    display as result "MAPE is not available (An Actual observation is 0)"
  }
  display as text "{hline 10}{c +}{hline 20}"
  display as text " MAE      {c |}", _continue
  display as result  %9.`num_decimals'f `MAE'
  display as text "{hline 10}{c BT}{hline 20}"
  
  return scalar RMSE = `RMSE'
  return scalar MAE  = `MAE'
  if (`is_MAPE' == 1) {
    return scalar MAPE = `MAPE'
  }
end
