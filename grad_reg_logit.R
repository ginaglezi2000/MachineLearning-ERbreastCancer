grad_reg_logit <- function(theta, X, y, lambda)
{
    # output is theta, J_history
    # GRADIENTDESCENT Performs gradient descent to learn theta
    # theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by
    # taking num_iters gradient steps with learning rate alpha

    # To plot the cost use [theta hist]= gradientDescent(X, y, theta, alpha, iterations);

    # Initialize some useful values

    # num_iters <- 5;
    # iter <- 1;
    # theta <- rep(0, 2);
    # costFunction(theta, X, y)

    m <- length(y); # number of training examples
    #J_history <- rep(1,num_iters);
    n <- length(theta)
	grad <- rep(0,n)


    #for (iter in 1:num_iters)
    #{
        # ====================== YOUR CODE HERE ======================
        # Instructions: Perform a single gradient step on the parameter
        #               vector theta.
    
    	# Hint: While debugging, it can be useful to print out the values
        #       of the cost function (computeCost) and gradient here.
    
    
    	linear <- X%*%theta;
        h <- sigmoid(linear);
    
    	theta_temp <- theta;
        theta_temp[1] <- 0; # to avoid regularizing X_zero
    	grad <- 1/m* (t(X)%*% (h - y)) + lambda/m*(theta_temp);
        #for (i in 1:n) {
        #    grad[i] <- 1/m*(sum((h-y)*X[,i]));
        #}
        #theta <- theta - alpha*grad;
    
    	#   h[1:3]
    	#   y[1:3]

    	# ============================================================

    	# Save the cost J in every iteration
        #	J_history[iter] <- costFunction(theta, X, y)$J;
    #}
    #gradObj <- list(J_history, theta)
    #names(gradObj) <- c("J_history", "theta");

    return(grad)
}
