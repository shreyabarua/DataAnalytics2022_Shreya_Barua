# Cook's Distance example using mtcars
mtcars
head(mtcars)
str(mtcars)
model1 <- lm(mpg ~ cyl + wt, data = mtcars)
model1
help("cooks.distance")
plot(model1, pch=18, col='red', which=c(4))

# we can use the cooks.distance() function to identify the Cook's distance to
# each observation
cooks.distance(model1)
CooksDistance <- cooks.distance(model1)

# round to 5 decimal points and sort in ascending order
sort(round(CooksDistance, 5))

# Outlier Detection using "Cooks Distance"
# Multivariate Regression using Cook's Distance
# Cook's Distance is an estimate of the influence of a data point
# Cook's Distance is a summary of how much a regression model changes when the ith
# observation is removed from the data
library(ISLR)
library(dplyr)
# Let's look at the baseball hitters dataset in ISLR package
head(Hitters)
dim(Hitters)
is.na(Hitters) # check for the missing values
# Now remove the NA (missing values) using na.omit()
HittersData <- na.omit(Hitters)
dim(HittersData) # checking the dimensions afrer removing the NAs
glimpse(HittersData)
head(HittersData)
# Now we will implement a multivariate regression model using all the features
# in the dataset to predict the salart of the Baseball player
SalaryPredictModel1 <- lm(Salary ~., data= HittersData)
summary(SalaryPredictModel1)

cooksD <- cooks.distance(SalaryPredictModel1)
influential <- cooksD[(cooksD > (3*mean(cooksD, na.rm = TRUE)))]
influential
# 18 players have a Cook's Distance greater than 3x the mean
# exclude the 18 players and re run the model to see if we have a better fit in
# our regression mofel
names_of_influential <- names(influential)
names_of_influential
outliers <- HittersData[names_of_influential,]
Hitters_Without_Outliers