###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

## SVM
svm_default_train = function(training_data, cv){
  svm.fit <- svm(label ~ ., data = training_data, cross = cv)
  return(svm.fit)
}

svm_linear_train = function(training_data, linear_cost, cv){
  svm.fit <- svm(label ~ ., data = training_data, kernel = "linear", cross = cv, cost = linear_cost)
  return(svm.fit)
}
