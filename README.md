# ER breast cancer prediction using gradient descent logistic regression
### By Georgina Gonzalez

Copy Number Aberrations, gains and losses of genomic regions, are a hallmark of cancer. Copy number data is high-dimensional and is characterized by heavy correlated features. Often, like in this case, the number of samples is small compared to the number of features. In this work I first reduce the dimensionality using Topological Analysis of array CGH (TAaCGH) [1] detecting regions of the genome with significant aberrations in copy number for patients with over-expression in estrogen receptor (ER+). Next it is determined if each of the patients is aberrant for those particular regions creating, as a result, a set of binary variables that will be used as features in a gradient descent logistic regression model to predict ER+ breast cancer [2].

The file regularized_optim_logit_ERpos.html shows the results and describes each step that leads to the final model with F1 score of 71.4% for ER+ breast cancer.

### References

[1] Daniel DeWoskin, Joan Climent, I Cruz-White, Mariel Vazquez, Catherine Park, and Javier Arsuaga. Applications of computational homology to the analysis of treatment response in breast cancer patients. Topology and its Applications, 157(1):157–164, 2010.

[2] Gonzalez G, Ushakova A, Sazdanovic R, Arsuaga J. Prediction in cancer genomics using topological signatures and machine learning. The Abel Symposium “Topological Data Analysis” 2018At: Geiranger, NorwayVolume: (in Press).

Climent data set: Joan Climent, Peter Dimitrow, Jane Fridlyand, Jose Palacios, Reiner Siebert, Donna G Al- bertson, Joe W Gray, Daniel Pinkel, Ana Lluch, and Jose A Martinez-Climent. Deletion of chromosome 11q predicts response to anthracycline-based chemotherapy in early breast cancer. Cancer research, 67(2):818–826, 2007.

Horlings data set: Hugo M Horlings, Carmen Lai, Dimitry SA Nuyten, Hans Halfwerk, Petra Kristel, Erik van Beers, Simon A Joosse, Christiaan Klijn, Petra M Nederlof, Marcel JT Reinders, et al. In- tegration of dna copy number alterations and prognostic gene expression signatures in breast cancer patients. Clinical Cancer Research, 16(2):651–663, 2010.

### The scripts
- sigmoid.R  - sigmoid function
- cost_reg_logit.R  - cost function for logistic regression
- predict.R   - prediction function
- score.R   - score for logistic regression: F1 or Accuracy
- grad_reg_logit.R   - gradient descent for one lambda
- grad_reg_logit_optim_iterLambda.R   - gradient descent for a vector of lambdas
- curveLambdaVSscore.R   - plot score (F1 or Accuracy) for every lambda
- plot_thetaVSlambda.R   - plot coefficients vs lambda
- learningCurve.R   - plot learning curve for the final model
