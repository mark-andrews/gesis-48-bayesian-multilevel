library(tibble)
library(brms)

# ------- Data setup --------
set.seed(1001) # Omit or change this if you like

N <- 250

x_1 <- rnorm(N)
x_2 <- rnorm(N)

beta_0 <- 1.25
beta_1 <- 1.75
beta_2 <- 2.25

mu <- beta_0 + beta_1 * x_1 + beta_2 * x_2

y <- mu + rnorm(N, mean=0, sd=1.75)

Df <- tibble(x_1, x_2, y)

# ------ Standard, non-Bayesian, linear regression -------
M_lm <- lm(y ~ x_1 + x_2, data=Df)

# ------ Bayesian linear regression ----------

# Set-up and sample from Bayesian linear model
# using defaults for more or less everything
#M_bayes <- brm(y ~ x_1 + x_2, data = Df)

# Overriding defaults
M_bayes <- brm(y ~ x_1 + x_2, 
               data = Df,
               cores = 2, # I have a dual-core
               chains = 4, # 4 chains is typical
               iter = 2500,
               warmup = 1000, # these are initilization etc iterations
               #prior = set_prior('normal(0, 100)'), # flat prior on coefs
               seed = 101011, # for reproducibility
               save_all_pars = T # needed for bayes_factor
)


# Get the model summary
summary(M_bayes)

# Plot the posteriors etc
plot(M_bayes)

# See plots of e.g. y ~ x_1, y ~ x_2 
marginal_effects(M_bayes)

# View the posterior samples 
posterior_samples(M_bayes)


# Get predictions of the model, using original predictor values
predict(M_bayes)

# predictions with new data, with new predictors
predict(M_bayes, newdata = data.frame(x_1 = c(0, 1, 2), 
                                      x_2 = c(-1, 1, 2))
)
data.frame(x_1 = c(0, 1, 2), 
           x_2 = c(-1, 1, 2))
# We can view the stan code of this model like so:
stancode(M_bayes)

# We can view the priors of this model like this:
prior_summary(M_bayes)


# ------ Model comparison ----------

# Set up a null model
M_bayes_null <- brm(y ~ x_1, 
                    data=Df,
                    cores = 2, # I have a dual-core
                    chains = 4, # 4 chains is typical
                    iter = 2500,
                    warmup = 1000, # these are initilization etc iterations
                    prior = set_prior('normal(0, 100)'), # flat prior on coefs
                    seed = 101013, # for reproducibility
                    save_all_pars = T
)

# Calculate and compare WAIC scores
waic(M_bayes_null, M_bayes)

# Calculate and compare LOO-CV IC scores
loo(M_bayes_null, M_bayes)

# ------ Bayes factors ---------

BF <- bayes_factor(M_bayes_null, M_bayes, log = T)
