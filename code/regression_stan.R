library(rstan)
library(ggplot2)
library(dplyr)

rstan_options(auto_write = TRUE)

set.seed(101)

N <- 50
a <- 0.5
b <- 2.25
Df <- tibble(x = rnorm(N),
             y = a + b *x + rnorm(N, mean=0, sd = 1.75)
)

ggplot(Df, 
       mapping = aes(x = x, y = y)) + 
  geom_point() +
  stat_smooth(method='lm') +
  theme_classic()

model_data <- list(N = N, 
                   y = Df %>% pull(y), 
                   x = Df %>% pull(x)
)

## --------------------------------------------
M_stan <- stan(file="code/regression.stan",
               data = model_data,
               pars = c('a', 'b', 'sigma'),
               warmup = 1000,
               iter=2000)

## --- alternative stan model ------------------
M_stan <- stan(file="code/regression_alt.stan",
               data = model_data,
               pars = c('a', 'b', 'sigma'),
               warmup = 1000,
               iter=2000)

## ------------------------------------------------------------------------
summary(M_stan)$summary
print(M_stan, pars=c('a', 'b', 'sigma'))

## ------------------------------------------------------
plot(M_stan)

stan_hist(M_stan,
          pars = c('a'),
          binwidth = 0.05)

stan_dens(M_stan,
          pars = c('b'))

stan_hist(M_stan, bins=50)

