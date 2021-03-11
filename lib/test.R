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
