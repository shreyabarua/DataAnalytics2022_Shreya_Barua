library(ggplot2)
head(iris)
str(iris)
summary(iris)
help("sapply")
sapply(iris[-5],var)
summary(iris)
# plot Sepal.length vs sepal.width using ggplot
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species))+geom_point()
# plot Petal.Length vs Petal.Width using ggplot
ggplot(iris,aes(x=Petal.Length,y=Petal.Width,col=Species))+geom_point()

#kmeans clustering
set.seed(300)
k.max<-12
wss<- sapply(1:k.max,function(k){kmeans(iris[,3:4],k,nstart = 20,iter.max = 20)$tot.withinss})
wss
plot(1:k.max,wss, type= "b", xlab = "Number of clusters(k)", ylab = "Within cluster sum of squares")
icluster <- kmeans(iris[,3:4],3,nstart = 20)
table(icluster$cluster,iris$Species)
