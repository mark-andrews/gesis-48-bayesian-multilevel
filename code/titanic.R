library(readr)
library(dplyr)
library(ggplot2)
library(brms)


Df <- read_csv('data/TitanicSurvival.csv') %>% 
  select(class = passengerClass,
         sex,
         age, 
         survived) %>% 
  mutate(survived = ifelse(survived=='yes', T, F))


# Now, we'll model how the probability of surviving by `sex`:
M <- glm(survived ~ sex, 
         data=Df,
         family=binomial)

M_bayes <- brm(survived ~ sex, 
               data = Df,
               cores = 2, 
               family = bernoulli(),
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T 
)

new_data <- tibble(sex=c('male', 'female'))
predict(M, newdata = new_data, type = 'response')

predict(M_bayes, newdata = new_data)



# We will model Titanic survival using two different models,
# i.e. two models with different numbers of predictors:
M_full <- glm(survived ~ sex*class, # equivalent to sex + class + sex:class
              data=Df, 
              family=binomial)

# This is our comparison model, i.e. no interaction effect
M_null <- glm(survived ~ sex + class, 
              data=Df, 
              family=binomial)


M_bayes_full <- brm(survived ~ sex*class, # equivalent to sex + class + sex:class
                    data=Df,                
                    cores = 2, 
                    family = bernoulli(),
                    prior = set_prior('normal(0, 100)'), 
                    save_all_pars = T)

# This is our comparison model, i.e. no interaction effect
M_bayes_null <- brm(survived ~ sex + class, 
                    data=Df,                
                    cores = 2, 
                    family = bernoulli(),
                    prior = set_prior('normal(0, 100)'), 
                    save_all_pars = T)


waic(M_bayes_null, M_bayes_full)
loo(M_bayes_null, M_bayes_full)
bayes_factor(M_bayes_null, M_bayes_full)

# Some predictions
new_data <- expand.grid(sex = c('male', 'female'),
                        class = c('1st', '2nd', '3rd')
)
predict(M_bayes_full, newdata = new_data)

new_data %>% 
  mutate(predictions = predict(M_bayes_full, newdata = .)[,'Estimate']) %>% 
  ggplot(aes(x = class, y = predictions, col = sex, group=sex)) +
  geom_line() + theme_classic()

new_data %>% 
  mutate(predictions = predict(M_bayes_null, newdata = .)[,'Estimate']) %>% 
  ggplot(aes(x = class, y = predictions, col = sex, group=sex)) +
  geom_line() + theme_classic()
