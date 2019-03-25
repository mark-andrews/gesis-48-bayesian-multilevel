# m Heads in n coin flip
d <- data.frame(m=139, n=250)

# Binomial likelihood and beta prior
Q <- brm(m | trials(n) ~ 1,
         family = binomial(link="identity"),
         prior = set_prior("beta(1, 1)", class = "Intercept"),
         data = d,
         iter = 1e4,
         cores = 4)

# Use binomial logistic regression
# prior on the log odds scale
M <- brm(m | trials(n) ~ 1, 
         prior = set_prior('normal(0, 100)', class = 'Intercept'),
         family = binomial(),
         iter = 1e4,
         cores = 4,
         data=d)
