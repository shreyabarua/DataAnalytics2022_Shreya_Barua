EPI_data <- read.csv("~/Downloads/Data Analytics/EPI_2010_data.csv")
View(EPI_data)
attach(EPI_data) # sets the default object
# fix(EPI_data) # launches a simple data editor
colnames(EPI_data) <- as.character(as.vector(EPI_data[1,])) # rename columns
View(EPI_data)
EPI_data <- EPI_data[-c(1), ] # remove first row
EPI_data[] <- lapply(EPI_data, function(x) type.convert(as.character(x)))
View(EPI_data)
EPI <- EPI_data$EPI # reassigns just the EPI column of the data to 'EPI'
EPI
class(EPI)
tf <- is.na(EPI) # records True values if the value is NA
E <- EPI[!tf] # filters out NA values, new array
summary(EPI) # shows stats of the EPI column
fivenum(EPI, na.rm=TRUE)
stem(EPI)
hist(EPI)
hist(EPI,seq(30.,95.,1.0),prob=TRUE)
lines(density(EPI,na.rm=TRUE,bw=1.))
rug(EPI)
plot(ecdf(EPI),do.points=FALSE,verticals=TRUE)
par(pty="s")
qqnorm(EPI)
qqline(EPI)
x <- seq(30,95,1)
qqplot(qt(ppoints(250),df=5),x,xlab="Q-Q plot for t dsn")
qqline(x)

DALY <- EPI_data$DALY
summary(DALY)

boxplot(EPI, DALY)
qqplot(EPI, DALY)

#conditional filtering
EPILand<-EPI[!EPI_data$Landlock]
ELand<-EPILand[!is.na(EPILand)]
hist(ELand)
hist(ELand,seq(30.,95.,1.0),prob=TRUE)
