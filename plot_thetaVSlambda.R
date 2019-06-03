plot_thetaVSlambda <- function(thetaMat, lambdas_to_try)
{
    p <- ncol(thetaMat)   #number of parameters
    thetaMat_noInt <- thetaMat[,2:p]  # We are not drawing the Intercept
 
 	# add space to the right of the plotting area
    # allow to add text outside plotting area
    # default margins 5.1 4.1 4.1 2.1 (bottom, left, top, right)
    par(xpd=TRUE, mar=c(5.1, 4.1, 4.1, 8))

 
 	plot(0,0,
    xlim = c(lambdas_to_try[1],
    lambdas_to_try[length(lambdas_to_try)]),
    ylim = c(min(thetaMat_noInt), max(thetaMat_noInt)),
    type = "n",
    xlab="lambda", ylab="Theta")
    
    cl <- rainbow(p-1)  # colors for the lines
    
    for (i in 1:(p-1)){
        lines(lambdas_to_try, thetaMat_noInt[,i] ,col = cl[i],type = 'l')
    }
    legend(max(lambdas_to_try+0.5),max(thetaMat_noInt), legend=colnames(thetaMat[,2:p]),
    pch=rep("-",(p-1)), col=cl, cex=0.8, horiz=FALSE)
    par(xpd=FALSE) # return to default graphical settings
    abline(h=0,col = "black", lwd=1.5)
}
