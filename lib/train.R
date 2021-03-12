###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

## SVM
svm_default_train = function(training_data, cv){
  svm.fit <- svm(label ~ ., data = training_data, type = "C-classification", cross = cv)
  return(svm.fit)
}


# svm_cost_tune <- function(training_data, cv){
#   costs <- seq(0.01, 0.1, 0.02)
#   svm_models <- rep(NA, length(costs))
#   svm_auc <- rep(NA, length(costs))
#   for(i in 1:length(costs)){
#     curr_cost <- costs[1]
#     curr_mod <- svm_linear_train(training_data, curr_cost, cv)
#     svm_pred <- svm_test(curr_mod, training_data, TRUE)
#     tpr.fpr <- WeightedROC(as.numeric(svm_pred), training_data$label)
#     svm_auc[i] = WeightedAUC(tpr.fpr)
#   }
#   curr_best_index <- which.max(svm_auc)
#   curr_best_cost <- costs[curr_best_index]
#   return(curr_best_cost)
# }

svm_cost_tune <- function(training_data){
  best_cost <- tune(method = svm,
                    train.x = as.matrix(training_data[,-ncol(training_data)]),
                    train.y = factor(training_data$label),
                    kernel = "linear",
                    ranges = list(cost = seq(0.01, 0.1, 0.02)
                    ))
  return(best_cost)
}

svm_linear_train = function(training_data, linear_cost, cv){
  svm.fit <- svm(label ~ ., data = training_data, kernel = "linear", cross = cv, cost = linear_cost)
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
