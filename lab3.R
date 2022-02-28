# creating a matrix data with random numbers
# and plotting the matrix using the image() function
# you will see there, it does not have a real pattern in the plot
set.seed(12345)
help(par)
# par can be used to set or query graphical parameters
# Parameters can be set by specifying them as arguments
# to par in tag = value form, or by passing them as list of tagged values
par(mar = rep(0.2,4))
data_Matrix<- matrix(rnorm(400),nrow=40)
data_Matrix
image(1:10, 1:40, t(data_Matrix)[,nrow(data_Matrix):1])
help(rep)
help("heatmap")
heatmap(data_Matrix) # doesn't show any real interesting pattern

# Now we will add a pattern to the data by doing a random coin flip
# use the rbinom() function along with a for-loop
help("rbinom")
set.seed(678910)
for(i in 1:40){
  # flipping a coin and getting the data
  coin_flip <- rbinom(1, size=1, prob=0.5)
  # if the coin is "Heads", add a common pattern to that row
  if(coin_flip){
    data_Matrix[1,] <- data_Matrix[i,]+rep(c(0,3),each=5)
  }
}

par(mar = rep(0.2,4))
image(1:10, 1:40, t(data_Matrix)[,nrow(data_Matrix):1])
heatmap(data_Matrix)

hh <- hclust(dist(data_Matrix))
data_Matrix_Ordered <- data_Matrix[hh$order,]
par(mfrow=c(1,3))
image(t(data_Matrix_Ordered)[, nrow(data_Matrix_Ordered):1])

