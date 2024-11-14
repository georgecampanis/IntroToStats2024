
######################################################################
# source => 
# https://r4ds.had.co.nz/introduction.html
# Hadley Wickham R for Data Science
# https://statsandr.com/blog/descriptive-statistics-in-r/
# https://statsandr.com/blog/data-types-in-r/
# https://www.w3schools.com/r/r_stat_intro.asp
# Author: George Campanis
# Date: 14-Nov-2024
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
(59 + 73 + 2) / 3
sin(pi / 2)

# var assignment
x <- 3 * 4
x = 3 * 4

# display var
x

# calling functions
# e.g seq()  makes regular sequences of number
seq(1, 10)

# enclose in parentheses to display automatically after assignment
(y <- seq(1, 10, length.out = 5))

?seq()
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


class(num_data) # identifies class of data

typeof(num_data) # to get data type

num_data_dec <- c(3.4, 7.1, 2.9)
class(num_data_dec)
# also possible to check the class thanks to str()
str(num_data_dec)

int_nums = as.integer(num_data_dec)# convert data types

###################################
# Chars
#################################
char <- "some text" # strings
char
class(char)

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

##############################################
# Logical
# are boolean true or false
#############################################
value1 <- 7
value2 <- 9

# is value1 greater than value2?
(greater <- value1 > value2)

class(greater)

# is value1 less than or equal to value2?
less <- value1 <= value2
less


greater_num <- as.numeric(greater)# FALSE values equal to 0 and TRUE values equal to 1:
greater_num

# also we can take an int and get a logical
x <- 0
typeof(x)
as.logical(x)



#########################
#          Vectors
#########################

# Vector of strings
fruits <- c("banana", "apple", "orange")

# Print fruits
fruits

# Vector of numerical values
numbers <- c(1, 2, 3)

# Print numbers
numbers

# Vector with numerical values in a sequence
numbers <- 1:10

numbers

# Vector with numerical decimals in a sequence
numbers1 <- 1.5:6.5
numbers1

# Vector with numerical decimals in a sequence where the last element is not used
numbers2 <- 1.5:6.3
numbers2

#########################
#          Lists
#########################
thislist <- list("apple", "banana", "cherry")
thislist[1]

# check exists
thislist <- list("apple", "banana", "cherry")
"apple" %in% thislist

#append
thislist <- list("apple", "banana", "cherry")
append(thislist, "orange")  # add at location=> append(thislist, "orange", after = 2)

#remove from list
thislist <- list("apple", "banana", "cherry")
newlist <- thislist[-1]

#loop thru list
for (x in thislist) {
  print(x)
}

# Join lists
list1 <- list("a", "b", "c")
list2 <- list(1,2,3)
list3 <- c(list1,list2)


#########################
#          Matrix
#########################
# Create a matrix
thismatrix <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)

# Print the matrix
thismatrix

# Combine matrices
Matrix1 <- matrix(c("apple", "banana", "cherry", "grape"), nrow = 2, ncol = 2)
Matrix2 <- matrix(c("orange", "mango", "pineapple", "watermelon"), nrow = 2, ncol = 2)

# Adding it as a rows
Matrix_Combined <- rbind(Matrix1, Matrix2)
Matrix_Combined

# Adding it as a columns
Matrix_Combined <- cbind(Matrix1, Matrix2)
Matrix_Combined


#########################
#          Data Frames
#########################
# Create a data frame
Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Print the data frame
Data_Frame


Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame

summary(Data_Frame)

# Add a new row
New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110))
# Print the new row
New_row_DF

# Add a new column
New_col_DF <- cbind(Data_Frame, Steps = c(1000, 6000, 2000))
# Print the new column
New_col_DF

# Remove the first row and column
Data_Frame_New <- Data_Frame[-c(1), -c(1)]
# Print the new data frame
Data_Frame_New


#find number of cols and rows
ncol(Data_Frame)
nrow(Data_Frame)

# combine 2 df's vertically rbind()
Data_Frame1 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame2 <- data.frame (
  Training = c("Stamina", "Stamina", "Strength"),
  Pulse = c(140, 150, 160),
  Duration = c(30, 30, 20)
)

New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
New_Data_Frame

# combine 2 df's horizontally cbind()
Data_Frame3 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame4 <- data.frame (
  Steps = c(3000, 6000, 2000),
  Calories = c(300, 400, 300)
)

New_Data_Frame1 <- cbind(Data_Frame3, Data_Frame4)
New_Data_Frame1


#########################
#          Fn
#########################
my_function <- function() {
  print("Hello World!")
}
my_function() # call the function named my_function


my_function <- function(fname) {
  paste(fname, "George")
}

my_function("Bob")

#########################
# Conditional Statements
#########################
a <- 33
b <- 200

if (b > a) {
  print("b is greater than a")
}

a <- 33
b <- 33

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print ("a and b are equal")
}

#########################
#     While Loops
#########################
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}


#break
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}


#########################
#     For Loops
#########################
for (x in 1:10) {
  print(x)
}

adj <- list("red", "big", "tasty")

fruits <- list("apple", "banana", "cherry")
for (x in adj) {
  for (y in fruits) {
    print(paste(x, y))
  }
}



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
str(dat) # structure of dataset
levels(iris$Species) # note $ refers to col

View(iris)
head(dat,25) # first 6 observations
library(dplyr)
glimpse()



