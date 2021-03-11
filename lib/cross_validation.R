########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv.function <- function(features, labels, K, l, reweight = FALSE){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  n <- dim(features)[1]
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)
  
  for (i in 1:K){
    ## create features and labels for train/test
    feature_train <- features[s != i,]
    feature_test <- features[s == i,]
    label_train <- labels[s != i]
    label_test <- labels[s == i]
    
    ## sample reweighting
    weight_train <- rep(NA, length(label_train))
    weight_test <- rep(NA, length(label_test))
    for (v in unique(labels)){
      weight_train[label_train == v] = 0.5 * length(label_train) / length(label_train[label_train == v])
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training
    if (reweight){
      model_train <- train(feature_train, label_train, w = weight_train, l)
    } else {
      model_train <- train(feature_train, label_train, w = NULL, l)
    }
    
    ## make predictions
    label_pred <- as.integer(test(model_train, feature_test, pred.type = 'class'))
    prob_pred <- test(model_train, feature_test, pred.type = 'response')
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}


### SVM

# linear kernel
svm.cv.linear <- function(training_data, cv){
  costs <- c(0.001, 0.01)
  svm_models <- rep(NA, length(costs))
  svm_auc <- rep(NA, length(costs))
  for(i in 1:length(costs)){
    curr_cost <- costs[i]
    curr_mod <- svm_linear_train(svm_training_data, curr_cost, 0)
    svm_pred <- svm_test(curr_mod, svm_training_data)
    tpr.fpr <- WeightedROC(as.numeric(svm_pred), svm_training_data$label)
    svm_auc[i] = WeightedAUC(tpr.fpr)
  }
  curr_best_index <- which.max(svm_auc)
  curr_best_cost <- costs[curr_best_index]
  return(curr_best_cost)
}
