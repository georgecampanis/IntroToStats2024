

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


##################################################################################################################

#   REGRESSION + Cross-Fold Validation
#   Ref: https://towardsdatascience.com/create-predictive-models-in-r-with-caret-12baf9941236 (Simple Regress Example)
#   Ref: https://lgatto.github.io/IntroMachineLearningWithR/supervised-learning.html (More Advanced description of ML in R) e.g. Missing values
#   Ref: https://docs.microsoft.com/en-us/dotnet/machine-learning/resources/metrics  (Performance Metrics)
#   Ref: https://www.r-bloggers.com/2020/05/step-by-step-guide-on-how-to-build-linear-regression-in-r-with-code/ (Checking LR Assumptions)
#################################################################################################################


# NOTE:
# For regression, we will use the root mean squared error (RMSE), 
#           which is what linear regression (lm in R) seeks to minimise. 
# For classification, we will use model prediction accuracy.

install.packages("caret")
library(caret)


data(mtcars)    # Load the dataset
head(mtcars)

# Data Viz
install.packages("corrgram")
install.packages("gridExtra")
library(corrgram)

corrgram(mtcars, order=TRUE)

scatter.smooth(x=mtcars$wt, y=mtcars$mpg, main="Mpg ~ Wt")  # scatterplot
# calculate correlation between Wt and Mpg
cor(mtcars$wt, mtcars$mpg)  

# build linear regression model 
linearMod <- lm(mpg ~ wt, data=mtcars)  
print(linearMod)


# Notice that if wt=4 => 4(-5.344) + 37.285 = 15.904


###################################################
#Now lets build a LR Model based on all features
###################################################
# Model data using 80/20 split
index <- createDataPartition(mtcars$mpg, p=0.8, list=FALSE)
# Subset training set with index
mtcars.training <- mtcars[index,]
# Subset test set with index
mtcars.test <- mtcars[-index,]

# Taining model
lmModel <- lm(mpg ~ . , data = mtcars.training)
# Printing the model object
print(lmModel)



# Multiple linear regression model
model <- train(mpg ~ ., data = mtcars, method = "lm")

# Printing the model object
print(lmModel)


# Checking model statistics
summary(lmModel)

# Pr(>|t|) represents the p-value, which can be compared against the alpha value of 0.05 
# to ensure if the corresponding beta coefficient is significant or not.


# MODEL Performance

# ###########################
# Multiple R-squared: 0.8761
# ###########################################################################################################################
# The R-squared value is formally called a coefficient of determination. 
# Here, 0.8761 indicates that the intercept, and all feature variables, 
# when put together, are able to explain 87.61% of the variance in the mpg variable. 
# The value of R-squared lies between 0 to 1.
# In practical applications, if the R2 value is higher than 0.70, we consider it a good model.
# ###########################################################################################################################

# ###########################
# Adjusted R-squared: 0.8032 
# ###########################################################################################################################
# The Adjusted R-squared value tells if the addition of new information ( variable ) brings significant improvement to the model
# So as of now, this value does not provide much information. However, the increase in the adjusted R-squared value with 
# the addition of a new variable will indicate that the variable is useful and brings significant improvement to the model.
# ###########################################################################################################################

# ##########################################
# p-value: 7.323e-06
# ###########################################################################################################################
# The null hypothesis is that the model is not significant, and the alternative is that the model is significant. 
# According to the p-values < 0.05, our model is significant.
# F-Statistic refers to the comparison of means between two populations we will cover ANOVA in the DataViz class.
# ###########################################################################################################################



##############################################
# Checking Assumptions of Linear Regression
##############################################

#--------------------------------------------
# Errors should follow normal distribution
#--------------------------------------------
install.packages("car")
library("car")
qqPlot(lmModel$residuals)

# A residual is the vertical distance between a data point and the regression line. Each data point has one residual.
# the residual is the error that isn't explained by the regression line
# example: https://images.app.goo.gl/bmLzqTeL2zPiKAeq9 

#--------------------------------------------
# There should be no heteroscedasticity
#--------------------------------------------
# This means that the variance of error terms should be constant. We shall not see any patterns when we draw a plot between residuals and fitted values. 
# And the mean line should be close to Zero.

# A straight red line closer to the zero value represents that we do not have heteroscedasticity problem in our data.
# use a box-cox transformation to fix heteroscedasticity => https://en.wikipedia.org/wiki/Power_transform#Box.E2.80.93Cox_transformation
plot(lmModel, which=1)# 1st Plot


####   => We will use the Root Mean Square Error(RMSE) in caret to evaluate the performance of regression

# Lets use 
## 10-fold CV
# possible values: boot", "boot632", "cv", "repeatedcv", "LOOCV", "LGOCV"
fitControl <- trainControl(method = "repeatedcv", 
                           number = 10,     # number of folds
                           repeats = 10)    # repeated ten times

# Simple linear regression model (lm means linear model)
modelLR.cv <- train(mpg ~ ., data = mtcars,method = "lm", trControl = fitControl)  

modelLR.cv

modelLR.cv <- train(mpg ~ ., data = mtcars,method = "ridge", trControl = fitControl)  

modelLR.cv

############################
# PreProcess
############################
# In this example we're going to use the following pre-processing:
#   center data (i.e. compute the mean for each column and subtracts it from each respective value);
# scale data (i.e. put all data on the same scale, e.g. a scale from 0 up to 1)
# However, there are more pre-processing possibilities such as 
# "BoxCox", "YeoJohnson", "expoTrans", "range", "knnImpute", "bagImpute", "medianImpute", "pca", "ica" and "spatialSign".



modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = c('scale', 'center')) # default: no pre-processing

modelLasso.cv 

modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = "BoxCox") # default: no pre-processing

modelLasso.cv 

modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = "pca") # default: no pre-processing

modelLasso.cv 



########################################################
#Finding the model hyper-parameters
########################################################
# Here we generate a dataframe with a column named lambda with 100 values that goes from 10^10 to 10^-2
lambdaGrid <- expand.grid(lambda = 10^seq(10, -2, length=10))

modelLasso.cv <- train(mpg ~ .,data = mtcars, method = "ridge", trControl = fitControl,
                       preProcess = "BoxCox",tuneGrid = lambdaGrid,   # Test all the lambda values in the lambdaGrid dataframe
                       na.action = na.omit)   # Ignore NA values

modelLasso.cv

########################################################
# Feature Importance
########################################################
ggplot(varImp(modelLasso.cv))
ggplot(varImp(modelLR.cv))


########################################################
# Make Predictions
########################################################
# we should still use cv and test/train split for validation 80/20 validation
predictions <- predict(modelLasso.cv, mtcars)

predictions


