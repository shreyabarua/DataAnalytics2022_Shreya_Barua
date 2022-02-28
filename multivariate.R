multivariate <- read.csv("~/Downloads/multivariate.csv")
View(multivariate)
attach(multivariate)
mm <- lm(Homeowners~Immigrant)
mm
names(multivariate)

plot(Income,Immigrant, main="Scatterplot")
plot(Immigrant,Homeowners)

help(lm)
abline(mm)
abline(mm,col=2,lwd=3)
summary(mm)
attributes(mm)
mm$coefficients
