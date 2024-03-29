---
title: "Feature selection in multiple variable models"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/ffs_beta2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

So far, the models have only considered one explanatory (i.e. independent) variable. 
If a dependent variable should be explained or predicted by more than one independent variable, decisions have to be made regarding the best combination of independent variables.

In the following, we will start with a short example, which illustrates one of the problems of multi-variable models. Afterwards, the two major concepts of variable selection will be briefly introduced:

* **Recursive aka backward feature selection**: in this case, a model is computed with all available explanatory variables. 
Afterwards, the variable with the least explanatory power is excluded from the model and this procedure is repeated until a quality criteria, e.g. maximum adjusted r squared or minimum AIC is reached.
* **Forward feature selection**: in this case, a model is separately computed for each available/potential explanatory variable. The variable which has the best individual explanatory power is selected and added to the final model. Afterwards, all possible combinations between the selected and the remaining variables are tested and the variable is added to the final model, which leads to the largest increase of the explanatory power of the model. This procedure is repeated until a quality criteria is reached.

To illustrate this concept, we stay with the [anscombe dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html) but modify variables x2, x3, and x4 (please note that the original variables x2 to x4 have of course not intended to be used for y1 in the anscombe data). 
The modification of x2 and x3 is necessary since x1 to x3 show a complete co-linearity, 
which violates probably the most important restriction in multiple (linear) regression models.

Just for completeness, the following code shows the modification of the anscombe data set although it is not relevant to know anything about it for the examples below:

```r
y <- anscombe$y1
x1 <- anscombe$x1
lmod <- lm(y~x1)

set.seed(5)
x2 <- lmod$model$y - lmod$fitted.values * sample(seq(-1, 0, 0.1), nrow(anscombe))
set.seed(2)
x3 <- anscombe$x3 + sample(seq(-1, 1, 0.1), nrow(anscombe))
set.seed(3)
x4 <- anscombe$x4 + sample(seq(-1, 1, 0.1), nrow(anscombe))

df <- data.frame(y = y,
                 x1 = x1,
                 x2 = x2,
                 x3 = x3,
                 x4 = x4)
```

## Multiple linear regression model
To illustrate a multiple linear regression model, the dependent variable y is predicted using the independent variables x2 and x1. As for the case of linear models, some test statistics can be computed but the number of independent variables has to be considered in the denominator. This gives us the adjusted R squared. 
We will not test for normal distribution of the residuals etc. in this example but of course, the same restrictions, which apply to bivariate linear models, are also relevant for multiple linear models.

```r
lmod <- lm(y ~ x2 + x1, data = df)

ss_obsrv <- sum((lmod$model$y - mean(lmod$model$y))**2)
ss_model <- sum((lmod$fitted.values - mean(lmod$model$y))**2)
ss_resid <- sum((lmod$model$y - lmod$fitted.values)**2)

mss_obsrv <- ss_obsrv / (length(lmod$model$y) - 1)
mss_model <- ss_model / 2
mss_resid <- ss_resid / (length(lmod$model$y) - 2 -1)

r_squared <- round(1 - ss_resid/ss_obsrv, 5)
r_squared_adjusted <- round(1 - 
                             (ss_resid / 
                                (length(lmod$model$y) - (2+1))) / 
                             (ss_obsrv / 
                                (length(lmod$model$y) - 1)), 5)

f_value <- round(mss_model / mss_resid, 2)

print(data.frame(Name = c("r squared", "adj. r squared", "f value"), 
                 Value = c(r_squared, r_squared_adjusted, f_value)))
```

```
##            Name    Value
## 1      r squared  0.74606
## 2 adj. r squared  0.68257
## 3       f value 11.75000
```

As for the linear model, there is no need to compute the test values by hand. One can use the `anova` or `summary` function for that. Let's start with the analysis of variance:

```r
anova(lmod)
```

```
## Analysis of Variance Table
## 
## Response: y
##           Df Sum Sq Mean Sq F value   Pr(>F)   
## x2         1 23.287 23.2867 17.7746 0.002932 **
## x1         1  7.505  7.5050  5.7285 0.043621 * 
## Residuals  8 10.481  1.3101                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
As one can see both x2 and x1 seem to be significant. Let's have a look at the result of the t statistics:

```r
summary(lmod)
```

```
## 
## Call:
## lm(formula = y ~ x2 + x1, data = df)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.0000 -0.8098 -0.3079  0.6609  1.7982 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   2.0979     1.1869   1.768   0.1151  
## x2            0.2022     0.1278   1.583   0.1521  
## x1            0.3480     0.1454   2.393   0.0436 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.145 on 8 degrees of freedom
## Multiple R-squared:  0.7461,	Adjusted R-squared:  0.6826 
## F-statistic: 11.75 on 2 and 8 DF,  p-value: 0.004159
```
Please note that this time, only x1 is indicated as significant. What causes this difference? Before we go into details, we will compute the model again but this time with a changed order (i.e. x1 and x2):


```r
lmod <- lmod <- lm(y ~ x1 + x2, data = df)
anova(lmod)
```

```
## Analysis of Variance Table
## 
## Response: y
##           Df  Sum Sq Mean Sq F value   Pr(>F)   
## x1         1 27.5100 27.5100  20.998 0.001796 **
## x2         1  3.2818  3.2818   2.505 0.152147   
## Residuals  8 10.4809  1.3101                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
summary(lmod)
```

```
## 
## Call:
## lm(formula = y ~ x1 + x2, data = df)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.0000 -0.8098 -0.3079  0.6609  1.7982 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   2.0979     1.1869   1.768   0.1151  
## x1            0.3480     0.1454   2.393   0.0436 *
## x2            0.2022     0.1278   1.583   0.1521  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.145 on 8 degrees of freedom
## Multiple R-squared:  0.7461,	Adjusted R-squared:  0.6826 
## F-statistic: 11.75 on 2 and 8 DF,  p-value: 0.004159
```
Obviously order matters for analysis of variance results! This is because the null-hypothesis is different to the one from the `summary` function. While the latter checks if the slope of the regression line is significantly different from zero for each individual variable, the anova approach only checks if the slope of the added variable is different from zero. This means that if only one explanatory variable is added to the very basic model y = intercept + error, the variable is marked as significant if its associated slope is different from zero. If a second variable is added, the "baseline" model is the one with the first variable already included. Hence, it is not checked if both the slopes of the explanatory variables are still different from zero but only the slope of the added variable. In the above case, this leads to the situation that if x1 is added after x2, both variables are marked as significant while only x1 is significant if it is added prior to x2.

The above example illustrates that the composition of multiple (regression) models is by far not as trivial as it might look in the first place. 
In general, there are two basic selection procedures to cope with this. Both are not targeting the significance of slopes but the overall predictive power, which can be estimated e.g. using an adjusted r squared value, the Akaike information criteria (AIC) or the prediction error on an independent sample data set.

## Recursive feature selection
The idea of recursive feature selection is to start with the full model and then leave out one variable after another until the quality of the model does not increase further. The variables are taken out from the equation depending on their predictive power in the multi-variable model. 
To estimate this power, each of the available variables is left out once and the respective changes in the model quality are taken as the basis for the decision. 

To illustrate this, the following function is used:

```r
recursive_feature_selection <- function(data, dep, vars){
rec_fs <- lapply(seq(0, length(vars)), function(v){
  
  if(v == 0){
    formula <- paste(dep, " ~ ", paste(vars, collapse=" + "))
    v = "all"
  } else {
    formula <- paste(dep, " ~ ", paste(vars[-v], collapse=" + "))
    v = vars[v]
  }
  
  lmod <- lm(formula, data = data)
  results <- data.frame(Variable = v,
                        Adj_R_sqrd = round(summary(lmod)$adj.r.squared, 4),
                        AIC = round(AIC(lmod), 4))
  return(results)
})
rec_fs <- do.call("rbind", rec_fs)

rec_fs$Diff <- rec_fs$AIC - rec_fs$AIC[1]

print(rec_fs)

exclude <- rec_fs$Variable[which(rec_fs$Diff == min(rec_fs$Diff))]
vars <- vars[-which(vars == exclude)]
return(vars)
}
```

First, we start with all available explanatory variables. The function will print the quality of the model if all variables are used as well as the change of this quality if each of the variables is left out once. The variable which has been left out is included in the respective data row of the output (column "Variable"):

```r
variables <- c("x1", "x2", "x3", "x4")
next_vars <- recursive_feature_selection(data = df, dep = "y", vars = variables)
```

```
##   Variable Adj_R_sqrd     AIC    Diff
## 1      all     0.6199 41.5034  0.0000
## 2       x1     0.6594 39.9925 -1.5109
## 3       x2     0.5588 42.8367  1.3333
## 4       x3     0.6728 39.5482 -1.9552
## 5       x4     0.6410 40.5699 -0.9335
```
As one can see, the adjusted r squared value would increase from 0.6199 for all variables up to 0.6728 if variable x3 is left out. 
This change is also noticeable in the AIC, which decreases from 41.5034 to 39.5482. 
This decrease is also illustrated in the difference column and it was also the AIC criteria which is used as decision basis in the function above. 
The variable `next_vars` now contains only x1, x2 and x4 and we will use this variable to call the recursive feature selection function again:

```r
next_vars
```

```
## [1] "x1" "x2" "x4"
```

```r
next_vars <- recursive_feature_selection(data = df, dep = "y", vars = next_vars)
```

```
##   Variable Adj_R_sqrd     AIC    Diff
## 1      all     0.6728 39.5482  0.0000
## 2       x1     0.5897 41.5066  1.9584
## 3       x2     0.6067 41.0438  1.4956
## 4       x4     0.6826 38.6849 -0.8633
```

This time, the model that uses all three variables (x1, x2, and x4) is the reference and the quality increases compared to this reference if x4 is left out (AIC drops by -0.8633 and the adjusted r squared increases from 0.6728 to 0.6826). Hence, only x1 and x2 will be used in the next iteration:

```r
next_vars
```

```
## [1] "x1" "x2"
```

```r
next_vars <- recursive_feature_selection(data = df, dep = "y", vars = next_vars)
```

```
##   Variable Adj_R_sqrd     AIC   Diff
## 1      all     0.6826 38.6849 0.0000
## 2       x1     0.5158 42.6253 3.9404
## 3       x2     0.6295 39.6814 0.9965
```
In contrast to the first two runs, a further reduction of variables would not increase but decrease the model performance. Hence, the best model to use would be the one with x1 and x2. Please note that - as already stated above - significance of the variables does not matter within this implementation of the recursive feature elimination so the order of x1 and x2 is not determined.
  
  
## Forward feature selection
An alternative approach to the recursive feature selection is the forward feature selection. It starts with an estimation of the individual performance of any explanatory variable. 
The variable with the greatest explanatory power is added to the model equation. 
Subsequently, the remaining variables are again added individually to the existing model equation. 
The variable which leads to the largest increases in the model quality is added to the model equation and the procedure is repeated until no further increase can be observed.

Again, we will use a function to illustrate this approach.

```r
forward_feature_selection <- function(data, dep, vars, selected_vars = NULL){
fwd_fs <- lapply(seq(length(vars)), function(v){
  if(is.null(selected_vars)){
    formula <- paste(dep, " ~ ", paste(vars[v], collapse=" + "))
  } else {
    formula <- paste(dep, " ~ ", paste(c(selected_vars, vars[v]), collapse=" + "))
  }
  
  lmod <- lm(formula, data = data)
  results <- data.frame(Variable = vars[v],
                        Adj_R_sqrd = round(summary(lmod)$adj.r.squared, 4),
                        AIC = round(AIC(lmod), 4))
  return(results)
})
fwd_fs <- do.call("rbind", fwd_fs)

if(!is.null(selected_vars)){
  formula <- paste(dep, " ~ ", paste(selected_vars, collapse=" + "))
  lmod <- lm(formula, data = data)
  results_selected <- data.frame(Variable = paste0("all: ", paste(selected_vars, collapse=", ")),
                                 Adj_R_sqrd = round(summary(lmod)$adj.r.squared, 4),
                                 AIC = round(AIC(lmod), 4))
  fwd_fs <- rbind(results_selected, fwd_fs)
}

print(fwd_fs)

best_var <- as.character(fwd_fs$Variable[which(fwd_fs$AIC == min(fwd_fs$AIC))])
return(best_var)
}
```

For the first call, all explanatory variables x1 to x4 will be passed to the above function:

```r
next_vars <- c("x1", "x2", "x3", "x4")
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars)
```

```
##   Variable Adj_R_sqrd     AIC
## 1       x1     0.6295 39.6814
## 2       x2     0.5158 42.6253
## 3       x3     0.5819 41.0108
## 4       x4     0.1987 48.1661
```
Please note that this time, the variable column does not indicate which variable has been left out but which one has been included. 
Obviously, x1 has the largest explanatory power (adjusted r squared of 0.6295 and AIC of 39.6814). Hence, during the next run, x1 will be included into all models and x2 to x4 will be iterated. 
Technically, this is realized by excluding x1 from the variable `next_vars` and adding it to the variable `selected_vars`.

```r
next_vars <- next_vars[-which(next_vars == act_var)]
selected_vars = act_var
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars,
                                     selected_vars = selected_vars)
```

```
##   Variable Adj_R_sqrd     AIC
## 1  all: x1     0.6295 39.6814
## 2       x2     0.6826 38.6849
## 3       x3     0.5939 41.3942
## 4       x4     0.6067 41.0438
```
If x1 is already included in the model, adding x2 increases the model performance as documented by the increase in the adjusted r squared or the decrease in AIC. 
Hence, x2 is added to the baseline model formula for the next run:

```r
next_vars <- next_vars[-which(next_vars == act_var)]
selected_vars = c(selected_vars, act_var)
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars,
                                     selected_vars = selected_vars)
```

```
##      Variable Adj_R_sqrd     AIC
## 1 all: x1, x2     0.6826 38.6849
## 2          x3     0.6410 40.5699
## 3          x4     0.6728 39.5482
```
Now, neither the additional consideration of x3 nor x4 further increases the performance and the model resulting from this forward feature selection would again be the one with x1 and x2. Please note that this is not a rule. 

## Which feature selection to choose?
The above example leads to the same result regardless if a recursive feature elimination or forward feature selection approach is used. 
This is not a rule! In fact, the variables selected using recursive and forward feature selection can be quite different. So which one to use? 
Basically, the decision has to be made with respect to computer time efficiency and risk of overfitting:

* The recursive feature elimination has some risk of overfitting. 
On the other hand, it scales quite well since many implementations do not re-arrange the variable importance but just leave out one after another based on the initial estimate. Hence, for n independent variables, the computation time is n plus n-1. For 10 independent variables, the computation would encompass a maximum of 19 iterations.
* The forward feature selection has a rather low risk of overfitting. 
On the other hand, it scales terrible since the number of required iterations is given by: 

`(((n-1)^2)+n-1)/2 + (((n-2)^2)+n-2)/2`. 

Hence, for 10 independent variables, a maximum of 81 iterations is already necessary.

One solution to the above dilemma might be an elimination of highly correlated variables first, even if this is not required for the model used in the respective context.
