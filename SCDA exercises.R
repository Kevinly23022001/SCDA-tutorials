#Function for packages------------------------------------------------------------------
# install.packages("<package name>") --> to install a package
# update.packages("<package name>") --> to update a package
# library("<package name>") --> to load a package

#Packages-------------------------------------------------------------------------------
# https://cran.r-project.org/web/views/ --> list of packages

#Read Data from csv/excel---------------------------------------------------------------
# --> files should be in the current WD
# read.csv("name.csv")
# read_excel("name.xlsx")

#Creating an object/variable------------------------------------------------------------
#Object: An object is simply a data structure.
#        We can save data as an object and use an object to call up stored data
# Object_name <- value/object_type

#List all objects names already used, function
# ls()

#Object types
# Vector:     c()
# List:       list()
# Matrix:     matrix()
# Array:      array()
# Factor:     factor()
# Data frame: data.frame()

#Data types-----------------------------------------------------------------------------
#Ask the data type structure
# str(variable/object)
# class(variable/object)

#data types
# numeric   --> pi --> 3.1459....
# integer   --> 42
# character --> "Apple"
# logical   --> True/False

#Change data types
# as.numeric(variable/object)
# as.integer(variable/object)
# as.character(variable/object)
# as.logical(variable/object)

#Remover variable/object
# rm(variable/object)

#Data frames----------------------------------------------------------------------------
#Load data frame
# variable_DF <- file      --> store file in variable_DF
# view(variable_DF)        --> view the dataframe
# variable_DF[row, column] --> value in [row:row, column:column], empty --> whole row/column
#                         or
# variable_DF$column_name  --> value in [ , column_name]

#Data frame calculations
# variable_DF$column_name * 2                       --> every row in column_name * 2
# variable_DF$column_name * variable_DF$column_name --> multiply columns
# variable_DF$new_column_name                       --> creates a new column

# Example code
# Cars_DF <- mtcars
# Mazda_RX4_Wag <- Cars_DF[2, ]

#Saving and reading a data frame
# save(variable_DF, file = "file_name.Rda")       --> save DF to file
# write.csv(variable_DF, file = "file_name.csv")  --> save DF to csv
# df <- read.csv(file = "file_name.csv")          --> read csv file

#Create vector variable from a Data frame
# Object_name <- variable_DF$column_name --> create variable from a DF

#Create a data frame
#Combine vector variables of equal size
# df <- data.frame(variable_name1, variable_name2, variable_name3)

# Example
# name <- c("Kevin", "Dung", "Cuong", "Hong")
# age <- c(22, 23, 53, 50)
# woonplaats <- c("Apeldoorn","Apeldoorn","Apeldoorn","Apeldoorn")
# df <- data.frame(name, age, woonplaats)

#Vector operations-----------------------------------------------------------------------
# seq(from = x, to = y, by = n) --> create vector sequence from x to y by steps of n
# rep(x, y)                     --> create vector sequence of value x, y times

#Normal arithmetic operators------------------------------------------------------------
# +, -, *, /, ^

#Boolean operators----------------------------------------------------------------------
# ==, >=, <=, != 
# True/false

#Using a function-----------------------------------------------------------------------
#Function: A function is a set of statements organized together to perform a 
#          specific task. A function usually takes in some sort of data structure, 
#          processes it, and returns a result.
# Function() {argument}
#or
# Function(argument)

#Argument types
# round(number, digits = x) --> round a number x, digits x
# mean(numbers)             --> calculate the mean of numbers x:x
# factorial(number)         --> number!
# sample(x = x:x, size = n, replace = true/false) 
#             --> returns a sample from sample size of n from range x:x, 
#             with/without replacement (putting number back in the jar)
# sum(numbers)              --> sum the numbers
# sqrt(number)              --> square root of number

# Example
# square_it <- function(x) {
#     square <- x^2
#     return(square)
# }
# square_it(4)

# to_Fahrenheit <- function(c) {
#      Fahrenheit <- (c*(9/5))+32
#      return(Fahrenheit)
# }
# to_Fahrenheit(25)

#If-Else statements
# Example
# sign <- function(x) {
#     if(x>=0){
#       print("non-negative number")
#     } else {
#       print("negative number")
#     }
# }
# sign(-2)

#loops
# Example --> fill in from row 3 until row 100 using loop

# sales_volume <- vector(mode = "integer", length = 100)
# sales_volume[1] <- 0
# sales_volume[2] <- 5

# for (i in 3:length(sales_volume)) {
#     sales_volume[i] <- sales_volume[i-1] * 1.5
# }

# Example --> fill in from row 3 as long as i-1 <= 100

# sales_volume <- vector(mode = "integer", length = 100)
# sales_volume[1] <- 0
# sales_volume[2] <- 5
# i = 3
# while (sales_volume[i-1] <= 100) {
#       sales_volume[i] <- sales_volume[i-1] * 1.5
#       i = i + 1
# }

# Example --> fill in a matrix, from column 1 to column 2, from row 1 to row 10,
#                               j  fast running index, i --> slow running index

# mat <- matrix(0, nrow = 10, ncol = 10)
# for (i in 1:10) {
#     for (j in 1:10) {
#        mat[i, j] <- j - i
#     }  
# }

#Plotting-----------------------------------------------------------------------
#df <- airquality

#plots
# plot(df)          --> plot whole data frame (scatter)
# ?plot()           --> for help

# plot(df$Ozone)    --> plot 1 variable from the data frame against index (scatter)

# barplot(df$Ozone) -->  plot 1 variable from the data frame against index (bars)

# hist(df$Ozone)    --> plot histogram of 1 variable from the data frame

# boxplot(df$Ozone) --> plot boxplot of 1 variable from the data frame

# plot(df$Ozone, df$Wind,                    --> vector(x), vector(y)
#     pch = 16,                             --> shape of data points
#     cex = 1,                              --> size of data points
#     col = "black",                        --> color of data points
#     main = "Wind plotted against Ozone",  --> add graph title
#     xlab = "Ozone", ylab = "wind")        --> add axis labels

# abline(lm(df$Wind ~ df$Ozone))            --> add linear regression line to plot
# abline(h = 10, col = "purple")            --> add line at y = 10

#save plot to pdf
# pdf(file = "histogram_wind_plot.pdf",     --> create file to .pdf
#    width = 8, height = 6)

# hist(df$Wind,                             --> create plot
#     col = "blue",
#     main = "Wind histogram",
#     breaks = 10,
#     xlab = "frequency", ylab = "Wind")

# dev.off()                                 --> end and save

#Statistics-----------------------------------------------------------------------
set.seed(1)

y = rnorm(100, mean = 0, sd = 1)
prob_y = pnorm(y)
hist(prob_y)






