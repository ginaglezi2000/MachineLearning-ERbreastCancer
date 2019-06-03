 cost_reg_logit <- function(theta, X, y, lambda)
{
	# COSTFUNCTION Compute cost and gradient for logistic regression
	# output should be J and grad
	#   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
	#   parameter for logistic regression and the gradient of the cost
	#   w.r.t. to the parameters.

	# Initialize some useful values
	m <- length(y); # number of training examples
    n <- length(theta) # number of features

    # ====================== YOUR CODE HERE ======================
	# Instructions: Compute the cost of a particular choice of theta.
	#               You should set J to the cost.
	#               Compute the partial derivatives and set grad to the partial
	#               derivatives of the cost w.r.t. each parameter in theta
	#
	# Note: grad should have the same dimensions as theta


	linear <- X%*%theta
	h <- sigmoid(linear);
    h[h==1]<-0.999999999 # to avoid log(1-h)
    # theta_zero should not be included in the regularization
    J <- 1/m * sum(-y*log(h)-(1-y)*log(1-h)) + lambda/(2*m)*sum(theta[2:n]^2);

    return(J)
}
