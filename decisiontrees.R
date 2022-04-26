library(randomForest)

gender_ratio_parliament <- read.csv("~/Downloads/SYB64_317_202110_Seats held by women in Parliament.csv")
colnames(gender_ratio_parliament) <- as.character(as.vector(gender_ratio_parliament[1,])) # rename columns
gender_ratio_parliament <- gender_ratio_parliament[-c(1), ] # remove first row
gender_ratio_parliament = subset(gender_ratio_parliament, select = -c(Footnotes,Source))
gender_ratio_parliament = subset(gender_ratio_parliament, select = -c(Series))
names(gender_ratio_parliament)[names(gender_ratio_parliament) == "Value"] <- "% Seats held by women in parliament"
names(gender_ratio_parliament)[names(gender_ratio_parliament) == ""] <- "Country.Name"
View(gender_ratio_parliament)


# random forest
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
# *** maybe also merge this dataset with parliament ratio and see if that is an important variable ***
varImpPlot(model2)
# ntree = 700, mtry = 5
model3 <- randomForest(classbracket~., data=TrainSet, ntree = 800, mtry = 5, importance = TRUE)
model3

help("randomForest")


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
# *** maybe also merge this dataset with parliament ratio and see if that is an important variable ***
varImpPlot(model2)
# ntree = 700, mtry = 5
model3 <- randomForest(classbracket~., data=TrainSet, ntree = 800, mtry = 5, importance = TRUE)
model3

