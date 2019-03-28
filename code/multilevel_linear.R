library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(brms)

mathach <- read_csv('data/mathach.csv')
sleepstudy <- read_csv('data/sleepstudy.csv') %>% 
  mutate(Subject = as.factor(Subject))
fake_rt <- read_csv('data/fake_rt.csv')
science_df <- read_csv('data/science.csv')
penicillin_df <- read_csv('data/penicillin.csv')
insulation_df <- read_csv('data/insulation.csv')

## ------------------------------------------------------------------------
ggplot(fake_rt,
       aes(x = reaction_time, fill = subject)
) + geom_histogram(col='white', binwidth = 10) +
  facet_wrap(~ subject) + guides(fill=F)


## ------------------------------------------------------------------------
ggplot(sleepstudy,
       aes(x=Days, y=Reaction, col=Subject)
) + geom_point() +
  stat_smooth(method='lm', se=F) +
  facet_wrap(~Subject) +
  guides(col=F)


## ------------------------------------------------------------------------
schools <- c('1308', '1946', '7276', '9198', 
             '2917', '9104', '4042', '7635', 
             '8188', '6464', '5838', '9158', 
             '5815', '6808', '6578', '4350')

mathach %>% 
  filter(school %in% schools) %>% 
  mutate(school = as.character(school)) %>% 
  ggplot(aes(x=ses, y=mathach, col=school)
) + geom_point() +
  stat_smooth(method='lm', se=F) +
  facet_wrap(~school) +
  guides(col=F)



# ----- fake_rt -----------------------------

M <- brm(reaction_time ~ 1 + (1|subject),
         cores = 2, 
         prior = set_prior('normal(0, 100)'), 
         save_all_pars = T,
         data = fake_rt)

prior_summary(M)


# ------- mathach --------------------
M <- brm(mathach ~ ses + (ses|school),
         cores = 2, 
         prior = set_prior('normal(0, 100)'), 
         save_all_pars = T,
         data = mathach)

prior_summary(M)

# -------- sleep ---------------------

# ------- mathach --------------------
M <- brm(Reaction ~ Subject + (Reaction|Subject),
         cores = 2, 
         prior = set_prior('normal(0, 100)'), 
         save_all_pars = T,
         data = sleepstudy)

prior_summary(M)


# Random intercepts model
# M_lmer_ri <- lmer(Reaction ~ Days + (1|Subject),
#                   data = Df)

M_ri <- brm(Reaction ~ Days + (1|Subject),
            cores = 2,               
            prior = set_prior('normal(0, 100)'), # flat prior on coefs
            save_all_pars = T,
            data = sleepstudy)

# Random intercepts and random slopes model
# M_lmer <- lmer(Reaction ~ Days + (Days|Subject),
#                data = Df)

M <- brm(Reaction ~ Days + (Days|Subject),
         cores = 2,               
         prior = set_prior('normal(0, 100)'), # flat prior on coefs
         save_all_pars = T,
         data = sleepstudy)


# Model comparison
waic(M_ri, M)
loo(M_ri, M)
bayes_factor(M_ri, M)




# Nested models -----------------------------------------------------------

# Each class is within a school. 
group_by(science_df, school, class) %>% 
  summarise(n = n()) %>% 
  xtabs(n ~ school + class, data=.)


# To model this nesting, we'd do the following:
M <- brm(like ~ sex + PrivPub + (1|school/class), 
           cores = 2,               
           prior = set_prior('normal(0, 100)'),  
           save_all_pars = T,
           data = science_df)

# which is identical to
M <- brm(like ~ sex + PrivPub + (1|school) + (1|school:class), 
           cores = 2,               
           prior = set_prior('normal(0, 100)'),  
           save_all_pars = T,
           data = science_df)

# however, "Class" is unambiguous 

M <- brm(like ~ sex + PrivPub + (1|school) + (1|Class), 
         cores = 2,               
         prior = set_prior('normal(0, 100)'),  
         save_all_pars = T,
         data = science_df)

# here's a hierarchical model with random slopes

M <- brm(like ~ sex + PrivPub + (sex|school) + (sex|Class), 
         cores = 2,               
         prior = set_prior('normal(0, 100)'),  
         save_all_pars = T,
         data = science_df)


# Crossed designs ---------------------------------------------------------

# Crossed designs
group_by(penicillin_df, plate, sample) %>% 
  summarize(n=n()) %>% 
  xtabs(n ~ plate + sample, data=.)

M <- brm(diameter ~ 1 + (1|plate) + (1|sample),
         cores = 2,               
         prior = set_prior('normal(0, 100)', class='Intercept'),  
         save_all_pars = T,
         data = penicillin_df)


# varying intercept and slopes, varying by two groups
ggplot(insulation_df,
       mapping = aes(x = Temp, y = Gas, col = Insul)
) + geom_point() +
  stat_smooth(method = 'lm', se = F)


# Varying slopes by insul (non-multilevel)
M_vsvi <- brm(Gas ~ Temp*Insul, 
              data = insulation_df,
              cores = 2, 
              prior = set_prior('normal(0, 100)'), 
              save_all_pars = T 
)
# Multilevel slopes by insul
M_vsvi_ml <- brm(Gas ~ Temp + (Temp|Insul), 
                 data = insulation_df,
                 cores = 2, 
                 prior = set_prior('normal(0, 100)'), 
                 save_all_pars = T 
)



