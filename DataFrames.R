# Creating a dataframe
# Example: RPI Weather dataframe

days <- c('Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun') # c is a concatenation function
temp <- c(28,30.5,32,31.2,29.3,27.9,26.4)
snowed <- c('T','T','F','F','T','T','F') # Snowed on that day: True or False
help("data.frame")
RPI_Weather_Week <- data.frame(days,temp,snowed) # creates a dataframe
RPI_Weather_Week
head(RPI_Weather_Week) # head of the data frame - first 6 rows
str(RPI_Weather_Week) # structure function
summary(RPI_Weather_Week)
RPI_Weather_Week[1,] # showing the 1st row and all the columns
RPI_Weather_Week[,1] # showing the 1st column and all the rows
RPI_Weather_Week[,'snowed']
RPI_Weather_Week[,'days']
RPI_Weather_Week[,'temp']
RPI_Weather_Week[1:5,c("days","temp")]
RPI_Weather_Week$temp
subset(RPI_Weather_Week,subset=snowed==TRUE)

sorted.snowed <- order(RPI_Weather_Week['snowed'])
sorted.snowed
RPI_Weather_Week[sorted.snowed,]

dec.snow <- order(-RPI_Weather_Week$temp)
dec.snow

empty.DataFrame <- data.frame()
v1 <- 1:10
v1
letters
v2 <- letters[1:10]
v2
df <- data.frame(col.name.1=v1,col.name.2=v2)
df
write.csv(df,file='saved_df1.csv')
df2 <- read.csv('saved_df1.csv')
df2

