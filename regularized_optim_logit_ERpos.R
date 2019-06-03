# libraries
library(yaml)
library(expss)
library(dplyr)

# Reading the parameters from the yaml file
params <- read_yaml("~/Desktop/Gina/Cursos/cursoStanfordMachineLearning2018/wk3_Logistic_Regression/grad_logitR_codeR/gradDesc_logit_optim/regularization.yaml")
scripts <- params$scripts_path

# Reading the data
inputVars <- params$inputVars
y_idx <- params$respVar
trainSet <- read.table(params$trainSet, header=TRUE, sep="\t");
valSet <- read.table(params$valSet, header=TRUE, sep="\t");

# Removing missing values from response variable (No missing values for features)
trainSet <- trainSet[-which(is.na(trainSet[,y_idx])),]
y    <- as.matrix(trainSet[,y_idx])
X    <- as.matrix(trainSet[,inputVars])
X <- cbind(rep(1,nrow(X)), X) # add a column of ones

# Removing missing values from response variable (No missing values for features)
valSet <- valSet[-which(is.na(valSet[,y_idx])),]
yval <- as.matrix(valSet[,y_idx])
Xval <- as.matrix(valSet[,inputVars])
Xval <- cbind(rep(1,nrow(Xval)), Xval) # add a column of ones

# Adding some labels
val_lab(trainSet[,4:13])= num_lab("
                        0 Non-Aberrant    
                        1 Aberrant    
                        ")

val_lab(trainSet$ERpos)=num_lab("
                        0 ER-    
                        1 ER+    
                        ")

table(trainSet$ERpos)

# Frequency table for features
sapply(trainSet[,4:13],table)

# Adding some labels
val_lab(valSet[,4:13])= num_lab("
                        0 Non-Aberrant    
                        1 Aberrant    
                        ")

val_lab(valSet$ERpos)=num_lab("
                        0 ER-    
                        1 ER+    
                        ")

table(valSet$ERpos)

# Frequency table for features
sapply(valSet[,4:13],table)


# importing the functions
source(paste(scripts,"sigmoid.R", sep="/"))  # sigmoid function
source(paste(scripts,"cost_reg_logit.R",sep="/")) #cost function for logistic regression
source(paste(scripts,"predict.R", sep="/")) # prediction function
source(paste(scripts,"score.R", sep="/")) # score for logistic regression: F1 or Accuracy
source(paste(scripts,"grad_reg_logit.R",sep="/")) # gradients descent for one lambda
source(paste(scripts,"grad_reg_logit_optim_iterLambda.R",sep="/")) # gradient descent for vector of lambda
source(paste(scripts,"curveLambdaVSscore.R",sep="/")) # plots score (F1 or Accuracy) for every lambda
source(paste(scripts,"plot_thetaVSlambda.R",sep="/")) #plot coefficients vs lambda
source(paste(scripts,"learningCurve.R",sep="/")) #plot the learning curve for the final model

# Initialize theta and lambda
initial_theta <- rep(0, (ncol(X)))
lambda <- 0

# Reading the metric to use from the yaml file
metric <- params$metric

# Compute and display initial cost
J <- cost_reg_logit(initial_theta, X, y, lambda);
J %>% round(3) %>% paste('Cost at initial theta (zeros):') %>% print()

# Gradient descent with optim
optimized_noReg <- optim(par=initial_theta,X=X,y=y,lambda=lambda, fn=cost_reg_logit,gr=grad_reg_logit)
print("The optimized theta values with no regularization (lambda=0) are: ")
theta <- optimized_noReg$par
names(theta) <- c("Intercept", colnames(trainSet[,inputVars]))
print(round(theta,3))

print('The cost at the final theta values with no regularization (lambda=0) is: ')
print(round(optimized_noReg$value,3))

# Choosing lambda
lambdas_to_try <- seq(0, 10, length.out = 100)
optimObj <- grad_reg_logit_optim_iterLambda(initial_theta,  X, y, lambdas_to_try, metric="F1")
thetaMat <- optimObj$thetaMat
colnames(thetaMat) <- c("Intercept", colnames(trainSet[,inputVars]))

scoreVal <- curveLambdaVSscore(thetaMat, X, y, Xval, yval, metric)
 plot_thetaVSlambda(thetaMat, lambdas_to_try)
 
 best.lambda.idx <- which.max(scoreVal)
 best.lambda <- lambdas_to_try[best.lambda.idx]
 final.scoreVal <- max(scoreVal)*100
paste('The best', metric, 'score is:', round(final.scoreVal,1),'% at lambda=', round(best.lambda,3)) %>% print()

paste('The optimized theta values for lambda=', round(best.lambda,3), 'are:')
colnames(thetaMat) <- c("Intercept", colnames(trainSet[,inputVars]))
thetaMat[best.lambda.idx,] %>% round(3) %>% print()

curve <- learningCurve(initial_theta, best.lambda, X, y, Xval, yval, metric="F1")
