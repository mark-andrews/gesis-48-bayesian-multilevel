# Bayesian regression
library(arm)
library(MCMCpack)

n <- 10
x1 <- rnorm(n)
x2 <- rnorm(n)

sigma <- 1.75
b0 <- 1.25
b1 <- 2.25
b2 <- -1.25

y <- b0 + b1*x1 + b2*x2 + rnorm(n, sd=sigma)

M <- bayesglm(y ~ x1 + x2, family=gaussian, prior.mean=0, prior.scale=Inf, prior.df=Inf)
S <- coef(sim(M))
apply(S, 2, mean)

S <- MCMCregress(y ~ x1 + x2, burnin=1000, mcmc=10000, thin=10)
plot(S)

S <- MCMCregress(y ~ x1 + x2, burnin=1000, mcmc=10000, thin=10, 
                 b0=c(0,0,0), B0=c(.01, .01, .01), marginal.likelihood='Chib95')

S.2 <- MCMCregress(y ~ x1, burnin=1000, mcmc=10000, thin=10, 
                 b0=c(0,0), B0=c(.01, .01), marginal.likelihood='Chib95')


M <- BayesFactor(S, S.2)