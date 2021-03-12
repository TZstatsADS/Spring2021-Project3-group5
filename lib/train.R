###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

## SVM
# svm_default_train = function(training_data, cv){
#   svm.fit <- svm(label ~ ., data = training_data, type = "C-classification", cross = cv)
#   return(svm.fit)
# }

svm_linear_cost_tune <- function(training_data){
  best_cost <- tune(method = svm,
                    train.x = as.matrix(training_data[,-ncol(training_data)]),
                    train.y = factor(training_data$label),
                    kernel = "linear",
                    ranges = list(cost = seq(0.01, 0.1, 0.02)
                    ))
  return(best_cost)
}

svm_linear_train = function(training_data, linear_cost, cv){
  svm.fit <- svm(label ~ ., data = training_data, kernel = "linear", 
                 cost = linear_cost, 
                 cross = cv, 
                 type = "C-classification")
  return(svm.fit)
}

svm_radial_cost_tune <- function(training_data){
  best_cost <- tune(method = svm,
                    train.x = as.matrix(training_data[,-ncol(training_data)]),
                    train.y = factor(training_data$label),
                    kernel = "linear",
                    ranges = list(gamma = seq(0.001, 0.1, 0.02), cost = seq(0.01, 0.1, 0.02)
                    ))
  return(best_cost)
}

svm_radial_train <- function(training_data, radial_gamma, radial_cost, cv){
  svm.fit <- svm(label ~ ., data = training_data, kernel = "radial", 
                 gamma = radial_gamma,
                 cost = radial_cost, 
                 cross = cv, 
                 type = "C-classification")
  return(svm.fit)
}

## GBM
train_gbm <- function(features, s, K = 5, n=100, w = NULL){
  
  if (!is.null(w)){
    model<- gbm(label~. ,data = features,
                distribution = "multinomial", 
                n.trees = n,
                shrinkage = s,
                n.minobsinnode = 10, 
                cv.folds = K,
                weights = w,
                verbose = TRUE)
    
  } else {
    features$label <- as.factor(features$label)
    trainSplit <- SMOTE(label ~ ., features, perc.over = 100, perc.under=200)
    
    model<- gbm(label~. ,data = trainSplit,
                distribution = "multinomial", 
                n.trees = n,
                shrinkage = s,
                n.minobsinnode = 10, 
                cv.folds = K,
                verbose = TRUE)
  }
  
  
  return(model)
}
