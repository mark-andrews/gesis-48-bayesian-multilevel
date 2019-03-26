library(rstan)
ilogit <- function(x) 1/(1+exp(-x))

set.seed(10101)
J <- 25
n <- 250
alpha <- rnorm(J, mean=0.5, sd=1.75)
theta <- ilogit(alpha)

m <- sapply(theta,
            function(theta) rbinom(1, size=n, prob=theta)
)

Df <- list(J = J,
           n = 250,
           m = m)

M <- stan(file = 'code/coin_machine.stan', 
          chains = 4,
          warmup = 1000,
          iter = 2000,
          cores = 2,
          data = Df)

print(M, pars=c('mu', 'tau'))

stan_hist(M, pars=c('mu', 'tau'), bins=50)

