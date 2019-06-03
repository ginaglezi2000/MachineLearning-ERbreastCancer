sigmoid <- function(z)
{
    # g = SIGMOID(z) computes the sigmoid of z.

    # Instructions: Compute the sigmoid of each value of z (z can be a matrix,
    #               vector or scalar).
	g <- 1 / (1 + exp(-z));

    # ====================== YOUR CODE HERE ======================


    return(g)
}
