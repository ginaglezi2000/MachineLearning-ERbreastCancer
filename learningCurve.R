
# About learning curves with R
# https://stackoverflow.com/questions/38582076/how-to-plot-a-learning-curve-in-r

# This script creates a learning curve as the number of training samples grow
# the default score is  F1 but it can also use accuracy ("acc")

# For this script X and Xval already have a column of 1's (the first one)

learningCurve<-function(initial_theta, best.lambda, X, y, Xval, yval, metric)
{
    m <- nrow(X)
    m_val <- nrow(Xval)
    start <- 20
    
    learnCurve <- c()
   

    for (i in start:m)
    {
        optimized <- optim(par=initial_theta,X=X[1:i,],y=y[1:i,],lambda=best.lambda, fn=cost_reg_logit,gr=grad_reg_logit)
        theta <- optimized$par
        
        if (metric=="acc") {
        	eTrain <- score(theta, X[1:i,], y[1:i,], metric="acc")
            eCV <- score(theta, Xval, yval, metric="acc")
        } else {
        	eTrain <- score(theta, X[1:i,], y[1:i,], metric="F1")
        	eCV <- score(theta, Xval, yval, metric="F1")
    	}

       learnCurve <- rbind(learnCurve, c(i, eTrain, eCV))
       colnames(learnCurve) <- c('m', 'eTrain', 'eCV')
    }
    
    if (metric=="acc") {label <- "Accuracy"}
    else {label <- "F1 score"}
    
    # plotting the learning curves for the traning and test data sets
    
    par(xpd=NA, mar=c(5.1, 4.1, 4.1, 8))
    plot(learnCurve[,1], learnCurve[,2], type="l",
         xlab="m (training set size)", ylab=label,
         ylim=c(min(learnCurve[,2:3], na.rm=TRUE),1))
    lines(learnCurve[,1], learnCurve[,3], col="blue")
    #legend(start-1.5, 1.107, legend=c("Training set", "Test set"),
    legend(m+2.5, 1, legend=c("Training set", "Test set"),
    	  pch=c("-","-"), col=c("black","blue"), cex=0.8, horiz=FALSE)
    
    return(learnCurve)
}
