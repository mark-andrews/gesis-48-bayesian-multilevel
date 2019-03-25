library(readr)
library(dplyr)
library(ggplot2)
library(brms)

Df <- read_csv("../../data/beautyeval.csv")

# Visualize it
ggplot(Df,
       mapping=aes(x=beauty, y=eval, col=sex)) + 
  geom_point() +
  geom_smooth(method='lm') +
  xlab('Lecturer attractiveness') +
  ylab('Teaching evaluation score') +
  ggtitle('Do good looking lecturers get better teaching evaluation score?') +
  theme_classic()


# Classical lm
M_lm <- lm(eval ~ beauty*sex, data=Df)

M_bayes <- brm(eval ~ beauty*sex, 
               data = Df,
               cores = 2, 
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T 
)

# We'll do a model comparison comparing the above 
# model to an additive, i.e. non-interaction, model

M_lm_additive <- lm(eval ~ beauty + sex, data = Df)
M_bayes_additive <- brm(eval ~ beauty + sex, 
               data = Df,
               cores = 2, 
               prior = set_prior('normal(0, 100)'), 
               save_all_pars = T 
)

waic(M_bayes_additive, M_bayes)
loo(M_bayes_additive, M_bayes)
bayes_factor(M_bayes_additive, M_bayes)
