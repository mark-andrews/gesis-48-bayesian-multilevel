library(lme4)
library(magrittr)
library(ggplot2)
library(brms)

Df <- sleepstudy # rename the data frame

# Visualize it
ggplot(Df,
       aes(x=Days, y=Reaction, col=Subject)
) + geom_point() +
  stat_smooth(method='lm', se=F, size=0.5) +
  facet_wrap(~Subject) +
  theme_classic()



# Random intercepts model
M_lmer_ri <- lmer(Reaction ~ Days + (1|Subject),
                  data = Df)

M_ri <- brm(Reaction ~ Days + (1|Subject),
            cores = 2,               
            prior = set_prior('normal(0, 100)'), # flat prior on coefs
            save_all_pars = T,
            data = Df)

# Random intercepts and random slopes model
M_lmer <- lmer(Reaction ~ Days + (Days|Subject),
               data = Df)

M <- brm(Reaction ~ Days + (Days|Subject),
         cores = 2,               
         prior = set_prior('normal(0, 100)'), # flat prior on coefs
         save_all_pars = T,
         data = Df)


# Model comparison
waic(M_ri, M)
loo(M_ri, M)
bayes_factor(M_ri, M)

# Nested models
Df <- read_csv('data/science.csv')

M_2 <- brm(like ~ sex + PrivPub + (1|school) + (1|Class), 
            cores = 2,               
            prior = set_prior('normal(0, 100)'), # flat prior on coefs
            save_all_pars = T,
            data = Df)


# Ordinal logistic 
# M_3 <- brm(like ~ sex + PrivPub + (1|school) + (1|Class), 
#            cores = 2,               
#            prior = set_prior('normal(0, 100)'), # flat prior on coefs
#            save_all_pars = T,
#            family=cumulative("logit"), 
#            data = Df)


# consider using control = list(adapt_delta = 0.95)

# Multilevel logistic regression
Df %<>% mutate(fast_rt = Reaction < median(Reaction))

M <- brm(fast_rt ~ Days + (Days|Subject),
         family = bernoulli(),
         cores = 2,               
         prior = set_prior('normal(0, 100)'), # flat prior on coefs
         save_all_pars = T,
         data = Df)
