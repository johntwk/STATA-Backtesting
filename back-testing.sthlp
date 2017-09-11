{smcl}
{* 2may2017}{...}
{hline}
Help for {hi:back_testing (rclass)}{right:John Tsang}
{hline}

{title:Back-Testing for Forecasting Evaluation}

{p 6 14}{cmd:back_testing} {it:varlist} [{cmd:if} {it:exp}] [{cmd:in} {it:range}], [{cmd:num_decimais ls}({it:integer})]

{p}{cmd:back_testing} is for use with time-series data.  You must {cmd:tsset} your
data before using {cmd:back_testing}; see help {help tsset}.

{p} {it:varlist} cannot contain time-series operators, and {it:varlist} must contain {ul:{bf:only 2 variables}} with
the {bf:{ul:first variable being the actual time-series}} and {bf:{ul:the second variable being the forcasts}}. 

{title:Description}

{cmd:back_testing} calculates a variety of statistics for back testing forecasts. 
Indeed, it calculates the root mean square error (RMSE), the mean absolute percentage error (MAPE),
and the mean absolute error (MAE).

None of the observations of the actual time-series and the forecasts can be missing.

Also, if an observation of the actual time-series is 0, MAPE will not be calculated. 
Otherwise, there will be a divide-by-zero error.

{title:Compulsory Inputs}

{p 0 4}{it: varlist} specifies 2 time-series variables with the first one being the actual time-series
and the second one being the fotecasts.

{title:Options}

{p 0 4}{cmd:num_decimals} specifies the number of decimal places (in integer) to be displayed, ranging from 0 to 8 decimal places.
By default, statistics will be displayed in 4 decimal places.

{title:Return}

{bf:Scalars}:

 1. r(RMSE)  : stores the value of the root mean square error.
 2. r(MAE)   : stores the value of the mean absolute error.
 3. r(MAPE)  : stores the value of the mean absolute percentage error, if any.
 
{title:Examples}

{it:{bf:Setup}}

Suppose that we set the number of observations to be 20.
Then we generate the time variable, one random variable as the actual time-series,
and one variable as the forcast.

. {stata "set obs 20":set obs 20}
. {stata "gen time = _n"     :gen time = _n}
. {stata "tsset time"     :tsset time}
. {stata "gen actual = rnormal()"     :gen actual = rnormal()}
. {stata "gen forecast_ = runiform()"     :gen forecast_ = runiform()}

{it:{bf:Back-testing}}

We back-test the forecasts against the actual time-series.
. {stata "back_testing actual forecast_"     :back_testing actual forecast_}
We back-test with number of decimal places specified.
. {stata "back_testing actual forecast_, num_decimals(7)":back_testing actual forecast_, num_decimals(7)}


