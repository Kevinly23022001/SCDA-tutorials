#Tutorial 1 - The forecasting process 
#Exercise 1 ------------------------------------------------------------------------------------
# The file SouvenirSales.xls contains monthly sales for a souvenir shop at a
# beach resort town in Queensland, Australia, between 1995 and 2001. Back
# in 2001, the store wanted to use the data to forecast sales for the next 12
# months (year 2002). They hired an analyst to generate forecasts. The analyst
# first partitioned the data into training and validation periods, with the
# validation period containing the last 12 months of data (year 2001). She
# then fit a forecasting model to sales, using the training period. Partition the
# data into the training and validation periods as explained above.

#Read file
library(readxl)
SouvenirSales <- read_excel("SouvenirSales.xlsx")

# a) why was the data partitioned?  --> The validation partition allows us to 
#                                       measure the performance of our forecast model,
#                                       which is important because our goal is then to 
#                                       forecast the real future sales.

ts <- ts(SouvenirSales[ , 2], start = c(1995, 1), frequency = 12)
training.ts <- window(ts, start = c(1995, 1), end = c(2000, 12))
validation.ts <- window(ts, start = c(2001, 1))

# b) Why did the analyst choose a 12 month validation period? -
#                                    --> The forecast horizon is monthly forecasts 
#                                        for 12 months ahead. Choosing 12 months
#                                        for the validation partition allows for 
#                                        evaluating the prediction accuracy of 12-month
#                                        ahead forecasts. A choice of a longer 
#                                        validation period might have been avoided to include
#                                        recent data in the training period.

# c) What is the naive forecast for the validation period?
#                                   --> Because there is annual seasonality in the series, 
#                                       the naive forecast for each of the
#                                       months in the validation period is 
#                                       equal to the sales in the most recent 
#                                       similar month. Forvexample, the forecast for 
#                                       January 2001 would be equal to the sales in January 2000

library(fpp2)
library(gridExtra)
naive_forecast <- naive(training.ts, h = length(validation.ts))
plot(naive_forecast, ylab = "sales", xlab = "years", bty = "l", xaxt = "n", yaxt = "n")
axis(1, at = seq(1995, 2002, 1), labels = seq(1995, 2002, 1))
axis(2, at = seq(0, 150000, 25000), labels = seq(0, 150000, 25000))

plot(ts, main = "original series", ylab = "sales", xlab = "years", bty = "l", xaxt = "n", yaxt = "n")
axis(1, at = seq(1995, 2002, 1), labels = seq(1995, 2002, 1))
axis(2, at = seq(0, 150000, 25000), labels = seq(0, 150000, 25000))

# d) The analyst found a forecasting model that gives satisfactory
#    performance on the validation set. What must she do to use the
#    forecasting model for generating forecasts for year 2002?
#                                   --> The training and validation periods must be re-combined, 
#                                       and then the forecasting model should be applied 
#                                       to the complete data series for forecasting the real future
#                                       (2002)

combined_ts <- ts(c(training.ts, validation.ts), start = start(training.ts), 
                    frequency = frequency(training.ts))
naive_forecast_2002 <- naive(combined_ts, h = length(validation.ts))
autoplot(naive_forecast_2002)

# e) Compute the RMSE and MAPE for the naive forecasts using R

accuracy(naive_forecast, validation.ts)

# f) Plot a histogram of the forecast errors that result from the naive
#    forecasts (for the validation period) using R. Plot also a time plot for the
#    naive forecasts and the actual sales numbers in the validation period.
#    What can you say about the behaviour of the naive forecasts?

hist(naive_forecast$residuals, ylab = "Frequency", xlab = "Forecast Error", bty = "l", main = "")
plot(validation.ts/1000, bty="l", xaxt="n", xlab="Year: 2001", main="Naive Forecast versus Actual Sales", 
     yaxt="n", ylab="Sales (in thousands)",type="b")
axis(1, at=seq(2001,2001.917,0.08333), labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
axis(2, las=2) #las: labels are parallel (=0) or perpendicular(=2) to axis
lines(naive_forecast$mean/1000, col="red", lty=2,type="b")

#Only works well if you make the plot screen larger
# legend(2001.3,100, c("Actual Sales","Naive Seasonal Forecast"), col=1:2, lty=1:2)

#Exercise 2 ------------------------------------------------------------------------------------
# a) Create a well-formatted time plot of the data

library(readxl)
DepartmentStoreSales <- read_excel("DepartmentStoreSales.xlsx")
ts <- ts(DepartmentStoreSales$Sales, frequency = 4)
plot(ts/1000, 
     xlab = "Quarter", 
     ylab = "Sales",
     bty = "l", 
     xaxt="n")
axis(1, at=seq(2,24,2), labels=seq(2,24,2))

yearly.ts <- ts(DStoreSales$Sales, start = c(1,1), end = c(6,4), freq = 4)
plot(yearly.ts, xlab = "Time (Yearly)", ylab = "Sales", bty = "l")
# b) Which of the four components (level, trend, seasonality, noise) seem to
#    be present in this series? 
#    --> upward sloping trend and yearly seasonality, every fourth quarter, noise and level

#Exercise 3 ------------------------------------------------------------------------------------











