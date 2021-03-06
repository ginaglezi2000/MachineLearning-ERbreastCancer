predict <- function(theta, X)
{
	# output p
	# PREDICT Predict whether the label is 0 or 1 using learned logistic
	# regression parameters theta
	#   p = PREDICT(theta, X) computes the predictions for X using a
	#   threshold at 0.5 (i.e., if sigmoid(theta'*x) >= 0.5, predict 1)

    m <- nrow(X); # Number of training examples

    # You need to return the following variables correctly
    p <- rep(0,m)

    # ====================== YOUR CODE HERE ======================
    # Instructions: Complete the following code to make predictions using
    #               your learned logistic regression parameters.
    #               You should set p to a vector of 0's and 1's

	linear <- X%*%theta;
	h <- sigmoid(linear);

	p[h>=0.5] <- 1;

    # =========================================================================

    return(p)
}
