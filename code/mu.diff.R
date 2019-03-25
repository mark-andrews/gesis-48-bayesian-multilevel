mu.x <- 3.0
mu.y <- 4.25
sigma.x <- 1.75
sigma.y <- 1.25

N <- 1e5

x <- rnorm(N, mean=mu.x, sd=sigma.x)
y <- rnorm(N, mean=mu.y, sd=sigma.y)