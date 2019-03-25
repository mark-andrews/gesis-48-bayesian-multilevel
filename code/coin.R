library(rstan)

Df <- list(n = 250, m = 139)

M <- stan(file = 'code/coin.stan', 
          chains = 4,
          warmup = 1000,
          iter = 2000,
          cores = 2,
          data = Df)

summary(M)
posterior_mean <- summary(M)$summary[1, 1]


plot(M)

stan_hist(M, bins=25)
stan_dens(M)

plot(M, 
     show_density = TRUE, 
     ci_level = 0.95, 
     color = 'red',
     fill_color = "purple")

traceplot(M, 
          inc_warmup = TRUE)


