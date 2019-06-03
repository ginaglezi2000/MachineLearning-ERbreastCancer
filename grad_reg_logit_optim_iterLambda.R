grad_reg_logit_optim_iterLambda <- function(initial_theta, X, y, lambdas_to_try, metric)
{
    # output is optimized, a lambdasXthetha matrix
    # Performs gradient descent for different values of lambda

    # Initialize some useful values
    #m <- length(y); # number of training examples
    n <- length(theta)
    p <- length(lambdas_to_try)
    thetaMat <- mat.or.vec(p,n)
    score <- rep(0, p)
    cost <- rep(0, p)
    i <- 1

    #grad <- rep(0,n)


    for (lambda in lambdas_to_try)
    {
        #        optimized[lambda,] <-optim$par(par=initial_theta,X=X,y=y,lambda=lambda, fn=cost_reg_logit,gr=grad_reg_logit) #matrix lambdaxtheta
        optimObj <-optim(par=initial_theta,X=X,y=y,lambda=lambda, fn=cost_reg_logit,gr=grad_reg_logit) #matrix lambdaxtheta
        thetaMat[i,] <- optimObj$par
        if (metric=="acc")
        	{score[i] <- score(thetaMat[i,], X, y, metric="acc")}
        else
        	{score[i] <- score(thetaMat[i,], X, y, metric="F1")}
        cost[i] <- round(optimObj$value, 3)
        i <- i+1
    }
    
    optimObj <- list(thetaMat, score, cost)
    names(optimObj) <- c("thetaMat", "score", "cost");
    
    return(optimObj)
}
