EPI_data <- read.csv("~/Downloads/Data Analytics/EPI_2010_data.csv")
View(EPI_data)
attach(EPI_data) # sets the default object
fix(EPI_data) # launches a simple data editor
colnames(EPI_data) <- as.character(as.vector(EPI_data[1,]))
View(EPI_data)
EPI <- EPI_data$EPI
EPI
tf <- is.na(EPI) # records True values if the value is NA
E <- EPI[!tf] # filters out NA values, new array

# I am having trouble running anything after line 4 of this code
# it was working for me in class but is not working now