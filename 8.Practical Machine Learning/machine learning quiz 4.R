install.packages("caret")



#question 1

library("caret")
install.packages("ElemStatLearn")
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

#Set the variable y to be a factor variable in both the training and test set. 
#Then set the seed to 33833. Fit (1) a random forest predictor relating the factor variable y to the remaining variables 
#and (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package.

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
mod_rf <- train(y ~ ., data = vowel.train, method = "rf")
mod_gbm <- train(y ~ ., data = vowel.train, method = "gbm")
pred_rf <- predict(mod_rf, vowel.test)
pred_gbm <- predict(mod_gbm, vowel.test)

# Extract accuracies for (1) random forests and (2) boosting
confusionMatrix(pred_rf, vowel.test$y)$overall[1]
confusionMatrix(pred_gbm, vowel.test$y)$overall[1]

predDF <- data.frame(pred_rf, pred_gbm, y = vowel.test$y)
# Accuracy among the test set samples where the two methods agree
sum(pred_rf[predDF$pred_rf == predDF$pred_gbm] == 
      predDF$y[predDF$pred_rf == predDF$pred_gbm]) / 
  sum(predDF$pred_rf == predDF$pred_gbm)

#question 2
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

#Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"),
#boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions together using random forests ("rf"). 
#What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?

set.seed(62433)
modelFit_rf<-train(diagnosis~., method="rf", data=training)
modelFit_gbm<-train(diagnosis~., method="gbm", data=training,verbose=FALSE)
modelFit_lda<-train(diagnosis~., method="lda", data=training)

predict_rf<-predict(modelFit_rf,newdata=testing)
predict_gbm<-predict(modelFit_gbm,newdata=testing)
predict_lda<-predict(modelFit_lda,newdata=testing)
confusionMatrix(predict_rf, testing$diagnosis)$overall['Accuracy']
#overall 0.7682927 accuracy

confusionMatrix(predict_gbm, testing$diagnosis)$overall['Accuracy']
#GBM - 0.8170732

confusionMatrix(predict_lda, testing$diagnosis)$overall['Accuracy']
#LDA Accuracy - 0.7682927

#create a new dataframe with the predictions
predDF <- data.frame(predict_rf, predict_gbm, predict_lda, diagnosis = testing$diagnosis)
#create a new model using the new data frame and rf method
combModFit <- train(diagnosis ~.,method="rf",data=predDF)
combPred <- predict(combModFit, predDF)
confusionMatrix(combPred, testing$diagnosis)$overall['Accuracy']
#combined 0.81707

#Question 3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

#Set the seed to 233 and fit a lasso model to predict Compressive Strength. 
#Which variable is the last coefficient to be set to zero as the penalty increases? (Hint: it may be useful to look up ?plot.enet).
install.packages("elasticnet")

library(elasticnet)
set.seed(233)
modFit<-train(CompressiveStrength ~ ., method="lasso", data=training)
plot.enet(modFit$finalModel, xvar = "penalty", use.color = TRUE)







