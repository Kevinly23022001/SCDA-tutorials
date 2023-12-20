#Function for packages------------------------------------------------------------------
# install.packages("<package name>") --> to install a package
# update.packages("<package name>") --> to update a package
# library("<package name>") --> to load a package

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

#Normal arithmetic operators------------------------------------------------------------
# +, -, *, /, ^

#Boolean operators----------------------------------------------------------------------
# ==, >=, <=, != 
# True/false

#Packages-------------------------------------------------------------------------------
# https://cran.r-project.org/web/views/ --> list of packages


