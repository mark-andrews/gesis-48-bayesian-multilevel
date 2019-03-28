library(brms)
library(dplyr)
library(readr)

Df <- read_csv("data/diagram.csv") %>% 
  select(-X1)

ggplot(Df,
       aes(x = group, y = descript, col = group)
) + geom_boxplot()


M_null <- brm(descript ~ 1, Df, save_all_pars = T)
summary(M_null)
plot(M_null)

M <- brm(descript ~ group, Df, save_all_pars = T)
summary(M)

plot(M)

# Out of sample predictive performance 
waic(M_null, M)
loo(M_null, M)

# Bayes factor of M_null v M
bayes_factor(M, M_null)

# Directional hypothesis testing
hypothesis(M, "groupPicture < groupSegmentedDiagram")
hypothesis(M, "groupPicture > groupText")
hypothesis(M, "groupSegmentedDiagram + Intercept > Intercept")
hypothesis(M, "groupSegmentedDiagram + Intercept > Intercept + groupText + groupPicture")
hypothesis(M, "groupSegmentedDiagram  > groupText + groupPicture")


# get the old priors
# it has no defined priors for the b coefficients (slopes)
# so Stan probably defaults to a uniform prior which produces problems 
# with Bayes factor calculations
prior_summary(M)

# change the priors for the model
# some new very weakly informative priors
newpriors.i <- c(prior_string("student_t(3, 18, 10)", class = "Intercept"),
                 prior_string("student_t(3, 0, 10)", class = "sigma"))

newpriors <- c(prior_string("student_t(3, 0, 10)", class = "b"),
               prior_string("student_t(3, 18, 10)", class = "Intercept"),
               prior_string("student_t(3, 0, 10)", class = "sigma"))

newpriors.cm <- c(prior_string("student_t(3, 18, 10)", class = "b"),
               prior_string("student_t(3, 0, 10)", class = "sigma"))
                 
M_null.new <- brm(descript ~ 1, Df, save_all_pars = T, prior=newpriors.i)
summary(M_null.new)
plot(M_null.new)

M.new <- brm(descript ~ group, Df, save_all_pars = T, prior=newpriors)
summary(M.new)
plot(M.new)


# now the Bayes factor is not dissimilar 
waic(M_null.new, M.new)
loo(M_null.new, M.new)
bayes_factor(M_null.new, M.new)



# refit the model with a cell means parameterization
# one of the workshop attendees was this fitting this version of the model
# here there is no intercept and the four cell means are estimated as parameters

M.cell <- brm(descript ~ 0 + group, Df, save_all_pars = T, prior=newpriors.cm)
summary(M.cell)
plot(M.cell)

waic(M.cell, M_null.new)
bayes_factor(M.cell, M_null.new)






                 
