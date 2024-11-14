

######################################################################
# source => 
# https://r4ds.had.co.nz/introduction.html
# Hadley Wickham R for Data Science
# https://statsandr.com/blog/descriptive-statistics-in-r/
# https://statsandr.com/blog/data-types-in-r/
#
# Author: George Campanis
# Date: 06-Oct-2024
# Purpose: Teaching Summary Stats to DA Group 
###################################################################


#*----------------------------------------------------------------
# Notes: 
# Execute script block -      then Ctrl + Enter
# ctrl l clears screen
# ctrl shift C will comment all selected code
#-----------------------------------------------------------------


install.packages("tidyverse")
install.packages("pastecs")# more stats


library(tidyverse)

# install some data packages 
install.packages(c("nycflights13", "gapminder", "Lahman")) # used 

#--------------------
# coding basics
#--------------------
# Math
1 / 200 * 30
num=1 / 200 * 30
(num2=1 / 200 * 30)

(59 + 73 + 2) / 3
sin(pi / 2)
pi
# var assignment
x <- 3 * 4
x = 3 * 4

# display var
x

(y<-cos(1))
(y<-cos(0))
(y<-sin(0))




# calling functions
# e.g seq()  makes regular sequences of number
seq(1, 10)
v=seq(1, 10)
# enclose in parentheses to display automatically after assignment
(y <- seq(1, 10, length.out = 5))

?seq()

(y <- seq(1, 20, by=2))
(y <- seq(0, 20, by=2))
y[1]
y[11]

# Arrays start at 1 not 0 in R
y[0]



?sd()

# press  Alt + Shift + K and see what happens

library(nycflights13)
library(tidyverse)

?dplyr::filter() 
?stats::filter()

?filter() 





# show flights data
flights # data type is a tibble ---more on this later

# view flights and Iris dataset in RStudio Viewer
View(flights)
View(iris)

# R var types
#  int stands for integers.
#  dbl stands for doubles, or real numbers.
#  chr stands for character vectors, or strings.
#  dttm stands for date-times (a date + a time).
#  lgl stands for logical, vectors that contain only TRUE or FALSE.
#  fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
#  date stands for dates.




# https://statsandr.com/blog/data-types-in-r/
# c is used in R to concatenate 
num_data <- c(3, 7, 2)# numeric series without decimals
# Combine Values Into A Vector Or List
# Try run it....https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/c

num_data[1]


class(num_data) # identifies class of data

typeof(num_data) # to get data type

num_data_dec <- c(3.4, 7.1, 2.9)
class(num_data_dec)
# also possible to check the class thanks to str()
str(num_data_dec)

int_nums = as.integer(num_data_dec)# convert data types
typeof(int_nums)

num_data = as.double(c(3, 7, 2))
typeof(num_data)

###################################
# Chars
#################################
char <- "some text" # strings
char
class(char)
typeof(char)
numAsChar= as.character(int_nums)

# case and space sensitivity 
char_space <- "text "
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


char_space <- "Text"
char_nospace <- "text"
# is char_space equal to char_nospace?
char_space == char_nospace


##############################################
# Factors
# factors are categorical
#############################################
gender <- factor(c("female", "female", "male", "female", "male"))
gender

levels(gender)


fruit = factor(c("apple", "pear", "banana", "apple", "grape"))
levels(fruit)

#By default, the levels are sorted alphabetically
text <- c("test1", "test2", "test1", "test1") # create a character vector
class(text) # to know the class

text_factor <- as.factor(text) # transform to factor
class(text_factor) # recheck the class
levels(text_factor)
##############################################
# Logical
# are boolean true or false
#############################################
value1 <- 7
value2 <- 9

# is value1 greater than value2?
(greater <- value1 > value2)

class(greater)
typeof(greater)

# is value1 less than or equal to value2?
less <- value1 <= value2
less


greater_num <- as.numeric(greater)# FALSE values equal to 0 and TRUE values equal to 1:
greater_num

# also we can take an int and get a logical
x <- 0
typeof(x)
as.logical(x)


############################################
# apply(), lapply(), sapply(), tapply()
# https://www.guru99.com/r-apply-sapply-tapply.html

# apply(X, MARGIN, FUN)
# Here:
#  -x: an array or matrix
#  -MARGIN:  take a value or range between 1 and 2 to define where to apply the function:
#  -MARGIN=1`: the manipulation is performed on rows
#  -MARGIN=2`: the manipulation is performed on columns
#  -MARGIN=c(1,2)` the manipulation is performed on rows and columns
#  -FUN: tells which function to apply. Built functions like mean, median, sum, min, max and even user-defined functions can be applied>

m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
a_m1 <- apply(m1, 2, sum)
a_m1
typeof(a_m1)
class(a_m1)
l_m1=lapply(m1, 2, sum) # error

######################################
# List Apply
#####################################
#   lapply(X, FUN)
#   Arguments:
#   -X: A vector or an object
#   -FUN: Function applied to each element of x

movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)

######################################
# S Apply
#####################################
# same job as lapply() function but returns a vector.
#   sapply(X, FUN)
#   Arguments:
#   -X: A vector or an object
#   -FUN: Function applied to each element of x

# We can measure the minimum speed and stopping distances of cars from the cars dataset.
dt <- cars
view(cars)
lmn_cars <- lapply(dt, min)
smn_cars <- sapply(dt, min)
lmn_cars


smn_cars

######################################
# T Apply
#####################################
# tapply() computes a measure (mean, median, min, max, etc..) or a function for each factor variable in a vector.

# tapply(X, INDEX, FUN = NULL)
# Arguments:
# -X: An object, usually a vector
# -INDEX: A list containing factor
# -FUN: Function applied to each element of x

data(iris)
tapply(iris$Sepal.Width, iris$Species, median)

# => https://statsandr.com/blog/descriptive-statistics-in-r/
# stats summary 

dat <- iris # load the iris dataset and renamed it dat

View(iris)

head(dat)
head(dat,25) # first 6 observations
str(dat) # structure of dataset

levels(dat$Species) # note $ refers to col


#############
# min, max
#############
min(dat$Petal.Length)
max(dat$Sepal.Length)

#================================= START HERE!!!!!
#############
# RANGE
#############
range(dat$Sepal.Length)

# note: we can get array num starting  @ 1,2,...n
arr=range(dat$Sepal.Length)
arr[1]
# or like this
range(dat$Sepal.Length)[2]


# The range is the difference between the maximum and the minimum value
rng= max(dat$Sepal.Length) - min(dat$Sepal.Length)
rng

# create a func
fnRange = function(x) {
  range <- max(x) - min(x)
  return(range)
}

fnRange(dat$Sepal.Length)
fnRange(dat$Petal.Length)

#############
# MEAN
#############
mean(dat$Sepal.Length)

# Remove nulls (na) using na.rm = TRUE 
mean(dat$Sepal.Length, na.rm = TRUE)

# truncated/trimmed mean => Trims top and bottom %
# trim the fraction (0 to 0.5) of observations to be trimmed 
# from each end of x before the mean is computed.
# eg (8 12 12 16) 32 39 39 45 47 50 51 59 61 74 75 87 (87 87 92 93) =>  (0.2 * 20) = 4  is a 0.2 trim
mean(dat$Sepal.Length, trim = 0.10)

#############
# MEDIAN
#############
median(dat$Sepal.Length)
# or
quantile(dat$Sepal.Length, 0.5)

#######################
# 1st and 3rd quartile
######################
quantile(dat$Sepal.Length, 0.25) # first quartile
quantile(dat$Sepal.Length, 0.75) # third quartile

#other quantiles
quantile(dat$Sepal.Length, 0.4) # 4th decile
quantile(dat$Sepal.Length, 0.98) # 98th percentile


#######################
#  Interquartile range
######################
IQR(dat$Sepal.Length)
#OR
quantile(dat$Sepal.Length, 0.75) - quantile(dat$Sepal.Length, 0.25)

##################################
#  Standard deviation and variance
##################################
sd(dat$Sepal.Length) # standard deviation
var(dat$Sepal.Length) # variance

variance= (sd(dat$Sepal.Length))^2
stdDev = sqrt(variance)
# computed using sample formulae i.e. n-1

o=lapply(dat[, 1:4], sd)
o[4]



head(dat)
# selecting individual cols dat[, 1:4]
# lapply vs sapply ?

summary(dat)

# NOTE: if you need these descriptive statistics by group use the by() function:
by(dat, dat$Species, summary)

# for more stats use 
library(pastecs)
stat.desc(dat)


fHtWt <- read.csv(file.choose())

head(fHtWt, 10)
View(fHtWt)

str(fHtWt)

hist(fHtWt$Height)
hist(fHtWt$Weight)
# ref: http://www.stat.umn.edu/geyer/old/5101/rlook.html
# https://www.datascienceblog.net/post/basic-statistics/distributions/
# https://www.statology.org/dnorm-pnorm-rnorm-qnorm-in-r/


# What is the probability that a randomly chosen female weighs more then 150 lbs?


# dnorm for value => Prob. (PDF)
# qnorm for Prob.  => z-score
# pnorm for z-score => Prob. (CDF)

mu=mean(fHtWt$Weight)
sdev=sd(fHtWt$Weight)


dist = dnorm(fHtWt$Weight, mean = mu, sd = sdev)
df = data.frame("Wt" = fHtWt$Weight, "Density" = dist)
library(ggplot2)
ggplot(df, aes(x = Wt, y = Density)) + geom_point()


#PDF
# what is the prob. a female's weight is 150 lbs exactly
dnorm(x=150, mean=mu, sd=sdev)



cdf = pnorm(fHtWt$Weight, mu, sdev)
df <- cbind(df, "CDF_LowerTail" = cdf)
ggplot(df, aes(x = fHtWt$Weight, y = CDF_LowerTail)) + geom_point()



# Put simply, pnorm returns the area to the left of a given value x in the normal distribution. 
# If you're interested in the area to the right of a given value q, you can simply add the argument lower.tail = FALSE

# CDF
# likelihood of weight being >=150 lbs?
pnorm(150, mean=mu, sd=sdev, lower.tail=FALSE)

# likelihood of weight being <150 lbs?
pnorm(150, mean=mu, sd=sdev)

# likelihood between 100-180 lbs
pnorm(180, mean=mu, sd=sdev) - pnorm(100, mean=mu, sd=sdev)

# likelihood between 60-100 lbs
pnorm(100, mean=mu, sd=sdev) - pnorm(60, mean=mu, sd=sdev)

# likelihood between 180-250 lbs
pnorm(250, mean=mu, sd=sdev) - pnorm(180, mean=mu, sd=sdev)

# 
# Z-Scores
# #----------------------------------------------------------

#****************************
# pnorm for z-score => Prob.
#****************************

# For above Mu examples use 1 - pnorm
# e.g. prob. of weight above 2.0 sd = 1-0.9772499
1-pnorm(2)

# for prob. to the left pnorm(2)
pnorm(2)


# for prob between sd -1.28 and 0.72
pnorm(0.72)-pnorm(-1.28)

#****************************
# qnorm for Prob.  => z-score
#****************************
qnorm(0.975) # 1.959964

#***********************
# z-score all the data
#***********************



fHtWt$WeightZ=as.vector(scale(fHtWt$Weight))
head(fHtWt[,c("Weight","WeightZ")])
# shows bottom of the data
tail(fHtWt[,c("Weight","WeightZ")],1000)

1-pnorm(3.489406)


hist(fHtWt$WeightZ)
d <- density(fHtWt$WeightZ)
plot(d)

#---------------------------
# Test normality
#---------------------------

#********************
# #Shapiro-Wilk test
# ******************
# The Shapiro-Wilk test for normality is available when using the Distribution platform to examine a continuous variable. 
# The null hypothesis for this test is that the data are normally distributed.
# If the p-value is greater than 0.05, then the null hypothesis is not rejected.

shapiro.test(fHtWt$Weight)


#********************
# #Shapiro-Wilk test
# ******************
qqnorm(fHtWt$Weight, pch = 1, frame = FALSE)
qqline(fHtWt$Weight, col = "steelblue", lwd = 2)

install.packages("car")
library(car)
qqPlot(fHtWt$Weight)


