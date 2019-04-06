#statistical interferance week 4 project#

#In this project you will investigate the exponential distribution in R and compare it with the Central Limit Theorem. 
#The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. 
#The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations. 
#You will investigate the distribution of averages of 40 exponentials. Note that you will need to do a thousand simulations.

#Illustrate via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials. 

#Question 1
#Show the sample mean and compare it to the theoretical mean of the distribution.

lambda <- 0.2
Data <- matrix(rexp(1000*40, lambda), nrow = 1000, ncol = 40)
distMean <- apply(Data, 1, mean)
hist(distMean, breaks = 50, main = "The distribution of 1000 averages of 40 random exponentials", 
      xlab = "Value of means", ylab = "Frequency of means", col = "pink")
abline(v = 1/lambda, lty = 1, lwd = 5, col = "yellow")
legend("topright", lty = 1, lwd = 5, col = "yellow", legend = "theoretical mean")

#the below is the mean for all the sumulations one at a time #
simMean <- rowMeans(Data)

#the below is the mean for the data, in this case 4.9632
simMeanMean <- mean(simMean)
#the theatrical mean is 1/lambda i.e 1/0.2, in this case 5
theatricalmean <- 1/0.2
#both the sample mean and the theatrical mean are similar

#Question 2
#Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
simulationvar <- var(simMean)
theatricalvar <- (1/lambda)^2/(40) 
#simulation variance is 0.61, theatrical variance is 0.62 and hence they are close

#question 3
#Question 3: Show that the distribution is approximately normal
hist(distMean, breaks = 50, main = "The distribution of 1000 averages of 40 random exponentials", xlab = "Value of means", ylab = "Frequency of means", col = "pink")
#the output graph looks close to a normal distribution.

#Part 2: Basic Inferential Data Analysis Instructions
#1. Load the ToothGrowth data and perform some basic exploratory data analyses.
library(stats)
data(ToothGrowth)
library(ggplot2)

summary(ToothGrowth)
dim(ToothGrowth)

qplot(dose, len, data = ToothGrowth, color = supp, geom = "point") +  
  geom_smooth(method = "lm") + labs(title = "ToothGrowth") + 
  labs(x = "Dose of supplements", y = "Length of teeth")

#the plot shows :
#length of teeth increases the most with OJ supplement, dose 2.0
#at 2.0 dose both supplements are close

# 2.Provide a basic summary of the data
summary(ToothGrowth)

#3.Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose.
#(Only use the techniques from class, even if there's other approaches worth considering)

#By supplement
#H0 : There is no difference between the two supplements for tooth growth
#H1 : There is a difference between the two supplements for tooth growh

#assume that the data is normally distributed
t.test(x = ToothGrowth$len, data = ToothGrowth, paired = FALSE, conf.level = 0.95)$conf.
#the 95% confidence interval is 16.83731 - 20.78936.
# this follows that 95% of the time, an interval between 16.84 and 20.79 will contain the true mean of the population.#

#OJ mean is 20.66
summary(ToothGrowth[ToothGrowth$supp == "OJ", ]$len)[4] 
#VC mean is 16.96
summary(ToothGrowth[ToothGrowth$supp == "VC", ]$len)[4] 

#as both are within the 95% confidence interval, we do not have enough evidence to reject the null hypothesis

#by dose
#H0 : There is no difference between the three doses for tooth growth
#h1 : Thiere is a difference between the three doses for tooth growth

#mean for 0.5 dose = 10.6
summary(ToothGrowth[ToothGrowth$dose == 0.5, ]$len)[4]
#mean for 1.0 dose = 19.74
summary(ToothGrowth[ToothGrowth$dose == 1.0, ]$len)[4]
#mean for 2.0 dose = 26.1
summary(ToothGrowth[ToothGrowth$dose == 2.0, ]$len)[4]

#as the mean's are not all within the 95% confidence interval, we are able to reject the null hyotheses

#Question 4: State your conclusions and the assumptions needed for your conclusions.
#The conclusion is when the dose is 0.5 or 1.0 there is a difference between the teeth growth after taking OJ and VC,
#while when the dose is 2.0, there is no difference between the teeth growth after taking OJ and VC. 
#The assumption needed is we first assumed the whole population is normally distributed



