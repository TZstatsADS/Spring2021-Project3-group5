###########################################################
### Train a classification model with training features ###
###########################################################

## starter code
train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

## Random Forest
## old features
if(!require("randomForest")){
  install.packages("randomForest")
}
library(randomForest)

old_random_forest_tune <- function(df){
  set.seed(2020)
  x = as.matrix(df[, -6007])
  y = factor(df[, 6007])
  return(
    tuneRF(x = x,
           y = y,
           ntreeTry = 1000,
           improve = 0.05,
           stepFactor = 2)
  )
}
old_random_forest_train <- function(df, mtry, tree_number, node_size){
  x = as.matrix(df[, -6007])
  y = df[, 6007]
  y = as.character(y)
  y = as.factor(y)
  set.seed(2020)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = tree_number,
                 sampsize = nrow(x),
                 nodesize = node_size
    )
  )
}

## new features
random_forest_tune <- function(df){
  set.seed(2020)
  x = as.matrix(df[, -6023])
  y = factor(df[, 6023])
  return(
    tuneRF(x = x,
           y = y,
           ntreeTry = 1500,
           improve = 0.05,
           stepFactor = 2)
  )
}
random_forest_train <- function(df, mtry, tree_number, node_size){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(2020)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = tree_number,
                 sampsize = nrow(x),
                 nodesize = node_size
    )
  )
}


## SVM

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
                    kernel = "radial",
                    ranges = list(gamma = seq(0.001, 0.1, 0.02), cost = seq(0.01, 0.1, 0.02)
                    ))
  return(best_cost)
}

svm_radial_train <- function(training_data, radial_cost, cv){
  svm.fit <- svm(label ~ ., data = training_data, kernel = "radial", 
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
    
    model<- gbm(label~. ,data = features,
                distribution = "multinomial", 
                n.trees = n,
                shrinkage = s,
                n.minobsinnode = 10, 
                cv.folds = K,
                verbose = TRUE)
  }
  
  
  return(model)
}

## Ridge
ridge_train <- function(train_data, alpha, K, lambda){
  
  ### Input: a data frame containing features and labels and a parameter list.
  ### Output:a trained model
  
  feature_train = as.matrix(dat_train_rebalanced[, -dim(dat_train_rebalanced)[2]])
  label_train = as.integer(dat_train_rebalanced$label) 
  
  library(glmnet)
  ridge_model <- cv.glmnet(x=feature_train, y=label_train, alpha=alpha, nfolds=K, lambda=lambda)
  
  return(ridge_model)
}

