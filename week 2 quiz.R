install.packages("datasets")

library(datasets)
iris<- iris
mtcars 

data(iris)

v <- subset(iris,iris$Species=='virginica')

test1 <- apply(iris[, 1:4], 2, mean)

mean(mtcars[mtcars$cyl == "8",]$hp) - mean(mtcars[mtcars$cyl == "4",]$hp)