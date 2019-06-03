accuracy <- function(theta, X, y)
{
    # Computes accuracy [(TP+TN)/total] for a specific model

    pred <- predict(theta, X)
    confusionMat <- table(pred,y)
    acc <- (confusionMat[1,1]+confusionMat[2,2])/sum(confusionMat)
    
    return(acc)
}
