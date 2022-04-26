# Project Title: Women and Economic Growth
# Hypothesis: Higher expenditure on education (with more women in parliament) 
# leads to higher overall GDP of a country since this means more women are educated

# Compare Public expenditure on education (% of GDP) to GDP per capita of 
# a country and see if there is a correlation
# See if there is correlation with how many women have seats in the
# national parliament and public expenditure on education

# for decision tree, make a column that groups countries into "High/Mid/Low income/gdp"
# gdp data from world bank


# Ratio of girls to boys in primary, secondary and tertiary levels

# cluster analysis (kmeans, means shift)
# cluster of gdp
# higher gdp per capita = more women in parliament

# monday: look for 3 - 5 research papers GDP and women
# https://www.diva-portal.org/smash/get/diva2:756239/FULLTEXT01.pdf
# https://www.tandfonline.com/doi/abs/10.1080/13504851.2012.697113
# https://ams-forschungsnetzwerk.at/downloadpub/2009_12_Gender_Equality_study.pdf

# k means gdp per capita vs nation
library(cluster)

# 2020 GDP
world_bank <- read.csv("~/Downloads/worldbank.csv")

world_bank <- na.omit(world_bank)
View(world_bank)
df <- subset (world_bank, select = -c(X1960:X2019))

df <- na.omit(df)
View(df)
world_bank <- df[df$X2020 < 2.5e+13,]
View(world_bank)

# 2015 GDP
world_bank <- read.csv("~/Downloads/worldbank.csv")
df <- subset(world_bank, select = -c(X1960:X2014, X2016:X2020))
df <- na.omit(df)
View(df)
world_bank_2015 <- df[df$X2015 < 2.5e+13,]
View(world_bank_2015)

# 2010 GDP
world_bank <- read.csv("~/Downloads/worldbank.csv")
df <- subset(world_bank, select = -c(X1960:X2009, X2011:X2020))
df <- na.omit(df)
View(df)
world_bank_2010 <- df[df$X2010 < 2.5e+13,]
View(world_bank_2010)

# this is overall, maybe repeat to show linear regression over time intervals...
# seats held by women in national parliament

gender_ratio_parliament <- read.csv("~/Downloads/SYB64_317_202110_Seats held by women in Parliament.csv")
View(gender_ratio_parliament)
colnames(gender_ratio_parliament) <- as.character(as.vector(gender_ratio_parliament[1,])) # rename columns
gender_ratio_parliament <- gender_ratio_parliament[-c(1), ] # remove first row
View(gender_ratio_parliament)
gender_ratio_parliament = subset(gender_ratio_parliament, select = -c(Footnotes,Source))
gender_ratio_parliament = subset(gender_ratio_parliament, select = -c(Series))
names(gender_ratio_parliament)[names(gender_ratio_parliament) == "Value"] <- "% Seats held by women in parliament"
names(gender_ratio_parliament)[names(gender_ratio_parliament) == ""] <- "Country.Name"
View(gender_ratio_parliament)

# 2010
new <- merge(world_bank,gender_ratio_parliament,by=c("Country.Name"), all=TRUE)
new <- na.omit(new)
View (new)
mm <- lm(new$X2010~new$`% Seats held by women in parliament`)
mm
plot(new$X2010~new$`% Seats held by women in parliament`, xlab = "% seats held by women in parliament in 2010", ylab = "GDP in 2010")
abline(mm)

# 2015
new <- merge(world_bank_2015,gender_ratio_parliament,by=c("Country.Name"), all=TRUE)
new <- na.omit(new)
View (new)
mm <- lm(new$X2015~new$`% Seats held by women in parliament`)
mm
plot(new$X2015~new$`% Seats held by women in parliament`, xlab = "% seats held by women in parliament in 2015", ylab = "GDP in 2015")
abline(mm)


help(abline)
# EDA
# maybe make a new column that groups countries in low middle or high income
# show a bar chart of how many of each
world_bank <- read.csv("~/Downloads/worldbank.csv")
world_bank <- na.omit(world_bank)
world_bank2 <- subset (world_bank, select = -c(X1960:X2019))

world_bank2$income.bracket<-cut(world_bank2$X2020,br=c(-1,4.597299e+11,7.384772e+12,2.315067e+13,3.053534e+13,5.346108e+13), labels=c("low income","lower middle income","middle income","upper middle income","high income"))

View(world_bank2)
world_bank3 <- na.omit(world_bank2)
View(world_bank3)
library(ggplot2)
ggplot(data = world_bank3) + geom_bar(mapping = aes(x = income.bracket)) + labs(x="income bracket")
View(world_bank3)
ggplot(data = world_bank3, mapping = aes(x = X2020, color = income.bracket)) + geom_freqpoly(binwidth = 5000000000000) + labs(x = "GDP (USD)", color="Income Bracket")

# or a histogram of % of women in parliament
str(gender_ratio_parliament)
gender_ratio_parliament$`% Seats held by women in parliament` <- as.numeric(gender_ratio_parliament$`% Seats held by women in parliament`)
ggplot(data = gender_ratio_parliament) + geom_histogram(mapping = aes(x = gender_ratio_parliament$`% Seats held by women in parliament`), binwidth = 0.5) + labs(x = "% seats held by women in parliament")

# histogram of ratio of girls to boys in school
school_gender_ratio <- read.csv("~/Downloads/SYB64_319_202110_Ratio of girls to boys in education.csv")

colnames(school_gender_ratio) <- as.character(as.vector(school_gender_ratio[1,])) # rename columns
school_gender_ratio <- school_gender_ratio[-c(1), ] # remove first row
View(school_gender_ratio)
str(school_gender_ratio)
school_gender_ratio$Value <- as.numeric(school_gender_ratio$Value)
ggplot(data = school_gender_ratio) + geom_histogram(mapping = aes(x = school_gender_ratio$Value), binwidth = 0.1) + labs(x = "ratio of girls to boys in education")

# ratio in primary education
primary_ratio <- school_gender_ratio[school_gender_ratio$Series == 'Ratio of girls to boys in primary education',]
ggplot(data = primary_ratio) + geom_histogram(mapping = aes(x = primary_ratio$Value), binwidth = 0.1) + labs(x = "ratio of girls to boys in primary education")
View(primary_ratio)
secondary_ratio <- school_gender_ratio[school_gender_ratio$Series == 'Ratio of girls to boys in secondary education',]
ggplot(data = secondary_ratio) + geom_histogram(mapping = aes(x = secondary_ratio$Value), binwidth = 0.1) + labs(x = "ratio of girls to boys in secondary education")
View(secondary_ratio)
tertiary_ratio <- school_gender_ratio[school_gender_ratio$Series == 'Ratio of girls to boys in tertiary education',]
ggplot(data = tertiary_ratio) + geom_histogram(mapping = aes(x = tertiary_ratio$Value), binwidth = 0.1) + labs(x = "ratio of girls to boys in tertiary education")
View(tertiary_ratio)

# cross the ratio data with the low income country data
View(world_bank2)
names(tertiary_ratio)[names(tertiary_ratio) == ""] <- "Country.Name"
income_ratio <- merge(world_bank2,tertiary_ratio,by=c("Country.Name"))
low_income_ratio <- income_ratio[income_ratio$income.bracket == 'low income',]
low_income_ratio_2019 <- low_income_ratio[low_income_ratio$Year == '2019',]

View(low_income_ratio)

ggplot(data = low_income_ratio_2019) + geom_histogram(mapping = aes(x = low_income_ratio_2019$Value), binwidth = 0.05) + labs(x = "ratio of girls to boys in tertiary education in low income countries")

# primary low income
names(primary_ratio)[names(primary_ratio) == ""] <- "Country.Name"
income_ratio <- merge(world_bank2,primary_ratio,by=c("Country.Name"))
low_income_ratio <- income_ratio[income_ratio$income.bracket == 'low income',]
low_income_ratio_2019 <- low_income_ratio[low_income_ratio$Year == '2019',]
View(low_income_ratio_2019)

ggplot(data = low_income_ratio_2019) + geom_histogram(mapping = aes(x = low_income_ratio_2019$Value), binwidth = 0.02) + labs(x = "ratio of girls to boys in primary education in low income countries")

library(randomForest)


# Random Forest

world_bank <- read.csv("~/Downloads/worldbank.csv")
world_bank <- na.omit(world_bank)
world_bank2 <- subset (world_bank, select = -c(X1960:X2019))

world_bank2$classbracket<-cut(world_bank2$X2020,br=c(-1,4.597299e+11,7.384772e+12,2.315067e+13,3.053534e+13,5.346108e+13), labels=c("low income","lower middle income","middle income","upper middle income","high income"))

wb <- na.omit(world_bank2)
View(wb)

set.seed(100)
# randomly choose 70% of the datat points for training and 30% for validation
train <- sample(nrow(wb), 0.7*nrow(wb), replace = FALSE)
# create training and validations datasets
TrainSet <- wb[train,]
ValidSet <- wb[-train,]
summary(TrainSet)
summary(ValidSet)

# ntree = 500, mtry = 2
model1 <- randomForest(classbracket~., data=TrainSet, importance = TRUE)
model1

# fine tuning the parameters of the randomforest model
# increase mtry from 2 to 4, increase # of trees
# mtry = number of variables randomly sampled as candidates at each split
# ntree = 600, mtry = 4
model2 <- randomForest(classbracket~., data=TrainSet, ntree = 600, mtry = 4, importance = TRUE)
model2

# conduct prediction using training set
predTrain <-predict(model1, TrainSet, type = "class")
# use table() to check the classification accuracy 
table(predTrain, TrainSet$classbracket)

# predict using the validation set
predValid <- predict(model1, ValidSet, type = "class")
# use table() to check the classification accuracy 
table(predValid, ValidSet$classbracket)

importance(model2)

varImpPlot(model2)
# ntree = 700, mtry = 5
model3 <- randomForest(classbracket~., data=TrainSet, ntree = 800, mtry = 5, importance = TRUE)
model3

# Trying to merge wb dataset with parliament ratio and see if % women in parliament is an important variable

total <- merge(wb, gender_ratio_parliament, by=c("Country.Name"))
View(total)

total <- total[-c(4, 9:10)]
total <- na.omit(total)

View(total)
set.seed(100)
# randomly choose 70% of the datat points for training and 30% for validation
train <- sample(nrow(total), 0.7*nrow(total), replace = FALSE)
train
# create training and validations datasets
TrainSet <- total[train,]
TrainSet
ValidSet <- total[-train,]
summary(TrainSet)
summary(ValidSet)


# ntree = 500, mtry = 2

# this line does not work :(
model1 <- randomForest(classbracket~., data=TrainSet, importance = TRUE)

