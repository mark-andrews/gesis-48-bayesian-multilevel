library(rstan)
rstan_options(auto_write = TRUE)

ilogit <- function(x) 1/(1+exp(-x))

set.seed(10101)
J <- 25
n <- 250

# the mean and standard deviation of distribution over alpha space
mu <- 0.5
tau <- 1.75

# Generate J samples from normal distribution
alpha <- rnorm(J, mean=mu, sd=tau)

# Convert alpha (which is a log odds) to theta (probability)
theta <- ilogit(alpha)

# sample from J binomial distributions of size n
# prob of "success" for distribution j is theta[j]
m <- sapply(theta,
            function(theta) rbinom(1, size=n, prob=theta)
)

Df <- list(J = J,   # integer
           n = n,   # integer  
           m = m)   # vector of size J

M <- stan(file = 'code/coin_machine.stan', 
          chains = 4,
          warmup = 1000,
          iter = 2000,
          cores = 2,
          data = Df)

print(M, pars=c('mu', 'tau'))

stan_hist(M, pars=c('mu', 'tau'), bins=50)

