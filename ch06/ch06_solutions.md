# Tarea 03

_Iván Eduardo Sedeño Jiménez_

## Teoría  

1. We perform best subset, forward stepwise, and backward stepwise selection on a single data set. For each approach, we obtain p + 1 models, containing 0, 1, 2, . . . , p predictors. Explain your answers:
 - a) Which of the three models with k predictors has the smallest training RSS?
    > Best subset tendrá el menor RSS de entrenamiento, puesto que en los otros dos quedan varios mdelos sin probarse, sin embargo, con best subset se prueba una mayor cantidad de subsets.

 - b) Which of the three models with k predictors has the smallest test RSS?
    > Esto es difcícil de predecir, ya que best subset puede llegar a sobreajustar al set de entrenamiento, pero ambos forward y backward selection no exploran todos los modelos posibles. Sin embargo, es más probable que best subset tenga el menor RSS en el set de test.

 - c) True or False:
    1. The predictors in the k-variable model identified by forward stepwise are a subset of the predictors in the (k+1)-variable model identified by forward stepwise selection.
       > Verdadero

    2. The predictors in the k-variable model identified by back- ward stepwise are a subset of the predictors in the (k + 1)- variable model identified by backward stepwise selection.
       > Verdadero

    3. The predictors in the k-variable model identified by back- ward stepwise are a subset of the predictors in the (k + 1)- variable model identified by forward stepwise selection.
       > Falso

    4. The predictors in the k-variable model identified by forward stepwise are a subset of the predictors in the (k+1)-variable model identified by backward stepwise selection.
       > Falso

    5. The predictors in the k-variable model identified by best subset are a subset of the predictors in the (k + 1)-variable model identified by best subset selection.
       > Falso

2. For parts (a) through (c), indicate which of i. through iv. is correct. Justify your answer.
 - a) The lasso, relative to least squares, is:
    1. More flexible and hence will give improved prediction accuracy when its increase in bias is less than its decrease in variance.
    2. More flexible and hence will give improved prediction accuracy when its increase in variance is less than its decrease in bias.
    3. Less flexible and hence will give improved prediction accuracy when its increase in bias is less than its decrease in variance.
    4. Less flexible and hence will give improved prediction accuracy when its increase in variance is less than its decrease in bias.  

    > La no. 3 es cierta, ya que se penaliza el tamaño.

 - b) Repeat (a) for ridge regression relative to least squares.
    > La no.3 es cierta ya que al igual que lasso penaliza el tamaño, solo que esta no selecciona varibales.

 - c) Repeat (a) for non-linear methods relative to least squares.
    > La no.2 es cierta, al ser no lineal, es más flexible y aumenta su varianza.

3. Suppose we estimate the regression coefficients in a linear regression model by minimizing  
 ![Equation1](equation1.png)  
    for a particular value of s. For parts (a) through (e), indicate which of i. through v. is correct. Justify your answer.
 - a)As we increase s from 0, the training RSS will:
    1. Increase initially, and then eventually start decreasing in an inverted U shape.
    2. Decrease initially, and then eventually start increasing in a U shape.
    3. Steadily increase.
    4. Steadily decrease.
    5. Remain constant.  

    > La no.4 es cierta, entre más se aumente __s__, el modelo tendrá menos restricciones, lo que le permitirá ajustarse mejor al set de entrenamiento.

 - b) Repeat (a) for test RSS.
    > La no. 2 es cierta, inicialmente el modelo al tener menos restricciones puede ajustarse mejor a distintos datos, pero al seguir incrementando __s__, esta comenzará a sobreajustarse al set de training, empeorando el RSS para el set de test.

 - c) Repeat (a) for variance.
    > La no. 3 es cierta, tener menos restringido el modelo da espacio a mayor varianza.

 - d) Repeat (a) for (squared) bias.
    > La no 4. es cierta, el bias el bias experimentará lo contrario a la varianza.

 - e) Repeat (a) for the irreducible error.
    > La no 5. es cierta, este error es independiente del modelo.

4. Suppose we estimate the regression coefficients in a linear regression model by minimizing  
 ![equation2](equation2.png)  
    for a particular value of λ. For parts (a) through (e), indicate which of i. through v. is correct. Justify your answer.
 - a) As we increase λ from 0, the training RSS will:
    1. Increase initially, and then eventually start decreasing in an inverted U shape.
    2. Decrease initially, and then eventually start increasing in a U shape.
    3. Steadily increase.
    4. Steadily decrease.
    5. Remain constant.
- b) Repeat (a) for test RSS.
- c) Repeat (a) for variance.
- d) Repeat (a) for (squared) bias.
- e) Repeat (a) for the irreducible error.
5. It is well-known that ridge regression tends to give similar coefficient values to correlated variables, whereas the lasso may give quite dif- ferent coefficient values to correlated variables. We will now explore this property in a very simple setting.
   Suppose that n = 2, p = 2, x11 = x12, x21 = x22. Furthermore, supposethaty1+y2 =0andx11+x21 =0andx12+x22 =0,sothat the estimate for the intercept in a least squares, ridge regression, or lasso model is zero: βˆ0 = 0.
 - a)Write out the ridge regression optimization problem in this set- ting.
 - b) Argue that in this setting, the ridge coefficient estimates satisfy βˆ 1 = βˆ 2 .
 - c) Write out the lasso optimization problem in this setting.
 - d) Argue that in this setting, the lasso coefficients βˆ1 and βˆ2 are not unique—in other words, there are many possible solutions to the optimization problem in (c). Describe these solutions.  
6. We will now explore (6.12) and (6.13) further.
 - a) Consider (6.12) with p = 1. For some choice of y1 and λ > 0, plot (6.12) as a function of β1. Your plot should confirm that (6.12) is solved by (6.14).
 - b) Consider (6.13) with p = 1. For some choice of y1 and λ > 0, plot (6.13) as a function of β1. Your plot should confirm that (6.13) is solved by (6.15).
7. We will now derive the Bayesian connection to the lasso and ridge regression discussed in Section 6.2.2.
 - a) Suppose that yi = β0 +(Sum^p_j=1) xi,j βj +εi where ε1, . . . , εn are inde- pendent and identically distributed from a N(0,σ^2) distribution. Write out the likelihood for the data.
 - b) Assume the following prior for β: β1, . . . , βp are independent
and identically distributed according to a double-exponential
distribution with mean 0 and common scale parameter b: i.e.
p(β) = 1/2b exp(−|β|/b). Write out the posterior for β in this 2b setting.
 - c) Argue that the lasso estimate is the mode for β under this pos- terior distribution.
 - d) Now assume the following prior for β: β1, . . . , βp are independent and identically distributed according to a normal distribution with mean zero and variance c. Write out the posterior for β in this setting.
 - e) Argue that the ridge regression estimate is both the mode and the mean for β under this posterior distribution.
8. In this exercise, we will generate simulated data, and will then use this data to perform best subset selection.
 - a) Use the ``rnorm()`` function to generate a predictor X of length n = 100, as well as a noise vector ε of length n = 100.
 - b) Generate a response vector Y of length n = 100 according to the model  
   ![equation3](equation3.png)  
   where β0, β1, β2, and β3 are constants of your choice.
 - c) Use the ``regsubsets()`` function to perform best subset selection in order to choose the best model containing the predictors X,X2,...,X10. What is the best model obtained according to Cp, BIC, and adjusted R2? Show some plots to provide evidence for your answer, and report the coefficients of the best model ob- tained. Note you will need to use the ``data.frame()`` function to create a single data set containing both X and Y .
 - d) Repeat (c), using forward stepwise selection and also using back- wards stepwise selection. How does your answer compare to the results in (c)?
 - e) Now fit a lasso model to the simulated data, again using X,X2, . . . , X 10 as predictors. Use cross-validation to select the optimal value of λ. Create plots of the cross-validation error as a function of λ. Report the resulting coefficient estimates, and discuss the results obtained.
 - f) Now generate a response vector Y according to the model  
   ![equation4](equation4.png)  
and perform best subset selection and the lasso. Discuss the results obtained.
9. In this exercise, we will predict the number of applications received using the other variables in the ``College`` data set.
 - a) Split the data set into a training set and a test set.
 - b) Fit a linear model using least squares on the training set, and report the test error obtained.
 - c) Fit a ridge regression model on the training set, with λ chosen by cross-validation. Report the test error obtained.
 - d) Fit a lasso model on the training set, with λ chosen by cross- validation. Report the test error obtained, along with the number of non-zero coefficient estimates.
 - e) Fit a PCR model on the training set, with M chosen by cross- validation. Report the test error obtained, along with the value of M selected by cross-validation.
 - f) Fit a PLS model on the training set, with M chosen by cross- validation. Report the test error obtained, along with the value of M selected by cross-validation.
 - g) Comment on the results obtained. How accurately can we pre- dict the number of college applications received? Is there much difference among the test errors resulting from these five ap- proaches?
10. We have seen that as the number of features used in a model increases, the training error will necessarily decrease, but the test error may not.  
   We will now explore this in a simulated data set.
- a) Generate a data set with p = 20 features, n = 1,000 observa- tions, and an associated quantitative response vector generated according to the model Y = Xβ+ε, where β has some elements that are exactly equal to zero.
- b) Splityourdatasetintoatrainingsetcontaining100observations and a test set containing 900 observations.
- c) Perform best subset selection on the training set, and plot the training set MSE associated with the best model of each size.
- d) Plot the test set MSE associated with the best model of each size.
- e) For which model size does the test set MSE take on its minimum value? Comment on your results. If it takes on its minimum value for a model containing only an intercept or a model containing all of the features, then play around with the way that you are generating the data in (a) until you come up with a scenario in which the test set MSE is minimized for an intermediate model size.
- f) How does the model at which the test set MSE is minimized compare to the true model used to generate the data? Comment on the coefficient values.
- g) Create a plot displaying ![equation5](equation5.png)
(g) Create a plot displaying j=1(βj − βj ) for a range of values of r, where βˆjr is the jth coefficient estimate for the best model containing r coefficients. Comment on what you observe. How does this compare to the test MSE plot from (d)?
11. We will now try to predict per capita crime rate in the Boston data set.
- a) Try out some of the regression methods explored in this chapter, such as best subset selection, the lasso, ridge regression, and PCR. Present and discuss results for the approaches that you consider.
- b) Propose a model (or set of models) that seem to perform well on this data set, and justify your answer. Make sure that you are evaluating model performance using validation set error, cross- validation, or some other reasonable alternative, as opposed to using training error.
- c) Does your chosen model involve all of the features in the data set? Why or why not?
