library(readr)
library(dplyr)
library(ggplot2)
library(brms)

Df <- read_csv('data/affairs.csv')

ggplot(Df,
       aes(x = yearsmarried, y = affairs, col = gender)
) + stat_smooth()

### Gender 

M <- glm(affairs ~ gender, 
         data=Df, 
         family=poisson)

M_bayes <- brm(affairs ~ gender, 
               data=Df, 
               cores = 2, 
               family = poisson(),
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T)

M_bayes_null <- brm(affairs ~ 1, 
                    data=Df, 
                    cores = 2, 
                    family = poisson(),
                    save_all_pars = T)

waic(M_bayes, M_bayes_null)
bayes_factor(M_bayes, M_bayes_null)

# Gender and age

M <- glm(affairs ~ yearsmarried + gender, 
         data=Df, 
         family=poisson)

M_bayes <- brm(affairs ~ yearsmarried + gender, 
               data=Df, 
               cores = 2, 
               family = poisson(),
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T)

M_bayes_null <- brm(affairs ~ yearsmarried,  
                    data=Df, 
                    cores = 2, 
                    family = poisson(),
                    prior = set_prior('normal(0, 100)'), 
                    save_all_pars = T)

waic(M_bayes, M_bayes_null)
bayes_factor(M_bayes_null, M_bayes)


#### All variables


M_bayes_full <- brm(affairs ~ gender + age + yearsmarried
               + children + religiousness + education
               + occupation + rating,  
               data=Df, 
               cores = 2, 
               family = poisson(),
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T)


#### Nonlinear regression
Ms_1 <- brm(bf(affairs ~ s(yearsmarried, k=3) + gender), 
            data=Df, 
            cores = 2, 
            family = poisson(),
            prior = set_prior('normal(0, 100)'), 
             control = list(adapt_delta = 0.99,
                            max_treedepth = 20),
            save_all_pars = T)

# Consider using

Df$gender <- factor(Df$gender)
Ms_2 <- brm(bf(affairs ~ s(yearsmarried, k=3, by=gender)), 
            data=Df, 
            cores = 2, 
            family = poisson(),
            prior = set_prior('normal(0, 100)'), 
            save_all_pars = T)

#### Zero inflated Poisson model

# Model probability of zero as fixed constant 
Mzip <- brm(affairs ~ gender + age + yearsmarried
            + children + religiousness + education
            + occupation + rating, 
            data = Df, 
            cores = 2, 
            prior = set_prior('normal(0, 100)'), 
            family = zero_inflated_poisson())

# Compare with M_bayes_full above
waic(M_bayes_full, Mzip)

# Model probability of zero a ilogit function of all variables
Mzip2 <- brm(bf(affairs ~ gender + age + yearsmarried
                + children + religiousness + education
                + occupation + rating, 
                zi ~ gender + age + yearsmarried
                + children + religiousness + education
                + occupation + rating), 
             data = Df, 
             cores = 2, 
             prior = set_prior('normal(0, 100)'), 
             family = zero_inflated_poisson())


Mzip <- brm(affairs ~ gender, 
            data = Df, 
            cores = 2, 
            prior = set_prior('normal(0, 100)'), 
            family = zero_inflated_poisson())

M <- brm(affairs ~ gender, 
         data = Df, 
         cores = 2, 
         prior = set_prior('normal(0, 100)'), 
         family = poisson())

M_1 <- brm(bf(affairs ~ gender, zi ~ gender), 
           data = Df, 
           cores = 2, 
           prior = set_prior('normal(0, 100)'), 
           family = zero_inflated_poisson())
