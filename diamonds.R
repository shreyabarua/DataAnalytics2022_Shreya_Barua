install.packages("ggplot2")
install.packages("dplyr")
install.packages("magrittr")
library(ggplot2)
library(dplyr)
library(magrittr)
ggplot(data=diamonds) + geom_histogram(mapping = aes(x=carat),binwidth=0.5) # shows a histogram of carat vs count
diamonds %>% count(cut_width(carat,0.5))
View(diamonds)
smaller <- diamonds %>% filter(carat < 3) 
ggplot(data = smaller, mapping = aes(x = carat)) + geom_histogram(binwidth = 0.1)
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) + geom_freqpoly(binwidth = 0.1) # uses lines instead of bars

