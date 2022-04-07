# PCA on USArrests dataset
data("USArrests")
help("USArrests")
states = row.names(USArrests)
states

# the columns of the data set contain the four variables
names(USArrests)

# apply() allows us to apply a function (mean) to each row or column of the data set
apply(USArrests, 2, mean)

# there are 3 times as many rapes as murders
# more than 8 times as many assaults than rapes

# examine the variances of the four variables
apply(USArrests, 2, var)

# prcomp() function performs PCA
# scale = TRUE makes standard deviation 1 instead of 0
pr.out <- prcomp(USArrests, scale=TRUE)
names(pr.out)
pr.out

pr.out$center # means of the variables used for scaling prior to PCA
pr.out$scale # standard deviations '      '

# each column of the rotation contains the corresponding principal component loading vector
pr.out$rotation

# this 50x4 matrix 'x' has the principal component score vectors as its columns
# kth column is the kth principal component score vector
dim(pr.out$x)
pr.out$x

# plot the first two principal components
biplot(pr.out, scale=0)

pr.var = pr.out$sdev^2
pr.var

pve = pr.var/sum(pr.var)
pve