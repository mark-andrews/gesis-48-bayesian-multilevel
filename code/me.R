library(tibble)
library(brms)

#set.seed(1010101)
N <- 250

me_sd <- 0.25
sigma <- 1.0
beta_0 <- -1.0
beta_1 <- 1.25

x_true <- rnorm(N)

x_obs <- x_true + rnorm(N, mean=0, sd=me_sd)

mu <- beta_0 + beta_1 * x_true

y <- mu + rnorm(N, mean=0, sd=sigma)

Df <- tibble(x = x_obs, y = y, sdx = me_sd)
# ============================================



M <- brm(y ~ me(x, sdx), 
         data = Df,
         cores = 2, 
         prior = set_prior('normal(0, 100)'))
         
summary(M)

M_w_err <- brm(y ~ x, 
               data = Df,
               cores = 2, 
               prior = set_prior('normal(0, 100)'))

summary(M_w_err)