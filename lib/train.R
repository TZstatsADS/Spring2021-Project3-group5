###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

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