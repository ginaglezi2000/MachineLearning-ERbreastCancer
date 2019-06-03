curveLambdaVSscore <- function(thetaMat,X, y, Xval, yval, metric)
{
    # input: theta for every lambda (thetaMat)
    #		features and response ariable for validation data (Xval, yval)
    # accuracy for the training data at every lambda (accTtrain)
    
    # Initializing
    l <- nrow(thetaMat)
    scoreTrain <- rep(0, l)
    scoreVal <- rep(0, l)
    
    for (i in 1:l)
    {
        if (metric=="acc")
        {	scoreTrain[i] <- score(thetaMat[i,], X, y, metric="acc")
            scoreVal[i] <- score(thetaMat[i,], Xval, yval, metric="acc")
        }
        else
        {	scoreTrain[i] <- score(thetaMat[i,], X, y, metric="F1")
            scoreVal[i] <- score(thetaMat[i,], Xval, yval, metric="F1")
        }
    }
    
    if (metric=="acc") {label <- "Accuracy"} else {label <- "F1 score"}
    
    plot(lambdas_to_try,scoreTrain, type="l",
    #ylim=c(min(scoreVal),max(scoreTrain)),
    ylim=c(min(scoreVal),1),
    ylab=label)
    
    lines(lambdas_to_try, scoreVal, type="l", col="red")
    legend("topright", legend=c("Training set", "Test set"),
    pch=c("-","-"), col=c("black","red"), cex=0.8, horiz=TRUE)
    
    return(scoreVal)

}
