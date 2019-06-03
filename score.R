score <- function(theta, X, y, metric)
{
    # Computes either Accuracy or F1 scorefor a specific model

    pred <- predict(theta, X)
    confusionMat <- table(pred,y)
    # Precision = TP/(TP+FP)
    precision <- confusionMat[2,2]/
    (confusionMat[2,2]+ confusionMat[2,1])
    # Recall = TP/(TP+FN)
    recall <- confusionMat[2,2]/
    (confusionMat[2,2]+ confusionMat[1, 2])
    # F1score = 2*(precision*recall)/(precision+recall)
    F1 <- 2*(precision*recall)/(precision+recall)
    # Accuracy [(TP+TN)/total]
    acc <- (confusionMat[1,1]+confusionMat[2,2])/sum(confusionMat)
    
    if (metric=="F1") {score <- acc} else {score <- F1}
    
    return(score)
}
