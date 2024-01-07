#Tutorial 2 Smoothing Methods
# The file DepartmentStoreSales.xls contains data on the quarterly sales for a
# department store over a 6-year period. The time plot of the data is shown in
# the following figure.
#Exercise 1 -------------------------------------------------------------------
# a) Which method is not suitable for forecasting this series?
# --> the series shows seasonality and a small upward trend
# • Moving average of raw series --> not suitable
# • Moving average of deseasonalized series --> not suitable
# • Simple exponential smoothing of the raw series --> not suitable
# • Double exponential smoothing of the raw series --> not suitable
# • Holt-Winter’s exponential smoothing of the raw series --> suitable

# b) A forecaster was tasked to generate forecasts for 4 quarters ahead. She
#    therefore partitioned the data so that the last 4 quarters were designated as the
#    validation period. The forecaster approached the forecasting task by using
#    multiplicative Holt-Winter’s exponential smoothing. The smoothing constants
#    used were a = 0.2, b = 0.15, g = 0.05.

#part I
library(readxl)
DepartmentStoreSales <- read_excel("DepartmentStoreSales.xlsx")
ts <- ts(DepartmentStoreSales[ , 2], start = c(1, 1), frequency = 4)
Training_ts <- window(ts, start = c(1, 1), end = c(5, 4))
Validation_ts <- window(ts, start = c(6,1), end = c(6,4))
plot(ts, xlab = "Quarter", ylab = "Sales", bty = "l", type = "b")

ets.HW <- ets(Training_ts, "ZMM", alpha =  0.2, beta =  0.15, gamma = 0.05)
ets.HW.forecast <- forecast(ets.HW, h = length(Validation_ts), level = 0)
plot(ets.HW.forecast, xlab = "Quarter", ylab = "Sales", bty = "l", type = "b")

#part II
accuracy(c(59384.56586, 61656.49426), c(60800, 64900)) #Forecasted vs actual, for the 2 quarters

# c) The fit and residuals are displayed in the following figures. Using all the
#    information from part b) and the following figures, is this model suitable for
#    forecasting quarters 21 and 22?
#    --> From b) we know that the actual and forecasted values in periods 21-22 match well as e.g. 
#        the MAPE is quite low. However, we see from the forecast error plot that towards the end 
#        of the training period the model is systematically under-forecasting (positive errors). 
#        This might be problematic for forecasting periods 21-22.
plot(ets.HW.forecast$residuals, xlab = "Quarter", ylab = "Sales", bty = "l", type = "b")
abline(h = 0, col = "blue")

# d) Another analyst decided to take a much simpler approach, and instead of using
#    exponential smoothing he used differencing. Use differencing to remove the
#    trend and seasonal pattern. Which order works better: first removing trend and
#    then seasonality or the opposite order? Show a time plot of the differenced
#    series.

plot(diff(Training_ts, lag = 1), ylab = "Lag-1",xlab = "Time (Yearly)",
      bty = "l", main = "Lag-1 Difference")
plot(diff(Training_ts, lag = 4), ylab = "Lag-4", xlab = "Time (Yearly",
      bty = "l", main = "Lag-4 Difference")
plot(diff(diff(Training_ts, lag = 1), lag = 4), ylab = "Lag-4, then Lag-1", xlab = "Time (Yearly",
     bty = "l", main = "Twice-Differenced (Lag-4, Lag-1)")

# --> The order of applying the double differencing does not matter and both orders give the same results.

# e) Forecast quarters 21-22 using the average of the double differenced series from
#    (d). Remember to use only the training period (until quarter 20), and to adjust
#    back for the trend and seasonal pattern.

ets.HW.forecast.diff <- meanf(diff(diff(Training_ts, lag = 1), lag = 4),h = 2)
autoplot(ets.HW.forecast.diff)
ets.HW.forecast.diff$mean[1] #forecasted values for both Q21 and Q22

Forecast.Q21 <- ets.HW.forecast.diff$mean[1] + Training_ts[17] + Training_ts[20] - Training_ts[16]
Forecast.Q22 <- ets.HW.forecast.diff$mean[2] + Training_ts[18] + Forecast.Q21 - Training_ts[17]
# --> Forecast.Qxx <- Forecasted value + value (previous season) + previous value - last value (previous season)

# f) Compare the forecasts from (e) to the exponential smoothing forecasts in the
#    table in (b). Which of the two forecasting methods would you choose? Explain.

accuracy(c(Forecast.Q21, Forecast.Q22), c(60800, 64900))

#    --> The  multiplicative Holt-Winter’s exponential smoothing shows a lower MAPE
#        The forecasts from the averaged differenced series are less accurate (MAPE = 5.141% vs 3.663%).
#        For each of quarters 21,22 they over-forecast by more than 3,000. Hence, the Holt-Winters' 
#        method is more accurate.

# g) What would even be a simpler approach that should be used as a baseline?
#    --> Using (seasonal) naïve forecasts. Since there is quarterly seasonality, 
#        the seasonal naive forecast for quarter 21 is equal to sales in quarter 17 (56,405), 
#        and for quarter 22 the seasonal naive forecast is equal to sales in quarter 18 (60,031). 

snaive <- snaive(Training_ts, h = 2)
accuracy(snaive, Validation_ts) #7.365%
accuracy(c(56405,60031), c(60800, 64900)) #7.365%

# --> The best forecasting method would be the Multiplicative Holt-Winter's model with MAPE = 3.663%

#Exercise 2 -------------------------------------------------------------------
# Use a four-week trailing moving average on week 1-4 to forecast the
# demand for week 5-8. What are the ME, MAE, MAPE, and MSE? Repeat the
# calculations with simple exponential smoothing (α=0.2). Which of the two
# methods do you prefer? Why? (For this exercise you do not need use R)

data.points <- c(108,116,118,124,96,119,98,102)
ts <- ts(data.points, start = c(1,1), frequency = 52)
Trailing.ma <- rollmean(ts, k =  4, fill = NA , align =  "right")
ts[(5:8)] <- Trailing.ma[4]
accuracy(c(96,119,98,102), c(116.5,116.5,116.5,116.5)) # MAPE = 12.02%

ses <- ets(ts[(1:4)], "ANN", alpha = 0.2)
ses.forecast <- forecast(ses, h = 4, level = 0)         
autoplot(ses.forecast)
ses.mean <- ses.forecast$mean[1]
accuracy(c(96,119,98,102), c(ses.mean,ses.mean,ses.mean,ses.mean)) #MAPE = 11.12%
