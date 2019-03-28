# load packages -----------------------------------------------------------

library(readr)
library(dplyr)
library(brms)


# load data ---------------------------------------------------------------

affairs <- read_csv('data/affairs.csv') %>% 
  mutate(cheater = affairs > 0,
         occupation_category = as.factor(occupation)
  )
science_df <- read_csv('data/science.csv')


# logistic regression -----------------------------------------------------
M <- brm(cheater ~ age + yearsmarried + (1|gender) + (1|occupation_category),
         family = bernoulli(),
         prior = set_prior('normal(0, 100)'),
         cores = 2,
         save_all_pars = T,
         data = affairs)


# Ordinal logistic (because "like" is ordinal really)
M <- brm(like ~ sex + PrivPub + (1|school) + (1|Class),
           cores = 2,
           prior = set_prior('normal(0, 100)'), 
           save_all_pars = T,
           family=cumulative("logit"),
           data = science_df)



# Poisson -----------------------------------------------------------------

M_bayes <- brm(affairs ~ 1 + (1|gender), 
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


#### Zero inflated Poisson model

# Model probability of zero as fixed constant 
Mzip <- brm(affairs ~ 1 + (1|gender), 
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
