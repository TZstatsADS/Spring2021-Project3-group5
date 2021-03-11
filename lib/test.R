###########################################################
### Make predictions with test features ###
###########################################################

test <- function(model, features, pred.type){
  res <- predict(model, newx = features, type = pred.type)
  return(res)
}

## SVM
svm_test = function(svm_model, testing_data){
  pred_svm = predict(object = svm_model, newdata = testing_data)
  return(pred_svm)
}
# This function is not necessary.
# We put it here just to show the structure.

test_gbm <- function(model, input.test, n, pred.type){
  
  res <- predict(model,
                newdata = input.test,
                n.trees = n,
                type = pred.type)
  
  return(res)
}
