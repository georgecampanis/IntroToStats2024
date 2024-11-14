

######################################################################
# source => 
# https://r4ds.had.co.nz/introduction.html
# Hadley Wickham R for Data Science
# https://statsandr.com/blog/descriptive-statistics-in-r/
# https://statsandr.com/blog/data-types-in-r/
# https://www.w3schools.com/r/r_stat_intro.asp
#
# Author: George Campanis
# Date: 14-Nov-2024
# Purpose: Teaching Summary Stats to DA Group 
###################################################################

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



