library(readr)
library(dplyr)
library(ggplot2)
library(brms)

Df <- read_csv('data/insulation.csv')

theme_set(theme_classic())

ggplot(Df,
       mapping = aes(x = Temp, y = Gas, col = Insul)
) + geom_point() +
  stat_smooth(method = 'lm', se = F)


# Classical lm
M_lm <- lm(Gas ~ Temp*Insul, data=Df)

M_bayes <- brm(Gas ~ Temp*Insul, 
               data = Df,
               cores = 2, 
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T 
)

# We'll do a model comparison comparing the above 
# model to an additive, i.e. non-interaction, model

M_lm_additive <- lm(Gas ~ Temp+Insul, data = Df)
M_bayes_additive <- brm(Gas ~ Temp+Insul, 
               data = Df,
               cores = 2, 
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T 
)

waic(M_bayes_additive, M_bayes)
loo(M_bayes_additive, M_bayes)
bayes_factor(M_bayes_additive, M_bayes)
