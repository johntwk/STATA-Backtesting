# STATA-Backtesting

## Description
This repositor contains a STATA program for backtesting forecasts, and a STATA help file explaining how to use the program.

## Purpose
This program implements backtesting for forecasts, given a time-series of the forecat and another time-series of the actual data.

## Examples

### Setup

Suppose that we set the number of observations to be 20.
Then we generate the time variable, one random variable as the actual time-series, and one variable as the forcast.
'''
. set obs 20
. gen time = _n
. tsset time
. gen actual = rnormal()
. gen forecast_ = runiform()
'''
### Backtesting

We back-test the forecasts against the actual time-series.
. back_testing actual forecast_
We back-test with number of decimal places specified.
. back_testing actual forecast_, num_decimals(7)




## Files
Files in this repository:

|    | File Name          | Description                  |
|----|--------------------|------------------------------|
| 1. | back-testing.ado   | The backtesting program      |
| 2. | back-testing.sthlp | The help file of the program |
