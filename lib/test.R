###########################################################
### Make predictions with test features ###
###########################################################

test <- function(model, features, pred.type){
  res <- predict(model, newx = features, type = pred.type)
  return(res)
}

## Random Forest
## old features
old_random_forest_test <- function(model, testset){
  test.x = as.matrix(testset[ , -6007])
  set.seed(2020)
  return(
    predict(model, test.x)
  )
}

## new features
random_forest_test <- function(model, testset){
  test.x = as.matrix(testset[ , -6023])
  set.seed(2020)
  return(
    predict(model, test.x)
  )
}


## SVM
svm_test = function(svm_model, testing_data, presentation.day=TRUE){
  if(!presentation.day) {
    pred_svm = predict(object = svm_model, newdata = testing_data[-ncol(testing_data)])
  } else {
    pred_svm = predict(object = svm_model, newdata = testing_data)
  }
  return(pred_svm)
}


## GBM
test_gbm <- function(model, input.test, n, pred.type){
  
  res <- predict(model,
                newdata = input.test,
                n.trees = n,
                type = pred.type)
  
  return(res)
}

## Ridge
ridge_test <- function(model, features, pred.type){
  
  ### Input: the fitted classification model using training data and processed features from testing images 
  ### Output: model predictions
  
  library(prediction)
  pred = predict(model, s=opt_lambda, newx=features, type=pred.type)
  
  return (pred)
}
