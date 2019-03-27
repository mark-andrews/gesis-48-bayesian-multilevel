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

## ---- cache=TRUE, results='hide'-----------------------------------------
M_stan <- stan(file="regression.stan",
               data = model_data,
               pars = c('a', 'b', 'sigma'),
               warmup = 5000,
               iter=10000)


## ------------------------------------------------------------------------
S <- rstan::summary(M_stan)
pander::pander(S$summary)


## ---- message=FALSE------------------------------------------------------
rstan::plot(M_stan)


## ---- message=FALSE------------------------------------------------------
rstan::stan_hist(M_stan)

