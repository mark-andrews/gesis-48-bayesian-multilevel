library(rstan)

rstan_options(auto_write=TRUE)

n <- 250
m <- 139

# Let's pretend this is the observed data vector 
set.seed(10101)
y <- c(rep(1, m), rep(0, n-m))
y <- sample(y) # shuffle it

Df <- list(n = n, 
           y = y,
           alpha = 1,
           beta = 1)

M <- stan(file = 'code/coin_bernoulli.stan', 
          chains = 4,
          warmup = 1000,
          iter = 2000,
          cores = 2,
          data = Df)

# summary of model
summary(M)

# better summary
print(M, pars=c('theta'),
      probs = c(0.025, 0.1, 0.5, 0.9, 0.975)
)


# posterior mean of theta
posterior_mean <- summary(M)$summary[1, 1]

# interval plot
plot(M)

# histogram
stan_hist(M, bins=25)

# density
stan_dens(M)

# Another density plot
plot(M, 
     show_density = TRUE, 
     ci_level = 0.95, 
     color = 'red',
     fill_color = "purple")

# trace plot
traceplot(M, inc_warmup = TRUE)

# Extract samples
samples <- extract(M)$theta
