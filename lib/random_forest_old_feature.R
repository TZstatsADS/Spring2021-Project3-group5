if(!require("randomForest")){
  install.packages("randomForest")
}
library(randomForest)
random_forest_tune <- function(df){
  set.seed(2020)
  x = as.matrix(df[, -6007])
  y = factor(df[, 6007])
  return(
    tuneRF(x = x,
           y = y,
           ntreeTry = 2000,
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
old_random_forest_test <- function(model, testset){
  test.x = as.matrix(testset[ , -6007])
  set.seed(2020)
  return(
    predict(model, test.x)
  )
}