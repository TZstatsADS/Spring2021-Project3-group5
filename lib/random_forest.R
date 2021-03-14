if(!require("randomForest")){
  install.packages("randomForest")
}
library(randomForest)
random_forest_tune <- function(df){
  set.seed(0)
  x = as.matrix(df[, -6023])
  y = factor(df[, 6023])
  return(
    tuneRF(x = x,
           y = y,
           ntreeTry = 1000,
           improve = 0.05,
           stepFactor = 2)
  )
}
random_forest_train <- function(df, mtry, tree_number, node_size){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
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
random_forest_test <- function(model, testset){
  test.x = as.matrix(testset[ , -6023])
  set.seed(0)
  return(
    predict(model, test.x)
  )
}

#################### Tune Random Forest ###########################

### Test different tree size
random_forest_train_500 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 500,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

random_forest_train_1000 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

random_forest_train_1500 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1500,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

random_forest_train_2000 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 2000,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

random_forest_train_2500 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 2500,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

### Tune Node Size
random_forest_train_30 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 30
    )
  )
}

random_forest_train_10 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 10
    )
  )
}

random_forest_train_15 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 15
    )
  )
}

random_forest_train_20 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 20
    )
  )
}

random_forest_train_25 <- function(df, mtry){
  x = as.matrix(df[, -6023])
  y = df[, 6023]
  y = as.character(y)
  y = as.factor(y)
  set.seed(0)
  return(
    randomForest(x = x,
                 y = y,
                 mtry = mtry,
                 ntree = 1000,
                 sampsize = nrow(x),
                 nodesize = 25
    )
  )
}

