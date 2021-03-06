#############################################################
### Construct features and responses for training images  ###
#############################################################

feature <- function(input_list = fiducial_pt_list, index, usepoly = FALSE){
  
  ### Construct process features for training images 
  
  ### Input: a list of images or fiducial points; index: train index or test index
  
  ### Output: a data frame containing: features and a column of label
  
  ### here is an example of extracting pairwise distances between fiducial points
  ### Step 1: Write a function pairwise_dist to calculate pairwise distance of items in a vector
  pairwise_dist <- function(vec){
    ### input: a vector(length n), output: a vector containing pairwise distances(length n(n-1)/2)
    return(as.vector(dist(vec)))
  }
  
  ### Step 2: Write a function pairwise_dist_result to apply function in Step 1 to column of a matrix 
  pairwise_dist_result <-function(mat){
    ### input: a n*2 matrix(e.g. fiducial_pt_list[[1]]), output: a vector(length n(n-1))
    return(as.vector(apply(mat, 2, pairwise_dist))) 
  }
  
  ### we might want to use poly features
  poly_curve <- function(mat){
    Returnlist <- list() #List containg features
    AllPoints <- list() # List of lists to store points
    k <- 16 # number of interpolating lines
    
    #save points that will be used to interpolate a polynomial
    
    #faceoutline <-c(64,65,66,67,68,69,70,71,72,73,74,75,76,77,78)
    left_top_eyebrow<-c(19,20,21,22,23)
    left_bottom_eyebrow<-c(19,26,25,24,23)
    right_top_eyebrow<-c(27,28,29,30,31)
    right_bottom_eyebrow<-c(27,34,33,32,31)
    right_eye_top_eyelid<-c(11,12,13,14,15)
    right_eye_bottom_eyelid<-c(11,18,17,16,15)
    left_eye_top_eyelid<-c(2,3,4,5)
    left_eye_bottom_eyelid<-c(2,9,8,7,6)
    top_lip_top<-c(50,51,52,53,54)
    top_lip_bottom<-c(50,58,59,60,54)
    bottom_lip_top<-c(50,63,62,61,54)
    Bottom_lip_bottom<-c(50,57,56,55,54)
    top_brow<-c(39,35,49)
    low_brow<-c(40,36,48)
    top_nose<-c(41,37,47)
    low_nose<-c(42,43,44,45,46)
    
    #AllPoints[[1]]<-faceoutline
    AllPoints[[1]]<-left_top_eyebrow
    AllPoints[[2]]<-left_bottom_eyebrow
    AllPoints[[3]]<-right_top_eyebrow
    AllPoints[[4]]<-right_bottom_eyebrow
    AllPoints[[5]]<-right_eye_top_eyelid
    AllPoints[[6]]<-right_eye_bottom_eyelid
    AllPoints[[7]]<-left_eye_top_eyelid
    AllPoints[[8]]<-left_eye_bottom_eyelid
    AllPoints[[9]]<-top_lip_top
    AllPoints[[10]]<-top_lip_bottom
    AllPoints[[11]]<-bottom_lip_top
    AllPoints[[12]]<-Bottom_lip_bottom
    AllPoints[[13]]<-top_brow
    AllPoints[[14]]<-low_brow
    AllPoints[[15]]<-top_nose
    AllPoints[[16]]<-low_nose
    
    
    #loop through each set of points
    for(i in 1:k) {
      interpolatingpoints<-mat[AllPoints[[i]],]#select rows containing x,y values we want to use
      numpoints<-nrow(interpolatingpoints)
      xcol<-interpolatingpoints[,1] #select x column
      ycol<-interpolatingpoints[,2] #select y column
      polyans<-lm(ycol ~ poly(xcol, 2, raw=TRUE)) #second degree polynomial
      mycurve<-polyans$coefficients[[3]] #we use a in ax^2+bx+c
      Returnlist[i]<-mycurve # we use a from each line on a face
    }
    
    return(Returnlist)
    
  }
  
  
  if(usepoly) {
    
    ListofLists <- list()
    for(j in index) {
      coefs<-poly_curve(fiducial_pt_list[[j]])
      ListofLists[[j]]<-coefs
    }
    
    mt1 <- matrix(unlist(ListofLists), nrow = length(index), byrow = TRUE)
    
    mt1_data <- cbind(mt1, info$label[index])
    
    colnames(mt1_data) <- c(paste("feature", 1:(ncol(mt1_data)-1), sep = ""), "label")
    ### convert matrix to data frame
    curve_data <- as.data.frame(mt1_data)
    
    return(feature_df = curve_data)
    
  } else {
    ### Step 3: Apply function in Step 2 to selected index of input list, output: a feature matrix with ncol = n(n-1) = 78*77 = 6006
    pairwise_dist_feature <- t(sapply(input_list[index], pairwise_dist_result))
    dim(pairwise_dist_feature) 
    
    ### Step 4: construct a dataframe containing features and label with nrow = length of index
    ### column bind feature matrix in Step 3 and corresponding features
    pairwise_data <- cbind(pairwise_dist_feature, info$label[index])
    ### add column names
    colnames(pairwise_data) <- c(paste("feature", 1:(ncol(pairwise_data)-1), sep = ""), "label")
    ### convert matrix to data frame
    pairwise_data <- as.data.frame(pairwise_data)
    ### convert label column to factor
    pairwise_data$label <- as.factor(pairwise_data$label)
    
    return(feature_df = pairwise_data)
  }
}


